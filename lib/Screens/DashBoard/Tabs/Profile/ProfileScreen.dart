// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:engenglish/Screens/Auth/Google_sign.dart';
import 'package:engenglish/Model/instructur_profile.dart';
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';
import 'package:http/http.dart'as http;
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Globals/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import '../../../../Globals/Constant.dart';
import '../../../../Model/profile.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late dynamicsize s;
  bool isLoading = true;
  late instructorr modall;
  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    _getData();
    super.initState();
  }
  _getData() async {
    try {
      String url = "http://engenglish.com/api/users/instructor/profile/$userId";
      http.Response res = await http.get(Uri.parse(url));
      print(res.statusCode);
      if (res.statusCode == 200) {
        modall = instructorr.fromJson(json.decode(res.body));
        namee = modall.name.toString();
        emaill=modall.email.toString();
        lastlogin=modall.lastLogin.toString();
        imagee=modall.profileImage.toString();
        displayname=modall.surname.toString();
        phonenumber=modall.phone.toString();
        Nationality=modall.nationality.toString();
        address=modall.address.toString();
        isLoading  = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: s.w(11), vertical: s.h(20)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: s.h(50),
                    width: s.h(50),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Colors.purple.shade900),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      "AB",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 10),
                    )),
                  ),
                  SizedBox(
                    width: s.w(6),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isLoading?SizedBox(
                          child:CircularProgressIndicator(),
                          height: 15,
                          width: 15,
                        ):
                        Column(
                          children: [
                            Text(
                              "$namee",
                              style: Boldblack16.copyWith(
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Text(
                              "$emaill",
                              style: grey12,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              s.HeightSpace(31),
              Text(
                "ACCOUNT BALANCE",
                style: grey10,
              ),
              s.HeightSpace(4),
              Text(
                "0.00 USD",
                style: perplr14.copyWith(fontSize: 16),
              ),
              s.HeightSpace(7),
              Text(
                "Pending 0.00 USD",
                style: grey10,
              ),
              s.HeightSpace(29),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: s.w(20), vertical: s.h(10)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  children: [
                    s.HeightSpace(30),
                    InkWell(
                      onTap: () {
                        routes().GotoPersonalInfo(context);
                      },
                      child: _Profilerow(
                          title: Text(
                            "Personal information",
                            style: perplr14.copyWith(fontSize: 16),
                          ),
                          icon: ClipOval(
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  color: Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                  )))),
                    ),
                    s.HeightSpace(23),
                    _Profilerow(
                        title: Text(
                          "notifications",
                          style: grey16,
                        ),
                        icon: ClipOval(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  MyFlutterApp.bell,
                                  color: Colors.grey,
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
                    _Profilerow(
                        title: Text(
                          "Security Setting",
                          style: grey16,
                        ),
                        icon: ClipOval(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  MyFlutterApp.verified_user,
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
    );
  }

  Widget _Profilerow({required Widget icon, required Text title}) {
    return Row(
      children: [icon, s.WidthSpace(10), Expanded(child: title)],
    );
  }
}
