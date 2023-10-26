import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LectureView extends StatefulWidget {
  final int courseId;
  final String accessToken;

  LectureView({required this.courseId, required this.accessToken});

  @override
  State<LectureView> createState() => _LectureViewState();
}

class _LectureViewState extends State<LectureView> {
  late Map<String, dynamic> courseData;
  late List<dynamic> lectures;

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
  }

  Future<void> fetchCourseDetails() async {
    final response = await http.get(
      Uri.parse('http://engenglish.com/api/courses/user_enrolled_courses/${widget.courseId}/'),
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        courseData = responseData['course'];
        lectures = responseData['lecture'];

      });
    } else {
      throw Exception('Failed to load course details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture View'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // Add behavior to start the intro video on tap
                  },
                  child: Container(
                    color: Colors.grey, // Add black background
                    child: Image.network(
                      courseData['thumbnail'],
                      height: 216,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 17),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseData['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'By: ${courseData['user']['name']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFC9C9C9),
                    ),
                  ),
                  SizedBox(height: 16),
                  DefaultTabController(
                    length: 4, // Add tabs for Lectures, Course Details, Author, and Reviews
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          isScrollable: true,
                          indicatorColor: Colors.blue, // Customize tab indicator color
                          tabs: <Widget>[
                            Tab(text: 'Lectures'),
                            Tab(text: 'Course Details'),
                            Tab(text: 'Author'),
                            Tab(text: 'Reviews'),
                          ],
                        ),
                        Container(
                          height: 500, // Customize the height as needed
                          child: TabBarView(
                            children: <Widget>[
                              _buildLectures(),
                              _buildCourseDetails(),
                              _buildAuthorInfo(),
                              _buildReviews(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLectures() {
    // Implement the widget to display lectures, sections, and quizzes
    // You can use ListView.builder and expandable widgets
    return ListView.builder(
      itemCount: lectures.length,
      itemBuilder: (context, index) {
        final lecture = lectures[index];
        // Build a widget for each lecture
        return ListTile(
          title: Text(lecture['Title']),
          onTap: () {
            // Add behavior to show or hide sections and quizzes
          },
        );
      },
    );
  }

  Widget _buildCourseDetails() {
    // Implement the widget to display course details
    // You can use Text widgets or other widgets
    return Text('Course Details');
  }

  Widget _buildAuthorInfo() {
    // Implement the widget to display author information
    // You can use Text widgets or other widgets
    return Text('Author Information');
  }

  Widget _buildReviews() {
    // Implement the widget to display reviews
    // You can use Text widgets or other widgets
    return Text('Reviews');
  }
}
