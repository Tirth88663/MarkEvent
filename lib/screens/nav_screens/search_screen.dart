import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    autofocus: false,
                    controller: searchEditingController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.greenAccent,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.search,
                          color: Color(0xFF023047)),
                      labelText: 'Search',
                      labelStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF023047),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Search here...",
                      hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(color: Color(0xFF023047))),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      searchEditingController.text = value;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 50),
                  StreamBuilder(
                    stream: (searchEditingController.text.isNotEmpty)
                        ? FirebaseFirestore.instance
                            .collection('events')
                            .where("searchKeywords",
                                arrayContains: searchEditingController.text)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection('events')
                            .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        if (streamSnapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final DocumentSnapshot data =
                                  streamSnapshot.data!.docs[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            const SizedBox(height: 10),
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
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: Colors.greenAccent),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.greenAccent),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
