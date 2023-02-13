import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markevent/screens/login_screen.dart';

class Profile extends StatefulWidget {


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {




  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            logout(context);
          },
          child: Text(
            "Logout",
            style: GoogleFonts.poppins(),
          ),
        ),
      ),
    );
  }
}
