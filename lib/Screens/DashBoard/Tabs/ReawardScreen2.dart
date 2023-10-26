import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Screens/Course/Coursedetails.dart';
import 'package:flutter/material.dart';

class ReawardScreen2 extends StatefulWidget {
  const ReawardScreen2({Key? key}) : super(key: key);

  @override
  State<ReawardScreen2> createState() => _ReawardScreen2State();
}

class _ReawardScreen2State extends State<ReawardScreen2> {
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
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/Win2.png",
                        height: s.h(100),
                        width: s.w(330),
                      ),
                    ),
                    s.HeightSpace(70),
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
                                      "All time",
                                      style: Boldblack14.copyWith(fontSize: 15),
                                    ),
                                    Text(
                                      "180 Points",
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
                                      "Balance",
                                      style: Boldblack14.copyWith(fontSize: 15),
                                    ),
                                    Text(
                                      "150 Points",
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
                                      "Withdrawn",
                                      style: Boldblack14.copyWith(fontSize: 15),
                                    ),
                                    Text(
                                      "30 Points",
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
                                border:
                                    Border.all(color: Colors.purple.shade900),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                                child: Text(
                              "150\nPoints",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14),
                            )),
                          ),
                        ),
                      ],
                    ),
                    s.HeightSpace(40),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 9),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Course Completion Rewards",
                                    style: grey16,
                                  ),
                                  Text(
                                    "100",
                                    style: grey16,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 9),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Affiliate Points",
                                    style: grey16,
                                  ),
                                  Text(
                                    "20",
                                    style: grey16,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 9),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Quiz Rewards",
                                    style: grey16,
                                  ),
                                  Text(
                                    "40",
                                    style: grey16,
                                  ),
                                ],
                              ),
                            ),
                            s.HeightSpace(30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  InkWell(

                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: s.w(20)),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: ApplicationColors,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "Exchange with ENG TOKEN",
                          style: BoldBlack20.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedOverflowBox(
                    size: Size(s.w(40), s.h(1)),
                    child: Image.asset("assets/images/stars.png"),
                  ),
                ],
              ),
              s.HeightSpace(15),
            ],
          ),
        ),
      ),
    );
  }
}
