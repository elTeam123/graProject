import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onroad/Models/user_provider_request_info.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/mainScreens/new_sos_screen.dart';

class NotificationDialogBox extends StatefulWidget {
  UserProviderRequestInfo? userProviderRequestDetails;
  NotificationDialogBox({this.userProviderRequestDetails});

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white70,
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 14,
            ),
            // Image.asset(
            //   '   ',
            //   width: 160,
            // ),
            const SizedBox(
              height: 12,
            ),
            //////////////////////title//////////////////
            const Text(
              "New SOS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ////////////////////////SOS location/////////////////////
                  Row(
                    children: [
                      Image.asset(
                        '', //SOS location Image
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.userProviderRequestDetails!.locationName!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                                                      /////////////////////////////SOS Type////////////////////////////
                  Row(
                    children: [
                      Image.asset(
                        " ",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      Expanded(
                        child: Container(
                          child: const Text(
                            " ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 3,
              thickness: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                                                             ////////////////////Cancel SOS requist//////////////
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                                                        ////////////////////Accept SOS requist////////////////
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      acceptSoSRequeste(context);
                    },
                    child: Text(
                      "Accept".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  acceptSoSRequeste(BuildContext context) {
    String getSOSRideRequestID = " ";
    FirebaseDatabase.instance
        .ref()
        .child("provider")
        .child(currentFirebaseUser!.uid)
        .child("newProviderStatus")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        getSOSRideRequestID = snap.snapshot.value.toString();

      } else {
        Fluttertoast.showToast(msg: "This SOS request do not exists.");
      }
      if (getSOSRideRequestID ==
          widget.userProviderRequestDetails!.sosRequestId) {
        FirebaseDatabase.instance
            .ref()
            .child("provider")
            .child(currentFirebaseUser!.uid)
            .child("newProviderStatus")
            .set("accepted");
                              ////send provider to newSOS Screen////
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => NewSosScreen(
                userProviderRequestDetails:widget.userProviderRequestDetails),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "this SOS do not exists.");
      }
    });
  }
}
