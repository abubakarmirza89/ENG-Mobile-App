// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:async';
import 'package:engenglish/Globals/prefernces.dart';
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart'as http;
import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Screens/DashBoard/Dashboard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Globals/Constant.dart';
import '../DashBoard/Tabs/Profile/StudentProfile.dart';
import '../Auth/forgetpassword.dart'; // Import your ForgetPassword screen
import '../../Globals/globals.dart' as globals; // Import the globals.dart file


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late dynamicsize s;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  bool _obscureText = false;

  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    super.initState();
  }

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
                    height: s.h(51),
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
                    "Sign-In",
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
                    height: s.h(34),
                  ),
                  Row(
                    children: [
                      Text(
                        "Email or Username",
                        style: Boldwhite11,
                      ),
                      Spacer(),

                    ],
                  ),
                  SizedBox(
                    height: s.h(5),
                  ),
                  _emailTextfield(context),
                  SizedBox(
                    height: s.h(32),
                  ),
                  Row(
                    children: [
                      Text(
                        "Password",
                        style: Boldwhite11,
                      ),
                      Spacer(),
                      Center(
                      child: InkWell(
                      onTap: () {
                      routes().GotoforgetScreen(context);
                      },

                      child: RichText(
                        text: TextSpan(
                          style: Boldperple11,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Forget',
                            ),
                            TextSpan(text: ' Passcode ', style: BoldYellow11),
                            TextSpan(text: '?'),
                          ],
                        ),
                      ),
                      ),
                      ),
                      // Text("Forget passcode ?",style: BoldYellow11,),
                    ],
                  ),
                  SizedBox(
                    height: s.h(5),
                  ),
                  _passwordTextfield(context),
                  SizedBox(
                    height: s.h(47),
                  ),
                  InkWell(
                    onTap: () async {
                      await _signInWithEmailAndPassword();
                    },
                    child: Container(
                      height: s.h(47),
                      decoration: BoxDecoration(
                          color: SigninColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        "Sign in",
                        style: Boldwhite20,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: s.h(18),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        routes().GotoSignupScreen(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Boldwhite12,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'New on our platform?',
                                style: Boldyellow12),
                            TextSpan(text: '  Create an account '),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: s.h(13),
                  ),
                  Center(
                      child: Text(
                    "OR",
                    style: white12,
                  )),
                  SizedBox(
                    height: s.h(13),
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
                    height: s.h(67),
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
                    height: s.h(57),
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
  Widget _emailTextfield(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 1, right: 1, left: 1),
        child: CustomtextField(
          focusNode: emailNode,
          textInputAction: TextInputAction.next,
          controller: emailController,
          hintText: 'Enter Email',
          prefixIcon: Icon(
            Icons.person,
            color: iconColor,
            size: 30.0,
          ),
        )
    );
  }
  Widget _passwordTextfield(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 1, right: 1, left: 1),
        child: CustomtextField(
          focusNode: passwordNode,
          maxLines: 1,
          controller: passwordController,
          obscureText: !_obscureText,
          hintText: 'Enter Password',
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
        )
    );
  }





  Future<void> _signInWithEmailAndPassword() async {

      var uri = Uri.parse(
          'http://engenglish.com/api/users/login/');
      var request = new http.MultipartRequest("POST", uri);
      Map<String, String> headers = {
        "Accept": "application/json",
      };
      request.headers.addAll(headers);
      request.fields['email'] = emailController.text;
      request.fields['password'] = passwordController.text;
      // Define email and password variables
      String email = emailController.text;
      String password = passwordController.text;

      // Check if email and password are not empty
      if (email.isEmpty || password.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sign-in Failed'),
            content: Text('Please enter both email and password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return; // Exit the function if fields are empty
      }

// API Request
      var response = await request.send();
      print(response.statusCode);
      String responseData = await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      print(responseData);
      print(userData['detail'].toString());

    if (userData['detail'].toString() == "Login successful.") {
      // Extract user_type from the response
      final userResponse = userData['response'];
      final user_type = userResponse['user_type'];
      final user_id = userResponse ['id'];
      final access_token = userResponse['access_token'];

      // Store user_type in the global variable
      globals.userType = user_type;
      globals.userID = user_id.toString();
      globals.accessToken = access_token;

      // Save user data in SharedPreferences (if needed)
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(SharedPreferencesKey.LOGGED_IN_USERRDATA, userData.toString());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashBoard(InitialPage: 0)),
        );
      }
      else if(userData['detail'].toString()=="Invalid credentials."){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sign-in Failed'),
            content: Text('Invalid email or password'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
      else{
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sign-in Failed'),
            content: Text('Server Error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    // var url = Uri.parse("https://");
    //
    // try {
    //   // setState(() {
    //   //   isLoading = true;
    //   // });
    //   FirebaseMessaging.instance.getToken().then((token) async {
    //     print(token);
    //     final response = await client.post(url,
    //         body: {
    //       "email": emailController.text,
    //       "password": passwordController.text,
    //       "device_token": token,
    //     }
    //     );
    //     print('*****************' + token! + '*****************');
    //
    //     if (response.statusCode == 200) {
    //       setState(() {
    //         isLoading = false;
    //       });
    //       Map<String, dynamic> dic = json.decode(response.body);
    //       print(response.body);
    //
    //       if (dic['response_code'] == "1") {
    //         String userResponseStr = json.encode(dic);
    //         SharedPreferences preferences =
    //         await SharedPreferences.getInstance();
    //         preferences.setString(
    //             SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
    //
    //         print("PRINT DIC>>>>>>>>>>>>> $dic");
    //         // Loader().hideIndicator(context);
    //         setState(() {
    //           isLoading = false;
    //         });
    //         //Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0);
    //
    //       } else {
    //         // Loader().hideIndicator(context);
    //         setState(() {
    //           isLoading = false;
    //         });
    //         toast("Error", "Wrong Email / Phone Number, Please try agains",
    //             context);
    //       }
    //     } else {
    //       // Loader().hideIndicator(context);
    //       setState(() {
    //         isLoading = false;
    //       });
    //       toast("Error", "Cannot communicate with server", context);
    //     }
    //   });
    //
    //   // final response = await client.post('${baseUrl()}/login', body: {
    //   //   "phone": emailController.text,
    //   //   "password": passwordController.text
    //   // });
    //
    // } catch (e) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   toast("Error", e.toString(), context);
    // }
  }

  // Function to show the error popup
  Future<void> _showErrorPopup(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
              'This SignIn Method is not available now. Please try again later. Sorry for the inconvenience.'),
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
