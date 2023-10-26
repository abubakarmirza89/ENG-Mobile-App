// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:engenglish/Screens/Auth/SigninScreen.dart';
import 'package:engenglish/Screens/Auth/SigninScreen2.dart';
import 'package:engenglish/Screens/Auth/SignupScreen.dart';
import 'package:engenglish/Screens/Auth/forgetpassword.dart';
import 'package:engenglish/Screens/Cart/Cart.dart';
import 'package:engenglish/Screens/Course/Addcourse.dart';
import 'package:engenglish/Screens/Course/CourseBuilder.dart';
import 'package:engenglish/Screens/Course/CourseCategory.dart';
import 'package:engenglish/Screens/Course/Coursedetails.dart';
import 'package:engenglish/Screens/Course/Courselectur.dart';
import 'package:engenglish/Screens/DashBoard/Dashboard.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Profile/EditProfile.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Profile/Personalinfo.dart';
import 'package:engenglish/Screens/Others/privacy.dart';
import 'package:engenglish/Screens/Others/terms.dart';
import 'package:engenglish/Screens/Quiz/QuestionScreen.dart';
import 'package:engenglish/Screens/Quiz/QuizScreen.dart';
import 'package:engenglish/Screens/Quiz/ReawardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/DashBoard/Tabs/Courselist.dart';

class routes {
  GotoSignupScreen(BuildContext context) =>
      _backfalse(context, () => SignupScreen());
  GotoforgetScreen(BuildContext context) =>
      _backfalse(context, () => ForgetPasscodeScreen());
  GotoSigninScreen(BuildContext context) =>
      _backfalse(context, () => SignInScreen());

  GotoSigninScreen2(BuildContext context) =>
      _backfalse(context, () => SignInScreen2());

  GotodashboardScreen(BuildContext context) =>
      _backfalse(context, () => DashBoard(InitialPage: 0));

  GotoPersonalInfo(BuildContext context) => _backtrue(
        context,
        () => Personalinfo(),
      );


  GotoCourseBuilder(BuildContext context) => _backtrue(
    context,
        () => CourseBuilderScreen(),
  );

  GotoCourseLacture(BuildContext context, int courseId, String accessToken) => _backtrue(
    context,
        () => LectureView(courseId: courseId, accessToken: accessToken),
  );


  GotoAddCourse(BuildContext context) => _backtrue(
        context,
        () => AddCourse(),
      );

  GotoCart(BuildContext context) => _backtrue(
        context,
        () => CartScreen(),
      );

  GotoQuiz(BuildContext context) => _backtrue(
        context,
        () => QuizScreen(),
      );

  GotoCourseCategory(BuildContext context) => _backtrue(
        context,
        () => CourseCategory(),
      );

  GotoQuestionScreen(BuildContext context) => _backfalse(
        context,
        () => QuestionScreen(),
      );

  GotoReawardScreen(BuildContext context) => _backfalse(
        context,
        () => ReawardScreen(),
      );
  GotoprivacyScreen(BuildContext context) => _backfalse(
    context,
        () => PrivacyScreen(),
  );

  GotoTermsScreen(BuildContext context) => _backfalse(
    context,
        () => TermsScreen(),
  );
  GotoEditProfile(BuildContext context) => _backfalse(
    context,
        () => EditProfilePage(),
  );
  _backfalse(BuildContext context, Function() screen) =>
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => screen(),
          ));

  _backtrue(BuildContext context, Function() screen) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen(),
      ));
}
