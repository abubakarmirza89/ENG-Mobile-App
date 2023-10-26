// ignore_for_file: prefer_const_constructors

import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late dynamicsize s;

  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: s.w(20), vertical: s.h(20)),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quiz",
                style: perplr32,
              ),
              s.HeightSpace(40),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: ApplicationColors),
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [ApplicationColors, Colors.transparent],
                      stops: [
                        0.1,
                        0.6,
                      ],
                    ),
                  ),
                  child: SizedBox(
                    height: 25.0,
                  ),
                ),
              ),
              s.HeightSpace(60),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                        left: s.w(30),
                        right: s.w(30),
                        top: s.h(29),
                        bottom: s.h(20),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.grey.shade200),
                      child: Column(
                        children: [
                          s.HeightSpace(100),
                          Text(
                            "What was the  UX ? ",
                            style: Boldblack16,
                          ),
                          Text(
                            "Question 3/10",
                            style: grey16,
                          ),
                          s.HeightSpace(28),
                          InkWell(
                            onTap: () {
                              routes().GotoReawardScreen(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: ApplicationColors),
                                  color: ApplicationColors.withOpacity(0.4)),
                              child: Center(
                                child: Text(
                                  "User interface",
                                  style: Boldwhite15.copyWith(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          s.HeightSpace(20),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: ApplicationColors),
                                color: ApplicationColors.withOpacity(0.4)),
                            child: Center(
                              child: Text(
                                "User experience",
                                style: Boldwhite15.copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          s.HeightSpace(20),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: ApplicationColors),
                                color: ApplicationColors.withOpacity(0.4)),
                            child: Center(
                              child: Text(
                                "User profile",
                                style: Boldwhite15.copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          s.HeightSpace(20),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: ApplicationColors),
                                color: ApplicationColors.withOpacity(0.4)),
                            child: Center(
                              child: Text(
                                "User design",
                                style: Boldwhite15.copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          s.HeightSpace(60)
                        ],
                      )),
                  SizedOverflowBox(
                    size: Size(s.h(70), s.h(35)),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: s.h(70),
                      width: s.h(70),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.purple.shade900),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                          child: Text(
                        "AD",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
