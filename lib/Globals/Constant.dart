// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:another_flushbar/flushbar.dart';
import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

int Application_type = 1;
Color? iconColor = Colors.grey[800];
Color appColor = Colors.green;
Client client = Client();
String ?namee;
String ?emaill;
String ?lastlogin;
String ? imagee;
String? displayname;
String? phonenumber;
String? Nationality;
String? address;
String baseUrl() {
  return 'http://';
}

class CustomtextField extends StatefulWidget {
  final TextInputType ? keyboardType;
  final void Function() ? onTap;
  final FocusNode ? focusNode;
  final TextInputAction ? textInputAction;
  final void Function() ?onEditingComplate;
  final void Function(String) ? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final dynamic onChange;
  final String ? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget ?suffixIcon;

  final Widget? prefixIcon;

  CustomtextField({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _CustomtextFieldState createState() => _CustomtextFieldState();
}

class _CustomtextFieldState extends State<CustomtextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(color: Colors.black, fontSize: 14),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        errorStyle: TextStyle(color: Colors.white),
        errorText: widget.errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
            color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w700),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0.0,
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
      ),
    );
  }
}
TextFormField textfield(
    {required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int? line,
    EdgeInsets padding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    TextStyle hintstyle = const TextStyle(
        color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w700),
    Color fillcolor = Colors.white,
    Widget? leading}) {
  return TextFormField(
    minLines: line,
    maxLines: line,
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      fillColor: fillcolor,
      filled: true,
      prefixIcon: leading,
      hintText: hint,
      hintStyle: hintstyle,
      contentPadding: padding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
      ),
    ),
  );
}

AppBar appbar(
    {required Widget title,
    required Widget action,
    required Widget leading,
    required BuildContext context}) {
  return AppBar(
    backgroundColor: Theme.of(context).bottomAppBarColor,
    elevation: 0,
    // flexibleSpace: Container(
    //   decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //           begin: Alignment.topCenter,
    //           end: Alignment.bottomCenter,
    //           colors: <Color>[
    //             Color(0xFFAEABAB),
    //
    //             Colors.transparent
    //           ])
    //   ),
    // ),
    leading: leading,
    centerTitle: true,
    title: title,
    actions: [
      SizedBox(
        width: 20,
      ),
      action,
      SizedBox(
        width: 20,
      )
    ],
  );
}
toast(title, msg, BuildContext context) {
  Flushbar(
    title: title,
    message: msg,
    titleColor: Colors.grey,
    messageColor: Colors.black,
    icon: Icon(
      title == "Error" ? Icons.error : Icons.check,
      color: Colors.grey,
    ),
    backgroundColor: Colors.grey,
    duration: Duration(seconds: 2),
  ).show(context);
}
Widget ColoredContainer(String txt, MaterialColor color, BuildContext context
//     {
//   required Color color,
//   required Color bordercolor,
//   required Widget txt,
// }
    ) {
  return Container(
    height: dynamicsize(context, 844, 390).h(40),
    width: dynamicsize(context, 844, 390).h(40),
    decoration: BoxDecoration(
        color: color.shade200,
        border: Border.all(color: color.shade900),
        borderRadius: BorderRadius.circular(4)),
    child: Center(
        child: Text(
      txt,
      style: TextStyle(
          color: color.shade900, fontWeight: FontWeight.w700, fontSize: 10),
    )),
  );
}

Widget ColoredContainerwhitetxt(
    {required String txt, required Color color, required BuildContext context}
//     {
//   required Color color,
//   required Color bordercolor,
//   required Widget txt,
// }
    ) {
  return Container(
    height: dynamicsize(context, 844, 390).h(60),
    width: dynamicsize(context, 844, 390).h(60),
    decoration: BoxDecoration(
        color: color,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(6)),
    child: Center(
        child: Text(
      txt,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
    )),
  );
}

Widget RoundedColoredContainer(
    String txt, MaterialColor color, BuildContext context
//     {
//   required Color color,
//   required Color bordercolor,
//   required Widget txt,
// }
    ) {
  return Container(
    height: dynamicsize(context, 844, 390).h(50),
    width: dynamicsize(context, 844, 390).h(50),
    decoration: BoxDecoration(
        color: color.shade200,
        border: Border.all(color: color.shade900),
        borderRadius: BorderRadius.circular(50)),
    child: Center(
        child: Text(
      txt,
      style: TextStyle(
          color: color.shade900, fontWeight: FontWeight.w700, fontSize: 10),
    )),
  );

}
class CustomButtom extends StatelessWidget {
  final Color? color;
  final String? title;
  final Function? onPressed;

  CustomButtom({
    this.color,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return InkWell(
      onTap: () {
        onPressed;
      },
      child: Container(
        //height: s.h(47),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
              title!,
              style: Boldwhite20,
            )),
      ),
    );
    //   LegacyRaisedButton(
    //   color: color,
    //   child: Text(
    //     title,
    //     style: TextStyle(
    //         fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
    //   ),
    //   shape: RoundedRectangleBorder(
    //     // side: BorderSide(color: appColorGreen, width: 0),
    //     borderRadius: BorderRadius.circular(5),
    //   ),
    //   onPressed: onPressed,
    // );
  }
}
simpleAlertBox({required BuildContext context, Widget ?title, Widget ? content}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          // ignore: deprecated_member_use
          MaterialButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}