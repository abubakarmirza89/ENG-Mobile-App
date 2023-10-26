// ignore_for_file: prefer_const_constructors

import 'package:engenglish/Globals/Constant.dart';
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Globals/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class Personalinfo extends StatefulWidget {
  const Personalinfo({Key? key}) : super(key: key);

  @override
  State<Personalinfo> createState() => _PersonalinfoState();

}

class _PersonalinfoState extends State<Personalinfo> {
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
          padding: EdgeInsets.symmetric(horizontal: s.w(11), vertical: s.h(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 30,),
              Text(
                "Personal information",
                style: perplr14.copyWith(fontSize: 15),
              ),
              s.HeightSpace(5),
              Text(
                "Basic info, like your name and address, that you use on ENG ENGLISH.",
                style: grey10,
              ),
              s.HeightSpace(20),
              _BasicsContainer(),
              s.HeightSpace(27),
             // _PreContainer()
            ],
          ),
        ),
      ),
    );
  }

  _BasicsContainer() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              color: Colors.grey,
            ),
            child: Row(
              children: [
                Text(
                  "BASICS",
                  style: Boldblack14,
                ),
              ],
            ),
          ),
          s.HeightSpace(18),
          _Basicsrow(title: "Full Name", subtitle: "$namee"),
          s.HeightSpace(10),
          _Basicsrow(title: "Display Name", subtitle: "$displayname"),
          s.HeightSpace(10),
          _Basicsrow(title: "Email", subtitle: "$emaill"),
          s.HeightSpace(10),
          _Basicsrow(title: "Phone Number", subtitle: "$phonenumber"),
          s.HeightSpace(10),
          _Basicsrow(title: "Nationality", subtitle: "$Nationality"),
          s.HeightSpace(10),
          _Basicsrow(
              title: "Address",
              subtitle: "$address"),
          s.HeightSpace(18),
        ],
      ),
    );
  }

  _Basicsrow({required String title, required String subtitle}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: s.w(16)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: grey12,
            ),
          ),
          Expanded(
            child: Text(
              subtitle,
              style: grey12,
            ),
          ),
        ],
      ),
    );
  }

  // _presrow({required String title, required String subtitle}) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: s.w(16)),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Text(
  //             title,
  //             style: grey12,
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             subtitle,
  //             style: grey12,
  //           ),
  //         ),
  //         Icon(
  //           MyFlutterApp.edit,
  //           color: Theme.of(context).primaryColor,
  //         )
  //       ],
  //     ),
  //   );
  // }

  // _PreContainer() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey),
  //       borderRadius: BorderRadius.circular(9),
  //     ),
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(8), topRight: Radius.circular(8)),
  //             color: Colors.grey,
  //           ),
  //           child: Row(
  //             children: [
  //               Text(
  //                 "PREFERENCES",
  //                 style: Boldblack14,
  //               ),
  //             ],
  //           ),
  //         ),
  //         s.HeightSpace(18),
  //         _presrow(title: "Language", subtitle: "English (United State)"),
  //         s.HeightSpace(10),
  //         _presrow(title: "Date Format", subtitle: "M, D, YYYY"),
  //         s.HeightSpace(10),
  //         _presrow(title: "Timezone", subtitle: "Bangladesh (GMT +6:00)"),
  //         s.HeightSpace(18),
  //       ],
  //     ),
  //   );
  // }
}
