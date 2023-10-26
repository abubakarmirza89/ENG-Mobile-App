import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:flutter/material.dart';

class ReawardScreen extends StatefulWidget {
  const ReawardScreen({Key? key}) : super(key: key);

  @override
  State<ReawardScreen> createState() => _ReawardScreenState();
}

class _ReawardScreenState extends State<ReawardScreen> {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              s.HeightSpace(100),
              Center(
                child: Image.asset(
                  "assets/images/Win.png",
                  height: s.h(350),
                  width: s.w(330),
                ),
              ),
              Text(
                "You have completed all of \n your lessons.",
                style: BoldBlack20,
                textAlign: TextAlign.center,
              ),
              Text(
                "We are proud of you",
                style: BoldBlack20.copyWith(color: ApplicationColors),
                textAlign: TextAlign.center,
              ),
              s.HeightSpace(30),
              InkWell(
                onTap: () {
                  routes().GotodashboardScreen(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: s.w(100)),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: yelloContainercolor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "Study more",
                      style: BoldBlack20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
