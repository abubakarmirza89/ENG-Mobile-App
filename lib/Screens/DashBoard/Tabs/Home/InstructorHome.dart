import 'dart:convert';

import 'package:engenglish/utils/packages/Size/dynamic_size.dart';

import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Constant.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Globals/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:engenglish/Globals/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:engenglish/Model/userslist.dart';




class InstructorHome extends StatefulWidget {
  const InstructorHome({Key? key}) : super(key: key);

  @override
  _InstructorHomeState createState() => _InstructorHomeState();
}

class _InstructorHomeState extends State<InstructorHome> {
  late dynamicsize s;
  TextEditingController searchController = TextEditingController();
  Map<String, dynamic> dashboardData = {};
  List<dynamic> courses = [];// Initialize a list to store course data
  List<dynamic> feedback = [];// Initialize a list to store course data


  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    super.initState();
    fetchData();
  }



  Future<void> fetchData() async {
    final userId = globals.userID;
    final response = await http.get(
      Uri.parse('http://engenglish.com/api/users/instructor/dashboard/$userId'),
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}', // Replace with your actual access token
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        dashboardData = responseData;
        courses = responseData['courses']; // Set the courses list
        feedback = responseData['feedback'];
      });
    } else {
      throw Exception('Failed to load dashboard data');
    }
  }




  TextEditingController Searchcontroller = TextEditingController();


  Future<Map<int, String>> fetchUserList() async {
    final String apiUrl = 'http://engenglish.com/api/users/users/all';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data and create a map of user IDs to user names.
      final List<dynamic> users = json.decode(response.body);
      Map<int, String> userMap = Map();

      for (var user in users) {
        userMap[user['id']] = user['name'];
      }

      return userMap;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load user list');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: s.w(11), vertical: s.h(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                textfield(
                    hint: "Search anything",
                    controller: Searchcontroller,
                    leading: Icon(Icons.search)),
                SizedBox(
                  height: s.h(20),
                ),
                _TotleErning(),
                SizedBox(
                  height: s.h(15),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _AfterTotleErning(
                          title: "Active Students",
                          data: dashboardData['active_students'].toString(),
                          txt: dashboardData['percent_enrolment_count'].toString(),
                          subdata: "vs. last week",
                          Visible: true),
                    ),
                    SizedBox(
                      width: s.w(20),
                    ),
                    Expanded(
                      child: _AfterTotleErning(
                          title: "New Enrolment",
                          data: dashboardData['new_enrolment_count'].toString(),
                          txt: dashboardData['percent_enrolment_count'].toString(),
                          subdata: "vs. Yesterday",
                          Visible: true),
                    ),
                  ],
                ),
                SizedBox(
                  height: s.h(17),
                ),
                _Mycourses(),
                SizedBox(
                  height: s.h(19),
                ),
                _Feedback()
              ],
            ),
          )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Handle the action for the first button
              routes().GotoAddCourse(this.context);
            },
            heroTag: null, // This is required to prevent a hero error
            child: Icon(Icons.add),
          ),
          SizedBox(width: 16), // Add some space between the buttons
          FloatingActionButton(
            onPressed: () {
              // Handle the action for the second button
              routes().GotoCourseBuilder(this.context);
            },
            heroTag: null, // This is required to prevent a hero error
            child: Icon(Icons.abc),
          ),
        ],
      ),
    );
  }

  Widget _Mycourses() {

    double calculateDiscountedPrice(double price, int discount) {
      return price - (price * discount / 100);
    }




    List<MaterialColor> predefinedColors = [Colors.purple, Colors.green, Colors.orange, Colors.lightBlue];

// Shuffle the colors list
    predefinedColors.shuffle(Random());




    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.w(20), vertical: s.h(10)),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Courses",
                style: Boldblack14,
              ),
              Text(
                "View All",
                style: perplr10,
              ),
            ],
          ),
          SizedBox(
            height: s.h(13),
          ),

          for (var course in courses)



          _Mycoursestile(
            color: predefinedColors[courses.indexOf(course) % predefinedColors.length],
            title: course['title'].length >= 3
                ? course['title'].substring(0, 3).toUpperCase()
                : course['title'].toUpperCase(), // Use the course data here
            first:  course['title'], // Example field
            second: 'Discounted Price: \$${calculateDiscountedPrice(double.parse(course['price']), course['discount'])}', // Example field
            third: 'Price: \$${course['price']}',// Example field
            four: 'Sold: ${course['students']}', // Example field
          ),
          SizedBox(
            height: s.h(11),
          ),

        ],
      ),
    );
  }

  Widget _Feedback() {

    List<MaterialColor> predefinedColors = [Colors.purple, Colors.green, Colors.orange, Colors.lightBlue];

// Shuffle the colors list
    predefinedColors.shuffle(Random());





    return Container(
      padding: EdgeInsets.symmetric(horizontal: s.w(20), vertical: s.h(10)),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Student's Feedback",
                style: Boldblack14,
              ),
              Text(
                "View All",
                style: perplr10,
              ),
            ],
          ),
          SizedBox(
            height: s.h(13),
          ),


          for (var feedback in feedback)
            _feedbacktile(
              color: Colors.orange,
              title: "AS",
              first:  feedback['review'], // Example field
              rating: feedback['total_stars'],
              third: feedback['review'],
            ),
          SizedBox(
            height: s.h(11),
          ),

        ],
      ),
    );
  }

  Widget _feedbacktile({
    required String first,
    required int rating,
    required String third,
    required String title,
    required MaterialColor color,
  }) {
    return Row(
      children: [
        RoundedColoredContainer(title, color, context),
        SizedBox(
          width: s.w(4),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      first,
                      style:
                          Boldblack10.copyWith(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: double.parse(rating.toString()),
                    minRating: 1,
                    itemSize: 10,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      third,
                      style: grey8,
                    ),
                  ),
                  Text(
                    "Full Review",
                    style: perplr10,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _Mycoursestile({
    required String first,
    required String second,
    required String third,
    required String four,
    required String title,
    required MaterialColor color,
  }) {
    return Row(
      children: [
        ColoredContainer(title, color, context),
        SizedBox(
          width: s.w(4),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    first,
                    style: Black10,

                  ),
                  Text(
                    second,
                    style: Black10,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    third,
                    style: Black10,
                  ),
                  Text(
                    four,
                    style: grey8,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _AfterTotleErning({
    required String title,
    required String data,
    required String txt,
    required String subdata,
    required bool Visible,
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
                            child: Icon(MyFlutterApp.trending_flat,
                                color: AppredColor)),
                        visible: Visible,
                        child: RotatedBox(
                            quarterTurns: 3,
                            child: Icon(
                              MyFlutterApp.trending_flat,
                              color: AppgreenColor,
                            )),
                      ),
                      Visibility(
                        replacement: Text(
                          txt,
                          style: red12,
                        ),
                        visible: Visible,
                        child: Text(
                          txt,
                          style: green12,
                        ),
                      )
                    ],
                  ),
                  Text(
                    subdata,
                    style: grey10,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _TotleErning() {
    double? monthTotalEarning = double.tryParse(dashboardData['month_total_earning']?.toString() ?? '');
    bool isVisible1 = monthTotalEarning != null && monthTotalEarning >= 0;

    double? weekTotalEarning = double.tryParse(dashboardData['week_total_earning']?.toString() ?? '');
    bool isVisible2 = weekTotalEarning != null && weekTotalEarning >= 0;

    double? todayTotalEarning = double.tryParse(dashboardData['today_total_earning']?.toString() ?? '');
    bool isVisible3 = todayTotalEarning != null && todayTotalEarning >= 0;


    DateTime today = DateTime.now();
    DateTime thirtyDaysAgo = today.subtract(Duration(days: 30));

    final DateFormat dateFormat = DateFormat('dd MMM, yyyy');
    String todayFormatted = dateFormat.format(today);
    String thirtyDaysAgoFormatted = dateFormat.format(thirtyDaysAgo);


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
                child: _totleerningcolumn(
                    title: "Monthly",
                    txt: dashboardData['month_total_earning'].toString(),
                    subtitle: " ${dashboardData['percent_monthly_sales'].toString()}%",
                    Visible: isVisible1),
              ),
              Expanded(
                child: _totleerningcolumn(
                    title: "Weekly",
                    txt: dashboardData['week_total_earning'].toString(),
                    subtitle: " ${dashboardData['percent_weekly_sales'].toString()}%",
                    Visible: isVisible2),
              ),
              Expanded(
                child: _totleerningcolumn(
                    title: "Daily (Avg)",
                    txt: dashboardData['today_total_earning'].toString(),
                    subtitle: " ${dashboardData['percent_today_sales'].toString()}%",
                    Visible: isVisible3),
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
                todayFormatted,
                style: grey12,
              ),
              Text(
                thirtyDaysAgoFormatted,
                style: grey12,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _totleerningcolumn(
      {required String title,
      required String txt,
      required String subtitle,
      required bool Visible}) {
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
                  child: Icon(MyFlutterApp.trending_flat, color: AppredColor)),
              visible: Visible,
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    MyFlutterApp.trending_flat,
                    color: AppgreenColor,
                  )),
            ),
            Visibility(
              replacement: Text(
                subtitle,
                style: red12,
              ),
              visible: Visible,
              child: Text(
                subtitle,
                style: green12,
              ),
            )
          ],
        ),
      ],
    );
  }
}
