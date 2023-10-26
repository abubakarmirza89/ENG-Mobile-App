import 'dart:convert';
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';
import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Constant.dart';
import 'package:engenglish/Globals/Expansiotile.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Globals/my_flutter_app_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:engenglish/Globals/globals.dart' as globals;
import 'package:video_player/video_player.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  late dynamicsize s;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController CoursetitleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController introVideoUrlController = TextEditingController();
  TextEditingController captionFileController = TextEditingController();
  TextEditingController introVideoController = TextEditingController();

  File? selectedThumbnail; // Define a variable to hold the selected thumbnail image
  FilePickerResult? selectedIntroVideo;
  File? selectedImage; // Define a variable to hold the selected image


  bool? isIntroVideoFromDevice = true;
  String? selectedCategory;
  String? selectedSubcategory;
  List<String> categoryOptions = []; // List to store category options
  List<String> subcategoryOptions = []; // List to store subcategory options


  void submitForm() async {
    // Get the user ID from your globals.dart
    int userId = int.parse(globals.userID); // Convert the string to an integer

    // Create the course data object
    Map<String, dynamic> courseData = {
      'title': titleController.text,
      'description': descriptionController.text,
      'user': userId,
      'category': selectedCategory,
      'subcategory': selectedSubcategory,
      'price': priceController.text,
      'discount': discountController.text,
      'thumbnail': selectedImage != null ? selectedImage!.path : '', // Include the selected thumbnail image path if it's not null
      'intro_video': isIntroVideoFromDevice == true
          ? selectedIntroVideo != null ? selectedIntroVideo!.files.first.path : ''
          : introVideoUrlController.text, // Include the intro video path based on the source
      // Add other required fields like category and subcategory
    };


    // Make a POST request to the API
    final response = await http.post(
      Uri.parse('http://engenglish.com/api/courses/create-course/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${globals.accessToken}',
      },
      body: jsonEncode(courseData),
    );

    if (response.statusCode == 200) {
      // Course added successfully
      print('Course added successfully');
    } else {
      // Error handling, handle the response here
      print('Failed to add course');
      print(response.body);
    }
  }

  // Function to handle thumbnail selection
  Future<void> selectThumbnail() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedThumbnail = File(pickedFile.path); // Create a File from the pickedFile's path
      });
    }
  }

  void handleIntroVideoSelection(FilePickerResult? result) {
    // Store the selected video result
    selectedIntroVideo = result;

    // You can also do additional handling here, such as displaying the selected video's details or saving it.
  }

  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: s.w(20), vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Course Info Tile
                    _courseInfoTile(),
                    // Course Category Tile
                    _courseCategoryTile(),
                    // Media Tile
                    _mediaTile(),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    submitForm();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: s.w(20),
                      vertical: s.h(10),
                    ),
                    decoration: BoxDecoration(
                      color: ApplicationColors,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Publish",
                      style: TextStyle(
                        color: Colors.white, // Set the text color to white
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: s.w(20),
                      vertical: s.h(10),
                    ),
                    decoration: BoxDecoration(
                      color: AppredColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Discard",
                      style: TextStyle(
                        color: Colors.white, // Set the text color to white
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  _courseInfoTile() {
    bool expand = true;

    ExpandedTileController _controller =
        ExpandedTileController(isExpanded: expand);
    return StatefulBuilder(builder: (context, state) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ExpandedTile(
          theme: ExpandedTileThemeData(
              headerColor: ApplicationColors,
              headerdecoration: BoxDecoration(
                  borderRadius: expand
                      ? BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))
                      : BorderRadius.circular(8),
                  color: expand ? ApplicationColors : Color(0xffC9C9C9)),
              headerPadding: EdgeInsets.all(8),
              trailingPadding: EdgeInsets.zero,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: s.w(18), vertical: s.h(8)),
              contentDecoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  border: Border.all(color: Colors.grey))),
          controller: _controller,
          title: Text(
            "Course Info",
            style: Boldwhite20.copyWith(
                fontSize: 18, color: expand ? Colors.white : Colors.black),
          ),
          trailing: Icon(
            MyFlutterApp.play,
            color: expand ? Colors.white : Colors.black,
            size: 13,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course Title",
                style: perplr14.copyWith(fontWeight: FontWeight.w800),
              ),
              s.HeightSpace(7),
              textfield(
                padding: EdgeInsets.symmetric(horizontal: 10),
                hint: "Course Title",
                controller: titleController,
              ),
              s.HeightSpace(7),

              Text(
                "About Course",
                style: perplr14.copyWith(fontWeight: FontWeight.w800),
              ),
              s.HeightSpace(7),
              textfield(
                line: 10,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hint: "Course Description",
                controller: descriptionController,
              ),
              s.HeightSpace(7),

              Text(
                "Course Price",
                style: perplr14.copyWith(fontWeight: FontWeight.w800),
              ),
              s.HeightSpace(7),
              CustomtextField(
                keyboardType: TextInputType.number,
                controller: priceController,
                hintText: "Course Price",

              ),
              s.HeightSpace(7),


              Text(
                "Discount % ",
                style: perplr14.copyWith(fontWeight: FontWeight.w800),
              ),
              s.HeightSpace(7),
              CustomtextField(
                keyboardType: TextInputType.number,
                controller: discountController,
                hintText: "Add 0 if there is no Discount",
              ),
              s.HeightSpace(7),




            ],
          ),
          onTap: () {
            state(() {
              expand = !expand;
            });
          },
          onLongTap: () {
            debugPrint("long tapped!!");
          },
        ),
      );
    });
  }




  _courseCategoryTile() {
    bool expand = true;

    ExpandedTileController _controller =
    ExpandedTileController(isExpanded: expand);
    return StatefulBuilder(builder: (context, state) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ExpandedTile(
          theme: ExpandedTileThemeData(
              headerColor: ApplicationColors,
              headerdecoration: BoxDecoration(
                  borderRadius: expand
                      ? BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))
                      : BorderRadius.circular(8),
                  color: expand ? ApplicationColors : Color(0xffC9C9C9)),
              headerPadding: EdgeInsets.all(8),
              trailingPadding: EdgeInsets.zero,
              contentPadding:
              EdgeInsets.symmetric(horizontal: s.w(18), vertical: s.h(8)),
              contentDecoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  border: Border.all(color: Colors.grey))),
          controller: _controller,
          title: Text(
            "Course Category",
            style: Boldwhite20.copyWith(
                fontSize: 18, color: expand ? Colors.white : Colors.black),
          ),
          trailing: Icon(
            MyFlutterApp.play,
            color: expand ? Colors.white : Colors.black,
            size: 13,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            DropdownButton<String>(
                value: selectedCategory,
                items: categoryOptions.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                   selectedCategory = newValue;
                  });
                },
                hint: Text("Select Category"),
              ),
              DropdownButton<String>(
                value: selectedSubcategory,
                items: subcategoryOptions.map((String subcategory) {
                  return DropdownMenuItem<String>(
                    value: subcategory,
                    child: Text(subcategory),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSubcategory = newValue;
                  });
                },
                hint: Text("Select Subcategory"),
              ),
            ],
          ),
          onTap: () {
            state(() {
              expand = !expand;
            });
          },
          onLongTap: () {
            debugPrint("long tapped!!");
          },
        ),
      );
    });
  }




  _mediaTile() {
    bool expand = true;

    ExpandedTileController _controller =
    ExpandedTileController(isExpanded: expand);



    return StatefulBuilder(builder: (context, state) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ExpandedTile(
          theme: ExpandedTileThemeData(
            headerColor: ApplicationColors,
            headerdecoration: BoxDecoration(
              borderRadius: expand
                  ? BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
                  : BorderRadius.circular(8),
              color: expand ? ApplicationColors : Color(0xffC9C9C9),
            ),
            headerPadding: EdgeInsets.all(8),
            trailingPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.symmetric(
              horizontal: s.w(18),
              vertical: s.h(8),
            ),
            contentDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border.all(color: Colors.grey),
            ),
          ),
          controller: _controller,
          title: Text(
            "Add Media",
            style: Boldwhite20.copyWith(
              fontSize: 18,
              color: expand ? Colors.white : Colors.black,
            ),
          ),
          trailing: Icon(
            MyFlutterApp.play,
            color: expand ? Colors.white : Colors.black,
            size: 13,
          ),
      content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // Thumbnail Input
        thumbnailInput(
          context
        ),
        // Radio Buttons for Video Source

        introVideoSelection(
          isIntroVideoFromDevice!,
              (value) {
            state(() {
              isIntroVideoFromDevice = value;
            });
          },
        ),
      // Intro Video Input (conditionally visible)
        Visibility(
          visible: isIntroVideoFromDevice ?? false,
          child: introVideoInput(context, selectedIntroVideo, (result) {
            // Handle the selected video result here
            selectedIntroVideo = result;
          }),
        ),

        Visibility(
          visible: !(isIntroVideoFromDevice ?? false),
          child: introVideoURL(context, introVideoUrlController)
        ),

        // Caption File Input
        captionFileInput(
          context,
          captionFileController,
              (FilePickerResult? result) {
            // Handle the selected caption file result here
            if (result != null) {
              // Process the result, for example, you can access the files using `result.files`
              for (var file in result.files) {
                print('File path: ${file.path}');
              }
            }
          },
        ),

      // Radio Buttons for Video Source

      ],
      ),

          onTap: () {
            state(() {
              expand = !expand;
            });
          },
          onLongTap: () {
            debugPrint("long tapped!!");
          },
        ),
      );
    });
  }


  Widget thumbnailInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Thumbnail",
          style: perplr14.copyWith(fontWeight: FontWeight.w800),
        ),
        s.HeightSpace(7),
        InkWell(
          onTap: () async {
            final XFile? image = await ImagePicker().pickImage(
              source: ImageSource.gallery,
            );
            if (image != null) {
              setState(() {
                selectedImage = File(image.path); // Store the selected image
              });
            } else {
              // Show an error message or provide feedback if needed
            }
          },
          child: Container(
            width: double.infinity,
            height: 150, // Set the height as per your design
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              image: selectedImage != null
                  ? DecorationImage(
                image: FileImage(selectedImage!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: selectedImage == null
                ? Stack(
              alignment: Alignment.center,
              children: [
                // Light grey cover
                Container(
                  color: Colors.grey.withOpacity(0.2),
                ),
                // Text over the cover
                Text(
                  "Select your thumbnail",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
                : null,
          ),
        ),
        s.HeightSpace(7),
      ],
    );
  }





  Widget introVideoInput(BuildContext context, FilePickerResult? selectedVideo, Function(FilePickerResult?) onVideoSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Intro Video",
          style: perplr14.copyWith(fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 7),
        InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['mp4'],
            );

            onVideoSelected(result); // Pass the selected video result to the callback function
          },
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.2),

            ),

            child: Center(
              child: selectedVideo != null
                  ? Text(
                "Selected Video: ${selectedVideo.files.single.name}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )




                  : Text(
                "Select Intro Video (MP4 only)",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 7),
      ],
    );
  }





  Widget captionFileInput(BuildContext context, TextEditingController controller, Function(FilePickerResult?) onFileSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Caption File",
          style: perplr14.copyWith(fontWeight: FontWeight.w800),
        ),
        s.HeightSpace(7),
        InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['srt', 'vtt', 'sub', 'sbv', 'ssa', 'ass'], // Add supported subtitle file extensions
            );

            onFileSelected(result); // Pass the selected caption file result to the callback function
          },
          child: Container(
            width: double.infinity,
            height: 50, // Set the height as per your design
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.2),

            ),
            child: Center(
              child: Text(
                "Select Caption File (SRT, VTT, etc.)",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        s.HeightSpace(7),
      ],
    );
  }



  Widget introVideoURL(BuildContext context, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Intro Video URL",
          style: perplr14.copyWith(fontWeight: FontWeight.w800),
        ),
        s.HeightSpace(7),
        // You can replace CustomtextField with the appropriate widget for selecting a caption file from the device
        CustomtextField(
          hintText: "Add Intro Video URL",
          controller: introVideoUrlController,
          onTap: () {
            // Add logic to select a caption file from the device
          },
        ),
        s.HeightSpace(7),
      ],
    );
  }




  Widget introVideoSelection(bool isSelected, void Function(bool?) onChanged) {
    return Row(
      children: [
        Radio<bool>(
          value: true,
          groupValue: isSelected,
          onChanged: onChanged,
        ),
        Text("Intro Video"),
        SizedBox(width: 20),
        Radio<bool>(
          value: false,
          groupValue: isSelected,
          onChanged: onChanged,
        ),
        Text("Intro Video URL"),
      ],
    );
  }





}

