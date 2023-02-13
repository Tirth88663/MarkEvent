
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:markevent/screens/nav_screens/home_screen2.dart';
import 'package:markevent/screens/nav_screens/profile_screen.dart';
import 'package:markevent/screens/nav_screens/search_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var pagedata = [homescreen2(), Search() , Profile()];
  int selectedicon = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.greenAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 20),
          child: GNav(
            padding: EdgeInsets.all(15),
            gap: 0,
            backgroundColor: Colors.greenAccent,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.white54,
            tabs: [ GButton(
              icon: Icons.home,
              text: 'Home',
            ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Profile',
              ),
            ],
            onTabChange: (index){
              setState(() {
                selectedicon = index;
              });
            },
          ),
        ),
      ) ,



      body: Center(
        child: pagedata[selectedicon],
      ),
    );
  }
}
