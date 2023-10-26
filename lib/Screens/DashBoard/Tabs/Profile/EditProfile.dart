import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:engenglish/Globals/globals.dart' as globals;
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';

import '../../Dashboard.dart';



class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late bool isLoading;
  late Map<String, dynamic> userProfileData;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController titleController;
  late TextEditingController surnameController;
  late TextEditingController imageController;
  late TextEditingController birthdateController;
  late TextEditingController nationalityController;
  late TextEditingController addressController;


  String selectedTitle = ''; // This variable will store the selected value
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    userProfileData = {};
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    surnameController = TextEditingController();
    imageController = TextEditingController();
    birthdateController = TextEditingController();
    nationalityController = TextEditingController();
    addressController = TextEditingController();


    fetchUserProfileData();
  }

  Future<void> fetchUserProfileData() async {
    try {
      final userID = globals.userID; // Replace with your user ID variable
      final apiUrl = 'http://engenglish.com/api/users/student/profile/$userID';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          userProfileData = data;
          isLoading = false;
          // Populate text controllers with fetched data
          nameController.text = userProfileData['name'] ?? '';
          emailController.text = userProfileData['email'] ?? '';
          phoneController.text = userProfileData['phone'] ?? '';
          selectedTitle = userProfileData['title'] ??
              'Mr'; // Default to 'Mr' if not available
          birthdateController.text = userProfileData['birthdate'] ?? '';
          nationalityController.text = userProfileData['nationality'] ?? '';
          addressController.text = userProfileData['address'] ?? '';

          // Update the profile image URL if it's available in the response
          if (data.containsKey('image')) {
            userProfileData['image'] = data['image'];
          }
        });
      }

      else {
        print('API Request Error - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('API Request Error - Exception: $e');
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> updateProfileData() async {
    try {
      final userID = globals.userID; // Replace with your user ID variable
      final apiUrl = 'http://engenglish.com/api/users/edit/$userID';

      // Create a new multipart request
      final request = http.MultipartRequest('PUT', Uri.parse(apiUrl));

      // Include the selected title as a field
      request.fields['title'] = selectedTitle;

      // Add text fields to the request
      request.fields['name'] = nameController.text;
      request.fields['email'] = emailController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['surname'] = surnameController.text;
      request.fields['birthdate'] = birthdateController.text;
      request.fields['nationality'] = nationalityController.text;
      request.fields['address'] = addressController.text;

      // Check if a new image file was selected
      if (selectedImage != null) {
        // Create a multipart file from the selected image
        final mimeType = lookupMimeType(selectedImage!.path) ?? 'image/jpeg';
        final file = await http.MultipartFile.fromPath(
          'image',
          selectedImage!.path,
          contentType: MediaType.parse(mimeType),
        );

        // Add the image file to the request
        request.files.add(file);
      }

      // Send the multipart request
      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle successful update here
        print('Profile updated successfully');
      } else {
        print('API Request Error - Status Code: ${response.statusCode}');
        print('Response Body: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      print('API Request Error - Exception: $e');
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    // Dispose of text controllers
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    surnameController.dispose();
    imageController.dispose();
    birthdateController.dispose();
    nationalityController.dispose();
    addressController.dispose();
    super.dispose();
  }
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: CustomAppBar(scaffoldKey: scaffoldKey,),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: pickImage,
                child: selectedImage != null
                    ? CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(selectedImage!),
                )
                    : CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person),
                ),
              ),
              DropdownButton<String>(
                value: selectedTitle,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTitle = newValue!;
                  });
                },
                items: <String>[
                  'Mr',
                  'Mrs',
                  'Miss',
                  'Dr',
                  'Prof'
                ] // Add your options here
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: surnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: birthdateController,
                decoration: InputDecoration(labelText: 'Birthday'),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              // Add more form fields for other profile data
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: updateProfileData,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
