import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:markevent/screens/nav_screens/home_screen.dart';
import 'package:markevent/screens/nav_screens/profile_screen.dart';
import 'package:markevent/screens/nav_screens/search_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var pagedata = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];
  int selectedicon = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.greenAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            padding: const EdgeInsets.all(12),
            gap: 0,
            backgroundColor: Colors.greenAccent,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.white54,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                textStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
                textStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Profile',
                textStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            onTabChange: (index) {
              setState(() {
                selectedicon = index;
              });
            },
          ),
        ),
      ),
      body: Center(
        child: pagedata[selectedicon],
      ),
    );
  }
}
