// ignore_for_file: prefer_const_constructors

import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
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
                s.HeightSpace(80),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: s.w(5),
                        right: s.w(5),
                        top: s.h(29),
                        bottom: s.h(20),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Course",
                                  style: Boldblack14.copyWith(fontSize: 15),
                                ),
                                Text(
                                  "UX UI Design",
                                  style: grey10,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: s.h(67),
                            width: 1,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Attempt ",
                                  style: Boldblack14.copyWith(fontSize: 15),
                                ),
                                Text(
                                  "2",
                                  style: grey10,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: s.h(67),
                            width: 1,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Lecture",
                                  style: Boldblack14.copyWith(fontSize: 15),
                                ),
                                Text(
                                  "Lecture Name Here",
                                  style: grey10,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          "UX",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        )),
                      ),
                    ),
                  ],
                ),
                s.HeightSpace(40),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "number of  Quiz",
                        style: grey16,
                      ),
                      Text(
                        "15",
                        style: grey16,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "number of  Question",
                        style: grey16,
                      ),
                      Text(
                        "250",
                        style: grey16,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "number of  right answer",
                        style: grey16,
                      ),
                      Text(
                        "190",
                        style: grey16,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "number of  Wrong answer",
                        style: grey16,
                      ),
                      Text(
                        "60",
                        style: grey16,
                      ),
                    ],
                  ),
                ),
                s.HeightSpace(60),
                InkWell(
                  onTap: () {
                    routes().GotoQuestionScreen(context);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: s.w(20)),
                    padding: EdgeInsets.symmetric(vertical: s.h(8)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ApplicationColors,
                    ),
                    child: Center(
                      child: Text(
                        "Start Quiz",
                        style: Boldwhite20.copyWith(fontSize: 24),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
