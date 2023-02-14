import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/event_model.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _AddEventScreenStateformKey = GlobalKey<FormState>();

  final nameEditingController = TextEditingController();

  final aboutEditingController = TextEditingController();

  final venueEditingController = TextEditingController();

  final organizerEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{4,}$');
        if (value!.isEmpty) {
          return ("Name is required");
        }
        if (!regex.hasMatch(value)) {
          return ("Please enter valid name(Min. 4 Characters)");
        }
        return null;
      },
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: Colors.greenAccent,
      decoration: InputDecoration(
        labelText: 'Event Name',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(Icons.festival_sharp, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Event Name",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
    );
    final aboutField = TextFormField(
      autofocus: false,
      minLines: 1,
      maxLines: 50,
      controller: aboutEditingController,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Event detail is required");
        }
        return null;
      },
      onSaved: (value) {
        aboutEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: Colors.greenAccent,
      decoration: InputDecoration(
        labelText: 'About',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(Icons.event_note_sharp, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "About Event",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
    );
    final venueField = TextFormField(
      autofocus: false,
      controller: venueEditingController,
      keyboardType: TextInputType.streetAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("venue is required");
        }
        return null;
      },
      onSaved: (value) {
        venueEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: Colors.greenAccent,
      decoration: InputDecoration(
        labelText: 'Venue',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon:
            const Icon(Icons.location_on_outlined, color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Venue of Event",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
    );
    final organizerField = TextFormField(
      autofocus: false,
      controller: organizerEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Name of organizer is required");
        }
        return null;
      },
      onSaved: (value) {
        organizerEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      cursorColor: Colors.greenAccent,
      decoration: InputDecoration(
        labelText: 'Organizer',
        labelStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        prefixIcon: const Icon(CupertinoIcons.profile_circled,
            color: Color(0xFF023047)),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Organizer of Event",
        hintStyle:
            GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
    );

    final postEventButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 10,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      height: 40,
      minWidth: width * 0.25,
      color: Colors.greenAccent,
      splashColor: Colors.lightGreenAccent,
      onPressed: () {
        postDetails();
      },
      child: Text(
        "Post",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _AddEventScreenStateformKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  nameField,
                  const SizedBox(height: 30),
                  aboutField,
                  const SizedBox(height: 30),
                  venueField,
                  const SizedBox(height: 30),
                  organizerField,
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      postEventButton,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void postDetails() async {
    if (_AddEventScreenStateformKey.currentState!.validate()) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      EventModel eventModel = EventModel();

      //writing all values
      eventModel.eventName = nameEditingController.text;
      eventModel.aboutEvent = aboutEditingController.text;
      eventModel.venue = venueEditingController.text;
      eventModel.organizer = organizerEditingController.text;

      await firebaseFirestore
          .collection("events")
          .doc(eventModel.eventName)
          .set(eventModel.toMap());

      Fluttertoast.showToast(msg: "Event Posted successfully :)");

      Navigator.pop(context);
    }
  }
}
