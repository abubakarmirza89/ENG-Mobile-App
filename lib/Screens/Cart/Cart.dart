import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../Globals/Colors.dart';
import '../../Globals/Textstyle.dart';
import '../../Globals/globals.dart' as globals;
import '../../utils/packages/Size/dynamic_size.dart';
import '../DashBoard/Dashboard.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<Map<String, dynamic>> fetchCartDetails(String accessToken) async {
    final response = await http.get(
      Uri.parse('http://engenglish.com/api/student/api/cart/details/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load cart details');
    }
  }

  late dynamicsize s;

  List<Map<String, dynamic>> courses = [];
  double totalAmount = 0.0;
  double discountAmount = 0.0;
  double subtotal = 0.0;

  TextEditingController couponController = TextEditingController();
  int _groupValue = 1;

  @override
  void initState() {
    s = dynamicsize(context, 844, 390);
    super.initState();

    fetchCartDetails(globals.accessToken).then((cartData) {
      setState(() {
        courses = List<Map<String, dynamic>>.from(cartData['course']);
        totalAmount = cartData['total_price'] ?? 0.0;
        discountAmount = cartData['total_discount'] ?? 0.0;
        subtotal = cartData['subtotal'] ?? 0.0;

      });
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: s.w(18)),
          child: Column(
            children: [
              s.HeightSpace(20),
              Row(
                children: [
                  Text(
                    "Cart ",
                    style: perplr14.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Icon(
                    Icons.shopping_cart,
                    color: ApplicationColors,
                  ),
                ],
              ),
              s.HeightSpace(20),
              for (final course in courses)
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            course['thumbnail'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        s.WidthSpace(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              s.HeightSpace(10),
                              Text(
                                course['description'].length > 20
                                    ? course['description'].substring(0, 20)
                                    : course['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$ ${course['price']}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Handle the delete action here
                            deleteCourseFromCart(
                                course['id'],
                                context); // Pass the context parameter
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              s.HeightSpace(30),
              Container(
                height: s.h(37),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller:  couponController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Coupon Code",
                          hintStyle: grey14.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    s.WidthSpace(2),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: ApplicationColors,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Apply",
                            style: Boldwhite15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              s.HeightSpace(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Subtotal",
                                style: Boldblack16,
                              ),
                              s.HeightSpace(5),
                              Text(
                                "Discount",
                                style: Boldblack16,
                              ),
                              s.HeightSpace(5),
                              Text(
                                "Total Amount",
                                style: Boldblack16,
                              ),
                            ],
                          ),
                          s.WidthSpace(15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$ ${subtotal.toStringAsFixed(2)}",
                                style: grey16,
                              ),
                              s.HeightSpace(5),
                              Text(
                                "\$ ${discountAmount.toStringAsFixed(2)}",
                                style: grey16,
                              ),
                              s.HeightSpace(5),
                              Text(
                                "\$ ${totalAmount.toStringAsFixed(2)}",
                                style: perplr14.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  )
                ],
              ),
              Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    color: ApplicationColors.withOpacity(0.4),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: s.w(22),
                        vertical: s.h(5),
                      ),
                      child: Text(
                        "Payment Options",
                        style: Boldwhite14,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      border: Border.all(color: Colors.grey, width: 1.5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Radio<int>(
                              groupValue: _groupValue,
                              value: 1,
                              onChanged: (int? value) {
                                setState(() {
                                  _groupValue = value!;
                                });
                              },
                            ),
                            Text(
                              "Credit / Debit Card",
                              style: perplr14.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.5,
                        ),


                        Row(
                          children: [
                            Radio<int>(
                              groupValue: _groupValue,
                              value: 3,
                              onChanged: (int? value) {
                                setState(() {
                                  _groupValue = value!;
                                });
                              },
                            ),
                            Text(
                              "ENG Token",
                              style: perplr14.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ]),
              ),
              s.HeightSpace(17),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: s.w(22),
                    vertical: s.h(7),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ApplicationColors,
                  ),
                  child: Text(
                    "Proceed to Checkout",
                    style: Boldwhite15,
                  ),
                ),
              ),
              s.HeightSpace(17),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> deleteCourseFromCart(int courseId, BuildContext context) async {
    final String apiUrl =
        'http://engenglish.com/api/student/api/cart/items/remove/$courseId';

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer ${globals.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Course Removed'),
              content: Text('The course has been removed from your cart.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog

                    // Refresh the screen by calling a method that reloads the cart data
                    fetchCartDetails(globals.accessToken).then((cartData) {
                      setState(() {
                        courses = cartData['course'];
                      });
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                    },



                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Failed to delete the course from the cart');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
