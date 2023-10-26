
// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names


import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/Routes.dart';
import 'package:engenglish/Globals/Textstyle.dart';
import 'package:engenglish/Globals/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import '../../Globals/Constant.dart';
import '../../Globals/globals.dart' as globals;
import '../../Model/CourseClipmodel.dart';
import '../../utils/packages/Size/dynamic_size.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../DashBoard/Dashboard.dart';

class CourseCategory extends StatefulWidget {
  const CourseCategory({Key? key});

  @override
  State<CourseCategory> createState() => _CourseCategoryState();



}





class _CourseCategoryState extends State<CourseCategory> {
  List<Category> categories = [];
  List<SubCategory> subcategories = [];
  bool isLoading = true;
  int selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final categoryApiUrl = 'http://engenglish.com/api/courses/categories';
    final categoryResponse = await http.get(
      Uri.parse(categoryApiUrl),
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}',
      },
    );

    if (categoryResponse.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(categoryResponse.body);
      List<Category> loadedCategories = jsonData
          .map((category) => Category.fromJson(category))
          .toList();

      final subcategoryApiUrl = 'http://engenglish.com/api/courses/subcategories';
      final subcategoryResponse = await http.get(
        Uri.parse(subcategoryApiUrl),
        headers: {
          'Authorization': 'Bearer ${globals.accessToken}',
        },
      );

      if (subcategoryResponse.statusCode == 200) {
        final List<dynamic> jsonSubData = json.decode(subcategoryResponse.body);
        List<SubCategory> loadedSubCategories = jsonSubData
            .map((subcategory) => SubCategory.fromJson(subcategory))
            .toList();

        setState(() {
          categories = loadedCategories;
          subcategories = loadedSubCategories;
          isLoading = false;
        });
      } else {
        print('Subcategory API Request Error - Status Code: ${subcategoryResponse.statusCode}');
        print('Response Body: ${subcategoryResponse.body}');
        isLoading = false;
      }
    } else {
      print('Category API Request Error - Status Code: ${categoryResponse.statusCode}');
      print('Response Body: ${categoryResponse.body}');
      isLoading = false;
    }



  }



  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: CustomDrawer(),
      appBar: CustomAppBar(scaffoldKey: scaffoldKey,),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Course Category",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text(
                  "You have total ${categories.length} Categories",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.filter, color: Theme.of(context).primaryColor),
                            SizedBox(width: 5),
                            Text(
                              "Filtered by",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_right, size: 15, color: Theme.of(context).primaryColor),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
                SizedBox(height: 30),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                  children: categories
                      .map((category) => _CourseContainer(
                    title: category.categoryName,
                    subtitle: category.description,
                    data: subcategories
                        .where((subCategory) =>
                    subCategory.parentCategory ==
                        category.id)
                        .map((subCategory) =>
                    subCategory.subCategoryName)
                        .toList(),
                    color: Colors.purple, // You can set colors as needed
                  ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),


      ),


    );
  }

  Widget _CourseContainer({
    required String title,
    required String subtitle,
    required List<String> data,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 19),
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: color),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                    title.length >= 2
                        ? title.substring(0, 2).toUpperCase()
                        : title.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: data
                .map((item) => Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                border: Border.all(color: txtgreyColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class Category {
  final int id;
  final String categoryName;
  final String description;

  Category({
    required this.id,
    required this.categoryName,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['category_name'],
      description: json['description'],
    );
  }
}

class SubCategory {
  final int id;
  final String subCategoryName;
  final int parentCategory;

  SubCategory({
    required this.id,
    required this.subCategoryName,
    required this.parentCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      subCategoryName: json['sub_category_name'],
      parentCategory: json['parent_category'],
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: selectedIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Darkyellow,
      unselectedItemColor: Theme.of(context).primaryColor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.book_open),
          label: "Book",
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.user),
          label: "User",
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.paper_plane),
          label: "Plan",
        ),
        BottomNavigationBarItem(
          icon: Icon(MyFlutterApp.trophy),
          label: "Trophy",
        ),
      ],
    );
  }
}
