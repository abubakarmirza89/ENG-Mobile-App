import 'package:engenglish/Globals/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:engenglish/Globals/globals.dart' as globals;

import '../../Course/Coursedetails.dart';
import '../Dashboard.dart';

class Course {
  final int id;
  final String thumbnail;
  final String title;
  final String description;
  final double price;
  final int category;
  final double discount;

  Course({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.discount
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: double.parse(json['price'].toString()),
      discount: double.parse(json['discount'].toString()),


    );
  }
}

class Courselist extends StatefulWidget {
  @override
  _CourselistState createState() => _CourselistState();
}

class _CourselistState extends State<Courselist> {
  List<Course> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    final apiUrl = 'http://engenglish.com/api/courses/courses-offered';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Course> fetchedCourses = [];
      for (var courseData in data) {
        fetchedCourses.add(Course.fromJson(courseData));
      }
      setState(() {
        courses = fetchedCourses;
        isLoading = false;
      });
    } else {
      // Handle API request error here
      setState(() {
        isLoading = false;
      });
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cards per row
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return InkWell(
            onTap: () {
              // Navigate to the course detail page with course information
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetails(courseId: course.id),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              course.thumbnail,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),


                        Container(
                          height: 100,
                          color: Colors.black.withOpacity(0.6), // Add a black cover
                          child: Center(
                            child: SizedBox(),
                          ),
                        ),
                        Positioned( // Position the text to top left
                          top: 8,
                          left: 8,
                            child:Container(
                              height: 35, // Adjust the height to your desired size
                              width: 35,  // Adjust the width to your desired size
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.deepPurple,
                                  width: 4.0,
                                ),
                              ),
                              child: Center(
                                child: ClipOval(
                                  child: Text(
                                    course.title.length >= 2
                                        ? course.title.substring(0, 2).toUpperCase()
                                        : course.title.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,// Adjust the font size to your preference
                                    ),
                                  ),
                                ),
                              ),
                            )

                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // Add padding to the left
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple
                            ),
                          ),
                          Text(
                            course.description.length > 20
                                ? course.description.substring(0, 20)
                                : course.description,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${course.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,

                                ),
                              ),
                              Text(
                                "\$${course.discount.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color:Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: 4,
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
                              ),
                        ],
                          ),




                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}
