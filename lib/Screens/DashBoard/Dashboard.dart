import 'package:engenglish/Globals/Colors.dart';
import 'package:engenglish/Globals/my_flutter_app_icons.dart';
import 'package:engenglish/Screens/Course/CourseCategory.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Chat/ChatScreen.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Courselist.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Home/InstructorHome.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Home/StudentHome.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Profile/EditProfile.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Profile/ProfileScreen.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/Profile/StudentProfile.dart';
import 'package:engenglish/Screens/DashBoard/Tabs/ReawardScreen2.dart';
import 'package:engenglish/utils/packages/Size/dynamic_size.dart';
import 'package:flutter/material.dart';

import '../../Globals/Constant.dart';
import '../../Globals/Routes.dart';
import '../../Globals/globals.dart' as globals; // Import the globals.dart file

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CustomAppBar({required this.scaffoldKey});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Background color
      title: Image.asset("assets/images/LogowithNameperple.png"),
      actions: [
        IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openEndDrawer();
          },
          icon: Icon(
            MyFlutterApp.bars,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          // Navigate to Student Profile or other actions
        },
        icon: Icon(
          MyFlutterApp.bell_1,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Image.asset("assets/images/Logoperple.png"),
                  SizedBox(height: 15),
                  Image.asset("assets/images/LogowithNameperple.png"),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CourseCategory()));
              },
              leading: Icon(Icons.houseboat_sharp),
              title: Text("Course Categories"),
            ),
            if (globals.userType == 'instructor')
              ListTile(
                onTap: () {
                  routes().GotoAddCourse(context);
                },
                leading: Icon(Icons.houseboat_sharp),
                title: Text("Create Course"),
              ),
            if (globals.userType == 'student')
              ListTile(
                onTap: () async {
                  // Perform the cart loading process (e.g., fetching cart items)
                  // After the cart loading process is completed, navigate to the cart screen or perform other actions
                  routes().GotoCart(context);
                },
                leading: Icon(Icons.shopping_cart_outlined),
                title: Text("Cart"),
              ),
            ListTile(
              onTap: () async {
                // Perform the logout process (e.g., sign out the user)
                // After the logout process is completed (e.g., user is signed out), navigate to the login screen
                routes().GotoSigninScreen(context);
              },
              leading: Icon(Icons.logout_outlined),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
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

class DashBoard extends StatefulWidget {
  final int InitialPage;

  const DashBoard({Key? key, required this.InitialPage}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late dynamicsize s;
  late PageController Pagecontroller;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int SelectedIndex = 0;
  bool isLoggingOut = false;
  bool isLoadingCart = false; // Initialize the loading state to false

  @override

  void initState() {
    Pagecontroller = PageController(initialPage: widget.InitialPage);
    s = dynamicsize(context, 844, 390);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        endDrawer: CustomDrawer(),
        appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      body: Container(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (value) {
            setState(() {
              SelectedIndex = value;
            });
          },
          controller: Pagecontroller,
          children: [
            if (globals.userType == 'instructor') ... [
              InstructorHome(),
              Courselist(),
              ProfileScreen(),
              ChatScreen(),
              ReawardScreen2(),
              EditProfilePage(),
              CourseCategory(),
            ] else ...[
              StudentHome(),
              Courselist(),
              UserProfilePage(),
              ChatScreen(),
              ReawardScreen2(),
              EditProfilePage(),
              CourseCategory(),
            ],
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: SelectedIndex,
        onTabTapped: (int index) {
          setState(() {
            SelectedIndex = index;
            Pagecontroller.jumpToPage(SelectedIndex);
          });
        },
      ),
    );
  }
}

