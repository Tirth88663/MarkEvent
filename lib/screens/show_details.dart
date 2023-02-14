import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDetails extends StatefulWidget {
  const ShowDetails({Key? key, required this.name}) : super(key: key);

  final String name;
  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.name,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('events')
            .where("eventName", isEqualTo: widget.name)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot data =
                      streamSnapshot.data!.docs[index];

                  //widget to show details about schemes
                  Widget showDetails(String title) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                title,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-2, -2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(2, 2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.greenAccent[100],
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  data[title],
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  return Center(
                    child: Column(
                      children: [
                        showDetails("aboutEvent"),
                        showDetails("venue"),
                        showDetails("organizer")
                      ],
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }
}
