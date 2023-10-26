
import 'dart:convert';

import 'package:engenglish/Globals/prefernces.dart';
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Globals/Constant.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late dynamicsize s;
  bool isLoading = false;
  String ?type_user;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _obscureText = false;
  bool checkedValue = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agree = false;

  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    super.initState();
  }

  String dropdownvalue = 'Select User Type';

  // List of items in our dropdown menu
  var type_user1 = [
    'student',
    'instructor',
  ];

  // Map to convert the displayed value to API value
  final Map<String, String> typeMapping = {
    'Student': 'student',
    'Instructor': 'instructor',
  };

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "assets/images/Signin.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: s.w(35)),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: s.h(31),
                  ),
                  Center(
                      child: Image.asset("assets/images/Logo.png",
                          alignment: Alignment.center)),
                  SizedBox(
                    height: 1,
                  ),
                  Center(
                      child: Image.asset("assets/images/LogowithName.png",
                          alignment: Alignment.center)),
                  SizedBox(
                    height: s.h(29),
                  ),
                  Text(
                    "Register",
                    style: BoldYellow20,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "To Access the ENG ENGLISH",
                    style: Boldwhite14,
                  ),
                  SizedBox(
                    height: s.h(16),
                  ),
                  Text(
                    "Full Name",
                    style: Boldwhite11,
                  ),
                  SizedBox(
                    height: s.h(5),
                  ),
                  _nameTextfield(context),
                  SizedBox(
                    height: s.h(10),
                  ),
                  Text(
                    "Email",
                    style: Boldwhite11,
                  ),
                  SizedBox(
                    height: s.h(5),
                  ),
                  _emailTextfield(context),
                  SizedBox(
                    height: s.h(12),
                  ),
                  Text(
                    "Password",
                    style: Boldwhite11,
                  ),
                  SizedBox(
                    height: s.h(5),
                  ),
                  _passwordTextfield(context),
                  SizedBox(
                    height: s.h(10),
                  ),
                  Text(
                    "Select Type",
                    style: Boldwhite11,
                  ),
                  SizedBox(
                    height: s.h(5),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
    // DropdownButton for user type selection
   child: DropdownButtonHideUnderline(
    child: DropdownButton<String>(
    value: type_user,
    isDense: true,
    hint: Padding(
    padding: const EdgeInsets.only(top: 0),
    child: Text(
    'User',
    style: TextStyle(color: Colors.grey[600], fontSize: 14),
    ),
    ),
    icon: Padding(
    padding: const EdgeInsets.only(right: 0, top: 1),
    child: Icon(
    Icons.arrow_drop_down,
    color: Colors.black,
    ),
    ),
    onChanged: (String? newValue) {
    setState(() {
    type_user = newValue;
    });
    },
    items: type_user1.map((item) {
    return DropdownMenuItem<String>(
    child: Text(
    _capitalizeFirstLetter(item),
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.grey[600]),
    ),
    value: item,
    );
    }).toList(),
    ),
                      ),

                    // child: DropdownButton(
                    //   // Initial Value
                    //   underline: SizedBox(),
                    //   value: dropdownvalue,
                    //   dropdownColor: Colors.white,
                    //   borderRadius: BorderRadius.circular(8),
                    //   // Down Arrow Icon
                    //   icon: const Icon(Icons.keyboard_arrow_down),
                    //   isExpanded: true,
                    //   // Array list of items
                    //   items: items.map((String items) {
                    //     return DropdownMenuItem(
                    //       value: items,
                    //       child: Text(items),
                    //     );
                    //   }).toList(),
                    //   // After selecting the desired option,it will
                    //   // change button value to selected value
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       dropdownvalue = newValue!;
                    //     });
                    //   },
                    // ),
                  ),
                  SizedBox(
                    height: s.h(15),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        margin: EdgeInsets.only(right: 10, left: 5),
                        color: Colors.white,
                        child: Checkbox(
                          value: agree,
//                          activeColor: Colors.white,
                          onChanged: (bool? value) {
                            setState(() {
                              agree = value!;
                            });
                          },
                        ),
                      ),
                      Text(
                        "I agree to ENG ENGLISH Privacy Policy & Terms.",
                        style: Boldwhite11,
                      ) //Checkbox
                    ],
                  ),
                  SizedBox(
                    height: s.h(54),
                  ),
                  _loginButton(context),
                  // InkWell(
                  //   onTap: ()  {
                  //     //likeVoting();
                  //     _apiCall();
                  //     //_loginButton(context);
                  //     //routes().GotoSigninScreen2(context);
                  //   },
                  //   child: Container(
                  //     height: s.h(47),
                  //     decoration: BoxDecoration(
                  //         color: SigninColor,
                  //         borderRadius: BorderRadius.circular(8)),
                  //     child: Center(
                  //         child: Text(
                  //       "Register",
                  //       style: Boldwhite20,
                  //     )),
                  //   ),
                  // ),
                  SizedBox(
                    height: s.h(14),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {

                        //routes().GotoSigninScreen(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Boldwhite12,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Already have an account ?',
                                style: Boldyellow12),
                            TextSpan(text: ' Sign in instead'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: s.h(10),
                  ),
                  Center(
                      child: Text(
                    "OR",
                    style: white12,
                  )),
                  SizedBox(
                    height: s.h(8),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Show the error popup
                            _showErrorPopup(context);
                          },

                          child: Container(
                            height: s.h(47),
                            decoration: BoxDecoration(
                                color: FacebookColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                                child: Text(
                                  "Facebook",
                                  style: Boldwhite15,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: s.w(24),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Show the error popup
                            _showErrorPopup(context);
                          },
                          child: Container(
                            height: 47,
                            decoration: BoxDecoration(
                              color: GoogleColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Google",
                                style: Boldwhite15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: s.h(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            routes().GotoTermsScreen(context);
                          },
                          child:
                          Text(
                            "Terms and Conditions",
                            style: white12,
                          ),
                        ),
                      ),

                      Center(
                        child: InkWell(
                          onTap: () {
                            routes().GotoprivacyScreen(context);
                          },
                          child:
                          Text(
                            "Privacy Policy",
                            style: white12,
                          ),
                        ),
                      ),

                      Text(
                        "English",
                        style: white12,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: s.h(18),
                  ),
                  Center(
                      child: Text(
                    "© 2022 Hybrid Hub Technologies. All Rights Reserved.",
                    style: white12,
                  )),
                  SizedBox(
                    height: s.h(13),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
  Widget _nameTextfield(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 1, right: 1, left: 1),
        child: CustomtextField(
          maxLines: 1,
          textInputAction: TextInputAction.next,
          controller: nameController,
          hintText: 'Enter Full Name',
          prefixIcon: Icon(
            Icons.person,
            color: iconColor,
            size: 30.0,
          ),
        ));
  }
  Widget _passwordTextfield(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
        child: CustomtextField(
          textInputAction: TextInputAction.next,
          controller: passwordController,
          maxLines: 1,
          hintText: 'Enter Password',
          obscureText: !_obscureText,
          prefixIcon: Icon(
            Icons.lock,
            color: iconColor,
            size: 30.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ));
  }
  Widget _emailTextfield(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, left: 0),
      child: CustomtextField(
        maxLines: 1,
        textInputAction: TextInputAction.next,
        controller: emailController,
        hintText: 'Enter Email',
        prefixIcon: Icon(
          Icons.email,
          color: iconColor,
          size: 30.0,
        ),
      ),
    );
  }
  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 0, left: 20),
        child: SizedBox(
          height:s.h(47),
          child: InkWell(
            child: Container(
              height: s.h(47),
              decoration: BoxDecoration(
                  color: SigninColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                    "Register",
                    style: Boldwhite20,
                  )),
            ),
            onTap: () {

                print("button runnnnnnnnnnnnnnnnnnnnnn");
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern.toString());


                if (passwordController.text != '' &&
                    nameController.text != '' &&
                    regex.hasMatch(emailController.text.trim()) &&
                    emailController.text.trim() != '' &&
                    passwordController.text.length > 5 && agree
                ) {
                  _apiCall();
                } else {
                  if (nameController.text.isEmpty)
                    simpleAlertBox(
                        content: Text("Please enter username"),
                        context: context);
                   else if (emailController.text.isEmpty) {
                   simpleAlertBox(
                     content: Text("Please enter email"), context: context);
                  }
                   else if (passwordController.text.isEmpty) {
                  simpleAlertBox(
                  content: Text(
                  "Password Field is empty or password length should be between 6-8 characters."),
                  context: context);
                  }

                  else if (!agree) {
                    simpleAlertBox(
                        content: Text(
                            "Please Agree to Terms & Conditions and Privacy Policy"),
                        context: context);
                  }
                   else {
                    simpleAlertBox(
                        content: Text(
                            "Please enter valid email and Password. Password should be 6-8 characters, with a capital, small letters, a number and a special character"),
                        context: context);
                  }
                }
              }
              ,
          ),
        ),
      ),
    );
  }

  Future<void> _apiCall() async {
    setState(() {
      isLoading = true;
    });
    FirebaseMessaging.instance.getToken().then((token) async {
      print(token.toString());
      try {
        var uri = Uri.parse('http://engenglish.com/api/users/signup/');
        var request = new http.MultipartRequest("POST", uri);
        Map<String, String> headers = {
          "Accept": "application/json",
        };
        request.headers.addAll(headers);
        request.fields['email'] =
            emailController.text.toLowerCase().trim().toString();
        request.fields['password'] = passwordController.text;
        request.fields['name'] = nameController.text;
        request.fields['user_type'] = type_user.toString();
        var response = await request.send();
        print(response.statusCode);
        String responseData = await response.stream.transform(utf8.decoder).join();
        var userData = json.decode(responseData);
        print(responseData);
        print(userData['success'].toString());
        if (userData['success'] == "User created successfully") {
          SharedPreferences preferences =
          await SharedPreferences.getInstance();
          preferences.setString(
              SharedPreferencesKey.LOGGED_IN_USERRDATA, userData.toString());

          // Show a Popup to indicate success
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('User registered successfully. Proceed to Login Page.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else if (userData['error'] == "user with this email address already exists.") {
          // Show a dialog to indicate that the user already exists
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('User already exists. Please sign in instead.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle other API responses as needed...

          // Show an error popup for any other response
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Successful'),
                content: Text('Account Created Successfully. Please proceed to Login.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        if (mounted)
          setState(() {
            isLoading = false;
          });
        toast("Error", e.toString(), context);

        // Show an error popup for any exception
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Registration Successful'),
              content: Text('Account Created Successfully. Please proceed to Login'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }


  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }
  String _capitalizeFirstLetter(String input) {
    return input[0].toUpperCase() + input.substring(1);
  }
  // Function to show the error popup
  Future<void> _showErrorPopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
              'This Signup Method is not available now. Please try again later. Sorry for the inconvenience.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}
