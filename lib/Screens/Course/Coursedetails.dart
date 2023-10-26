import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Globals/globals.dart' as globals;
import 'package:video_player/video_player.dart';
import '../DashBoard/Dashboard.dart';

import '../../Model/api-cart.dart';

class Course {
  final int id;
  final String thumbnail;
  final String title;
  final String description;
  final double price;
  final double discount;
  final String intro_video;
  final String video_url;
  final String? difficulty;
  final String? caption;
  final double? hours;
  final double? minutes;
  final String? is_active;
  final String? is_draft;
  final String created_at;
  final String updated_at;
  final int users_enrolled;
  final int category;
  final int subcategory;

  Course({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.intro_video,
    required this.video_url,
    this.difficulty,
    this.caption,
    this.hours,
    this.minutes,
    this.is_active,
    this.is_draft,
    required this.created_at,
    required this.updated_at,
    required this.users_enrolled,
    required this.category,
    required this.subcategory,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      thumbnail: json['thumbnail'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: double.parse(json['price'].toString()),
      intro_video: json['intro_video'] ?? '',
      discount: double.parse(json['discount'].toString()),
      video_url: json['video_url'] ?? '',
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
      users_enrolled: json['user'],
      category: json['category'],
      subcategory: json['subcategory'],
    );
  }
}

class CourseDetails extends StatefulWidget {
  final int courseId;

  CourseDetails({required this.courseId});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late Course course;
  bool isLoading = true;
  Uri videoUrla = Uri.parse('https://www.youtube.com/watch?v=f2dEDzJv7YQ');

  late VideoPlayerController _videoPlayerController = VideoPlayerController.networkUrl(videoUrla);

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
  }

  Future<void> fetchCourseDetails() async {
    final apiUrl = 'http://engenglish.com/api/courses/courses_detail/${widget
        .courseId}';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final courseData = json.decode(response.body)['course'];
      course = Course.fromJson(courseData);
    //  Uri videoUrl = Uri.parse(course.intro_video);

      //_videoPlayerController = VideoPlayerController.networkUrl(videoUrl)
        //..initialize().then((_) {
          //setState(() {});
       // });

      setState(() {
        isLoading = false;
      });
    } else {
      // Handle API request error here
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
  }

  void playVideo() {
    setState(() {
      _videoPlayerController?.play();
    });
  }
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      body: Column(
        children: [
          // Video Thumbnail
          GestureDetector(
            onTap: playVideo,
            child: Center(
              child: _videoPlayerController != null
                  ? AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              )
                  : Image.network(
                course.thumbnail,
                fit: BoxFit.cover,
                height: 150, // Adjust the height to your preference
              ),
            ),
          ),

          // Course Title, Description, and Rating
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  course.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  course.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    // Star Rating
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Icon(
                      Icons.star_half,
                      color: Colors.amber,
                    ),

                    // Add more stars if needed

                    Spacer(),

                    // Price and Discount
                    Text(
                      '\$',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      course.price.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Fixed Buttons
          Spacer(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    bool courseIsAddedToCart = await isCourseInCart(globals.accessToken, course.id);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Course Added to Cart'),
                          content: Text('The course has been added to your cart successfully.'),
                          actions: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    if (courseIsAddedToCart) {
                      // Course is already in the cart
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Course Already in Cart'),
                            content: Text('The course is already in your cart.'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Course is not in the cart, you can add it here
                      addToCart(context, globals.accessToken, course.id);
                    }
                  },
                  child: Text('Add to Cart'),
                ),


                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Enroll Now logic
                    });
                  },
                  child: Text('Enroll Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



Future<void> addToCart(BuildContext context, String accessToken, int courseId) async {
  final apiUrl = 'http://engenglish.com/api/student/api/cart/add/items';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer ${globals.accessToken}',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'course_id': courseId}),
  );

  if (response.statusCode == 200) {
    // Course added to cart successfully
    showSuccessPopup(context); //
    print("Course Added Succsfully");// Show the success popup
  } else {
    // Handle the case where adding to the cart failed
  }
}

void showSuccessPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Course Added to Cart'),
        content: Text('The course has been added to your cart successfully.'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );


  Future<List<Course>> fetchCartDetails(String accessToken) async {
    final apiUrl = 'http://engenglish.com/api/student/api/cart/details/';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Course> courses = (data['course'] as List)
          .map((courseData) => Course.fromJson(courseData))
          .toList();
      return courses;
    } else {
      throw Exception('Failed to load cart details');
    }
  }

  Future<bool> isCourseInCart(String accessToken, int courseId) async {
    final apiUrl = 'http://engenglish.com/api/student/api/cart/details/';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<String> cartItemsIds = (data['CartItemsList'] as List)
          .map((item) => item['Item Id'].toString())
          .toList();

      // Check if the courseId is in cart items
      return cartItemsIds.contains(courseId.toString());
    } else {
      throw Exception('Failed to check if course is in cart');
    }
  }
}