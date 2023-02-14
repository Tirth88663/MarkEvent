import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markevent/screens/first_screen.dart';
import 'package:markevent/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyAxHc5YNWMbZC3O92cHhi7NCQqYxUsNjF0", // Your apiKey
      //   appId: "XXX", // Your appId
      //   messagingSenderId: "XXX", // Your messagingSenderId
      //   projectId: "markevent-7c170", // Your projectId
      // ),
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MarkEvent',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.greenAccent,
        primarySwatch: Colors.lightGreen,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.greenAccent,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamSubscription<User?> user;

  @override
  void initState() {
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Fluttertoast.showToast(msg: 'signed out!');
      } else {
        Fluttertoast.showToast(msg: 'signed in!');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null
        ? const LoginScreen()
        : const FirstScreen();
  }
}
