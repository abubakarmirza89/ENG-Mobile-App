// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names

import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:flutter/material.dart';

import '../../Globals/Constant.dart';

class SignInScreen2 extends StatefulWidget {
  const SignInScreen2({Key? key}) : super(key: key);

  @override
  State<SignInScreen2> createState() => _SignInScreen2State();
}

class _SignInScreen2State extends State<SignInScreen2> {
  late dynamicsize s;
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();

  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: s.w(35)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: s.h(51),
                ),
                Center(
                    child: Image.asset("assets/images/Logoperple.png",
                        alignment: Alignment.center)),
                SizedBox(
                  height: 1,
                ),
                Center(
                    child: Image.asset("assets/images/LogowithNameperple.png",
                        alignment: Alignment.center)),
                SizedBox(
                  height: s.h(28),
                ),
                Center(
                    child: Text(
                  "Thank you!",
                  style: BoldBlack20,
                )),
                SizedBox(
                  height: 3,
                ),
                Center(
                    child: Text(
                  "Your Registration is Successful",
                  style: BoldBlack20,
                )),
                SizedBox(
                  height: s.h(22),
                ),
                Center(
                    child: Text(
                  "You can now sign in with your ID and Password",
                  style: Boldgreen13,
                )),
                SizedBox(
                  height: s.h(44),
                ),
                Text(
                  "Email or Username",
                  style: Boldblack13,
                ),
                SizedBox(
                  height: s.h(5),
                ),
                textfield(
                    hint: '',
                    controller: Emailcontroller,
                    fillcolor: Color(0xFFD9D9D9)),
                SizedBox(
                  height: s.h(32),
                ),
                Text(
                  "Password",
                  style: Boldblack13,
                ),
                SizedBox(
                  height: s.h(5),
                ),
                textfield(
                    hint: '',
                    controller: Passwordcontroller,
                    fillcolor: Color(0xFFD9D9D9)),
                SizedBox(
                  height: s.h(28),
                ),
                InkWell(
                  onTap: () {
                    routes().GotodashboardScreen(context);
                  },
                  child: Container(
                    height: s.h(52),
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
                  height: s.h(30),
                ),
                Center(
                    child: Text(
                  "OR",
                  style: Boldblack13,
                )),
                SizedBox(
                  height: s.h(14),
                ),
                Row(
                  children: [
                    Expanded(
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
                    SizedBox(
                      width: s.w(24),
                    ),
                    Expanded(
                      child: Container(
                        height: s.h(47),
                        decoration: BoxDecoration(
                            color: GoogleColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          "Google",
                          style: Boldwhite15,
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: s.h(50),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Terms and Condition",
                      style: perplr12,
                    ),
                    Text(
                      "Privicy Policy",
                      style: perplr12,
                    ),
                    Text(
                      "Help",
                      style: perplr12,
                    ),
                    Text(
                      "English ^",
                      style: grey12,
                    ),
                  ],
                ),
                SizedBox(
                  height: s.h(22),
                ),
                Center(
                    child: Text(
                  "© 2022 Hybrid Hub Technologies. All Rights Reserved.",
                  style: grey12,
                )),
                SizedBox(
                  height: s.h(13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
