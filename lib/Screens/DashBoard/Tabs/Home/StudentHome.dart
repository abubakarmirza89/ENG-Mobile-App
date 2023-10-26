import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';
import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Constant.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Globals/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:engenglish/Globals/globals.dart' as globals;

import '../../../Course/Courselectur.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class Course {
  final int id;
  final String title;
  final String subtitle;
  final int progress;
  final String imageUrl; // Add an image URL field

  Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.imageUrl,
  });
}

class _StudentHomeState extends State<StudentHome> {
  late dynamicsize s;
  TextEditingController Searchcontroller = TextEditingController();
  late List<Course> courses = [];
  int activeCount = 0;
  int completedCount = 0;

  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    super.initState();
    fetchStudentDashboardData();
  }

  Future<void> fetchStudentDashboardData() async {
    final userId = globals.userID;
    final apiUrl = 'http://engenglish.com/api/users/student/dashboard/$userId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final courseData = jsonData['courses'];

        final List<Course> fetchedCourses = courseData.map<Course>((data) {
          return Course(
            id: data['id'] ?? 0, // Provide a default value if 'id' is null
            title: data['course_name'] ?? '', // Provide a default value if 'course_name' is null
            subtitle: data['course_description'] ?? '', // Provide a default value if 'course_description' is null
            progress: data['course_progress'] ?? 0, // Provide a default value if 'course_progress' is null
            imageUrl: data['course_thumbnail'] ?? '', // Provide a default value if 'course_thumbnail' is null
          );
        }).toList();

        setState(() {
          courses = fetchedCourses;
          activeCount = jsonData['active_courses'] ?? 0; // Provide a default value if 'active_courses' is null
          completedCount = jsonData['course_details']?.length ?? 0; // Provide a default value if 'course_details' is null
        });
      } else {
        print('API Request Error - Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.w(11),   vertical: s.h(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textfield(
              hint: "Search anything",
              controller: Searchcontroller,
              leading: Icon(Icons.search),
            ),
            SizedBox(
              height: s.h(17),
            ),
            Row(
              children: [
                _teleContainer(
                  title: "Enrolled",
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  subtitleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  subtitle: "$activeCount Courses",
                  color: Darkyellow,
                ),
                s.WidthSpace(14),
                _teleContainer(
                  title: "Active",
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  subtitleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  subtitle: "$activeCount Courses",
                  color: SigninColor,
                ),
                s.WidthSpace(14),
                _teleContainer(
                  title: "Completed",
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  subtitleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  subtitle: "$completedCount Courses",
                  color: Darkyellow,
                ),
              ],
            ),
            SizedBox(
              height: s.h(23),
            ),
            Text(
              "In Progress Courses",
              style: perplr14.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: s.h(25),
            ),
            _buildCourseList(),
          ],
        ),
      ),
    );
  }

  Widget _teleRow({
    required String title,
    required String subtitle,
    required int value,
    required String imageUrl, // Add image URL parameter
  }) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover, // This will ensure the image covers the entire square
          ),
        ),
        s.WidthSpace(20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: grey24,
              ),
              s.HeightSpace(10),
              Text(
                subtitle,
                style: grey14,
              ),
              s.HeightSpace(10),
              LinearProgressIndicator(
                value: value / 100,
              ),
              s.HeightSpace(10),
              value == 100
                  ? _StartCourseButton()
                  : Text(
                "${value}% complete",
                style: grey12,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _StartCourseButton() {
    return Container(
      height: s.h(32),
      padding: EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: ApplicationColors,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Start Course",
            style: Boldwhite14.copyWith(fontSize: 17),
          ),
          s.WidthSpace(5),
          Icon(
            MyFlutterApp.play,
            color: Colors.white,
            size: 15,
          ),
        ],
      ),
    );
  }

  Widget _teleContainer({
    required String title,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
    required String subtitle,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7),
        height: s.h(77),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            s.HeightSpace(4),
            Text(
              subtitle,
              style: subtitleStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LectureView(
                  courseId: course.id,
                  accessToken: globals.accessToken, // Pass the access token
                ),
              ),
            );
          },
          child: _teleRow(
            title: course.title,
            subtitle: course.subtitle,
            value: course.progress,
            imageUrl: course.imageUrl,
          ),
        );
      },
    );
  }


  Widget _AfterTotalEarning({
    required String title,
    required String data,
    required String txt,
    required String subdata,
    required bool visible,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 22),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: perplr14,
          ),
          SizedBox(
            height: s.h(12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data,
                style: Black16,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        replacement: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(MyFlutterApp.trending_flat, color: AppredColor),
                        ),
                        visible: !visible,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            MyFlutterApp.trending_flat,
                            color: AppgreenColor,
                          ),
                        ),
                      ),
                      Visibility(
                        replacement: Text(
                          txt,
                          style: red12,
                        ),
                        visible: !visible,
                        child: Text(
                          txt,
                          style: green12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    subdata,
                    style: grey10,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _TotalEarning() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Earning",
            style: BoldBlack20,
          ),
          SizedBox(
            height: s.h(18),
          ),
          Row(
            children: [
              Expanded(
                child: _totalEarningColumn(
                  title: "Monthly",
                  txt: "9.28K",
                  subtitle: "4.63%",
                  visible: true,
                ),
              ),
              Expanded(
                child: _totalEarningColumn(
                  title: "Weekly",
                  txt: "2.69K",
                  subtitle: "1.92%",
                  visible: false,
                ),
              ),
              Expanded(
                child: _totalEarningColumn(
                  title: "Daily (Avg)",
                  txt: "0.94K",
                  subtitle: "3.45%",
                  visible: true,
                ),
              ),
            ],
          ),
          SizedBox(
            height: s.h(40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "01 Jul, 2020",
                style: grey12,
              ),
              Text(
                "30 Jul, 2020",
                style: grey12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _totalEarningColumn({
    required String title,
    required String txt,
    required String subtitle,
    required bool visible,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: grey16,
        ),
        SizedBox(
          height: s.h(9),
        ),
        Text(
          txt,
          style: Black16,
        ),
        SizedBox(
          height: s.h(6),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              replacement: RotatedBox(
                quarterTurns: 1,
                child: Icon(MyFlutterApp.trending_flat, color: AppredColor),
              ),
              visible: !visible,
              child: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  MyFlutterApp.trending_flat,
                  color: AppgreenColor,
                ),
              ),
            ),
            Visibility(
              replacement: Text(
                subtitle,
                style: red12,
              ),
              visible: !visible,
              child: Text(
                subtitle,
                style: green12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
