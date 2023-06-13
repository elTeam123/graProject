// ignore_for_file: must_be_immutable

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onroad/global/global.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class ServicesTabPage extends StatefulWidget {
  DatabaseReference? referenceProviderRequest;
  ServicesTabPage({super.key, this.referenceProviderRequest});

  @override
  State<ServicesTabPage> createState() => _ServicesTabPageState();
}

class _ServicesTabPageState extends State<ServicesTabPage> {
  void checkOutAndRescue() async {
    FirebaseDatabase.instance
        .ref()
        .child("SOS Requests")
        .child(widget.referenceProviderRequest!.key!)
        .child("Servece")
        .set("checkOutAndRescue");
  }

  void checktTires() async {
    FirebaseDatabase.instance
        .ref()
        .child("SOS Requests")
        .child(widget.referenceProviderRequest!.key!)
        .child("Servece")
        .set("Tires");
  }

  void theBattery() async {
    FirebaseDatabase.instance
        .ref()
        .child("SOS Requests")
        .child(widget.referenceProviderRequest!.key!)
        .child("Servece")
        .set("The battery");
  }

  void needPetrol() async {
    FirebaseDatabase.instance
        .ref()
        .child("SOS Requests")
        .child(widget.referenceProviderRequest!.key!)
        .child("Servece")
        .set("Petrol");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              dList = [];
            });
            widget.referenceProviderRequest!.remove();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              'Services',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Brand Bold',
                color: Colors.black,
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: SlidingUpPanel(
          maxHeight: 400,
          minHeight: 50,
          panel: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'images/line.png',
                    height: 45,
                    color: Colors.grey,
                  ),
                  MaterialButton(
                    onPressed: () {
                      checkOutAndRescue();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        color: Colors.black12,
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image(
                              height: 60,
                              image: AssetImage(
                                'images/11.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Check out and rescue',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    onPressed: () {
                      checktTires();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        color: Colors.black12,
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image(
                              height: 60,
// width: double.infinity,
                              image: AssetImage(
                                'images/12.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Tires',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    onPressed: () {
                      theBattery();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        color: Colors.black12,
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image(
                              height: 60,
                              image: AssetImage(
                                'images/13.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'The battery',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    onPressed: () {
                      needPetrol();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        color: Colors.black12,
                      ),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image(
                              height: 60,
                              image: AssetImage(
                                'images/10.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Petrol',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: ListView.builder(
              itemCount: dList.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await FirebaseDatabase.instance
                              .ref()
                              .child("SOS Requests")
                              .child(widget.referenceProviderRequest!.key!)
                              .child("Servece")
                              .once()
                              .then((snap) {
                            if (snap.snapshot.value != "") {
                              chosenProviderId = dList[index]["id"].toString();
                              Navigator.pop(context, "providerChoosed");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Choose your service frist, please... ",
                                  webShowClose: true);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: Colors.white,
                          ),
                          width: 300,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                " Active Provider",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Brand Bold',
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SmoothStarRating(
                                rating: dList[index]['ratings'] == null
                                    ? 0.0
                                    : double.parse(dList[index]['ratings']),
                                color: Colors.yellow,
                                borderColor: Colors.black12,
                                allowHalfRating: true,
                                starCount: 5,
                                size: 18,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                '5 Km',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Brand Bold',
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                    ],
                  ),
                );
              }),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
      ),
    );
  }
}
