import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markevent/screens/show_details.dart';

import '../addEvent_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MarkEvent",
          style: GoogleFonts.macondo(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        child: const Icon(CupertinoIcons.plus_rectangle_on_rectangle),
        onPressed: () {
          Navigator.push(
            (context),
            MaterialPageRoute(builder: (context) => const AddEventScreen()),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200,
                aspectRatio: 10 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                scrollPhysics: const BouncingScrollPhysics(),
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                Image.network(
                    "https://s3.amazonaws.com/assets.mlh.io/events/splashes/000/212/495/thumb/EventBackground300x300MLH_2.png?1673977134"),
                Image.network(
                    "https://s3.amazonaws.com/assets.mlh.io/events/splashes/000/212/473/thumb/300x300_bg.png?1672759825"),
                Image.network(
                    "https://d112y698adiu2z.cloudfront.net/photos/production/challenge_photos/002/375/887/datas/full_width.png"),
              ],
            ),
          ),
          Text(
            'Events Currently Going on',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            // padding: const EdgeInsets.all(13.0),
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('events').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final DocumentSnapshot data =
                          streamSnapshot.data!.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowDetails(
                                name: data['eventName'],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          child: Container(
                            height: width * 0.35,
                            width: width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      child: SizedBox(
                                        height: width * 0.25,
                                        width: width * 0.25,
                                        child: Image.network(
                                          'https://th.bing.com/th/id/OIP.WC4GMopalC05hla72TnFSwHaHa?pid=ImgDet&rs=1',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['eventName'],
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        data['venue'],
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.greenAccent),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
