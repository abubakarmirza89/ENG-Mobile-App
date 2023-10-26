import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../Globals/globals.dart' as globals;

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