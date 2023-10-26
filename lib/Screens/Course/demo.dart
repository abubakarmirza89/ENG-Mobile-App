import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Constant.dart';
import 'package:engenglish/Globals/Expansiotile.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Globals/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  bool expand = false;
  late dynamicsize s;
  TextEditingController CoursetitleController = TextEditingController();

  @override
  void initState() {
    _controller = ExpandedTileController(isExpanded: expand);
    s = dynamicsize(context, 844, 390);
    super.initState();
  }

  late ExpandedTileController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ExpandedTile(
        theme: ExpandedTileThemeData(
            headerColor: ApplicationColors,
            headerdecoration: BoxDecoration(
                borderRadius: expand
                    ? BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))
                    : BorderRadius.circular(8),
                color: expand ? ApplicationColors : Color(0xffC9C9C9)),
            headerPadding: EdgeInsets.all(8),
            trailingPadding: EdgeInsets.zero,
            contentPadding:
                EdgeInsets.symmetric(horizontal: s.w(18), vertical: s.h(8)),
            contentDecoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                border: Border.all(color: Colors.grey))),
        controller: _controller,
        title: Text(
          "Course Info",
          style: Boldwhite20.copyWith(
              fontSize: 18, color: expand ? Colors.white : Colors.black),
        ),
        trailing: Icon(
          MyFlutterApp.play,
          color: expand ? Colors.white : Colors.black,
          size: 13,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Course Title",
              style: perplr14.copyWith(fontWeight: FontWeight.w800),
            ),
            s.HeightSpace(7),
            textfield(
              padding: EdgeInsets.symmetric(horizontal: 10),
              hint: "Course Title",
              controller: CoursetitleController,
            ),
            s.HeightSpace(7),
            Text(
              "Course Slug",
              style: perplr14.copyWith(fontWeight: FontWeight.w800),
            ),
            s.HeightSpace(7),
            textfield(
              padding: EdgeInsets.symmetric(horizontal: 10),
              hint: "Course Slug",
              controller: CoursetitleController,
            ),
            s.HeightSpace(7),
            Text(
              "About Course",
              style: perplr14.copyWith(fontWeight: FontWeight.w800),
            ),
            s.HeightSpace(7),
            textfield(
              line: 4,
              padding: EdgeInsets.symmetric(horizontal: 10),
              hint: "About Course",
              controller: CoursetitleController,
            ),
            s.HeightSpace(7),
            Text(
              "Course Category",
              style: perplr14.copyWith(fontWeight: FontWeight.w800),
            ),
            s.HeightSpace(7),
            textfield(
              padding: EdgeInsets.symmetric(horizontal: 10),
              hint: "Course Category",
              controller: CoursetitleController,
            ),
            s.HeightSpace(7),
            Text(
              "Course Thumbnail",
              style: perplr14.copyWith(fontWeight: FontWeight.w800),
            ),
            s.HeightSpace(7),
            textfield(
              padding: EdgeInsets.symmetric(horizontal: 10),
              hint: "Course Thumbnail",
              controller: CoursetitleController,
            ),
            s.HeightSpace(7),
          ],
        ),
        onTap: () {
          setState(() {
            expand = !expand;
          });
        },
        onLongTap: () {
          debugPrint("long tapped!!");
        },
      ),
    );
  }




}
