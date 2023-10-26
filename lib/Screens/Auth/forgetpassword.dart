import 'package:flutter/material.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Colors.dart';


class ForgetPasscodeScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
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
                margin: EdgeInsets.symmetric(horizontal: 35),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 51),
                      Center(
                        child: Image.asset(
                          "assets/images/Logo.png",
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: 1),
                      Center(
                        child: Image.asset(
                          "assets/images/LogowithName.png",
                          alignment: Alignment.center,
                        ),
                      ),
                      SizedBox(height: 29),
                      Text(
                        "Forget Passcode",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SigninColor,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "To Reset Your Passcode",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 34),
                      Text(
                        "Enter Email",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      _emailTextfield(context),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Implement the logic to submit the email for reset here.
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple, // Adjust the color
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate back to the login screen or any other desired screen.
                              routes().GotoSigninScreen(context);
                            },
                            child: Text(
                              "Back to Login",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: SigninColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailTextfield(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1, right: 1, left: 1),
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter Email',
          filled: true,
          fillColor: Colors.white, // Adjust the background color
        ),
      ),
    );
  }
}
