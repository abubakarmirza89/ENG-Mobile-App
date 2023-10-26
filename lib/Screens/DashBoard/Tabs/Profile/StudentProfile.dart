import 'dart:convert';
import 'package:engenglish/Screens/Auth/Google_sign.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:engenglish/Globals/globals.dart' as globals;
import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Constant.dart';

import '../../../../Globals/Routes.dart';
import '../../../../Globals/Textstyle.dart';
import '../../../../Globals/my_flutter_app_icons.dart';
import '../../../../utils/packages/Size/dynamic_size.dart';
import 'EditProfile.dart';



class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late bool isLoading;
  late Map<String, dynamic> userProfileData;
  late dynamicsize s;
  TextEditingController Searchcontroller = TextEditingController();


  @override
  void initState() {
    super.initState();
    s = dynamicsize(context, 844, 390);
    isLoading = true;
    userProfileData = {};
    fetchUserProfileData();
  }

  Future<void> fetchUserProfileData() async {
    try {
      // Get the user ID from globals.dart
      final userId = globals.userID;

      // Replace with your API endpoint URL using the user ID
      final apiUrl = 'http://engenglish.com/api/users/student/profile/$userId';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          userProfileData = data;
          isLoading = false;
        });
      } else {
        // Handle API request error here
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Handle network or API request error here
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: s.w(11), vertical: s.h(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                s.HeightSpace(10),
                textfield(
                    hint: "Search anything",
                    controller: Searchcontroller,
                    leading: Icon(Icons.search)),
                s.HeightSpace(30),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey, width: 1),
                          shape: BoxShape.circle),
                      child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: isLoading
                              ? CircleAvatar(
                            // backgroundColor: Colors.white,
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                    userProfileData['name'].length >= 2
                                      ? userProfileData['name'].substring(0, 2).toUpperCase()
                                      : userProfileData['name'].toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10),
                                ),
                              )
                          ) :
                          CircleAvatar(
                            backgroundImage:
                            userProfileData['profileImage'],
                            radius: 30,
                          )
                      ),
                    ),
                    // Container(
                    //   height: s.h(50),
                    //   width: s.h(50),
                    //   decoration: BoxDecoration(
                    //       color: Theme.of(context).primaryColor,
                    //       border: Border.all(color: Colors.purple.shade900),
                    //       borderRadius: BorderRadius.circular(50)),
                    //   child: Center(
                    //       child:Image.network("$imagee")
                    //   ),
                    //   // child: Center(
                    //   //     child: Text(
                    //   //       "AB",
                    //   //       style: TextStyle(
                    //   //           color: Colors.white,
                    //   //           fontWeight: FontWeight.w700,
                    //   //           fontSize: 10),
                    //   //     )
                    //   ),
                    // ),


                    SizedBox(
                      width: s.w(6),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isLoading ? SizedBox(
                            child: CircularProgressIndicator(),
                            height: 15,
                            width: 15,
                          ) :
                          Column(
                            children: [
                              Text(
                                userProfileData['name'],
                                style: Boldblack16.copyWith(
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                userProfileData['email'],
                                style: grey12,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                   ],
                ),
                s.HeightSpace(31),
                Text(
                  "TOTAL Spent",
                  style: grey14,
                ),
                s.HeightSpace(4),
                Text(
                  "Paid 0.00 USD",
                  style: perplr14,
                ),

                s.HeightSpace(29),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: s.w(20), vertical: s.h(10)),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Column(
                    children: [
                      s.HeightSpace(30),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));                        },
                        child: _Profilerow(
                            title: Text(
                              "Personal information",
                              style: grey16,
                            ),
                            icon: ClipOval(
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    color: Colors.grey.shade400,
                                    child: Icon(
                                      Icons.person_outline,
                                      color: Colors.white,
                                    )))),
                      ),
                      s.HeightSpace(23),
                      _Profilerow(
                          title: Text(
                            "Courses",
                            style: grey16,
                          ),
                          icon: ClipOval(
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset(
                                    "assets/images/Course.png",
                                    height: 25,
                                  )))),
                      s.HeightSpace(23),
                      _Profilerow(
                          title: Text(
                            "Account activity ",
                            style: grey16,
                          ),
                          icon: ClipOval(
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(
                                    MyFlutterApp.restore,
                                    color: Colors.grey,
                                  )))),
                      s.HeightSpace(23),
                    ],
                  ),
                ),
                s.HeightSpace(35),
                Text(
                  "LAST LOGIN",
                  style: grey10,
                ),
                s.HeightSpace(6),
                Text(
                  "$lastlogin",
                  style: grey12.copyWith(color: Color(0xFF7B7979)),
                ),
                s.HeightSpace(22),
                Text(
                  "LOGIN IP",
                  style: grey10,
                ),
                s.HeightSpace(6),
                Text(
                  "192.129.243.28",
                  style: grey12.copyWith(color: Color(0xFF7B7979)),
                ),
                s.HeightSpace(22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _Profilerow({required Widget icon, required Text title}) {
    return Row(
      children: [icon, s.WidthSpace(10), Expanded(child: title)],
    );
  }

}