import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/Models/user_provider_request_info.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/puch_notification/notification_dialog_box.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async {
    // 1. Terminated when app is closed
    FirebaseMessaging.instance.getInitialMessage().then(
          (RemoteMessage? remoteMessage) {
        if (remoteMessage != null) {
          //  display ride request info
          readUserProviderRequestInfo(
              remoteMessage.data["providerRequestedId"], context);
        }
      },
    );

    //  2. Foreground when app is open
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage? remoteMessage) {
        //  display ride request info
        readUserProviderRequestInfo(
            remoteMessage!.data["providerRequestedId"], context);

      },
    );

    //  3.Background when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage? remoteMessage) {
        //  display ride request info
        readUserProviderRequestInfo(
            remoteMessage!.data["providerRequestedId"], context);
      },
    );
  }

  readUserProviderRequestInfo(
      String userProviderRequestedId, BuildContext context) {
    FirebaseDatabase.instance
        .ref()
        .child("SOS Requests")
        .child(userProviderRequestedId)
        .once()
        .then((snapData) {
      if (snapData.snapshot.value != null) {
        double originLat = double.parse(
            (snapData.snapshot.value! as Map)["origin"]["latitude"].toString());
        double originLing = double.parse(
            (snapData.snapshot.value! as Map)["origin"]["longitude"]
                .toString(),);
        String locationName =
        ((snapData.snapshot.value! as Map)["locationName"]);
        String name = ((snapData.snapshot.value! as Map)["name"]);
        String phone = ((snapData.snapshot.value! as Map)["phone"]);
        String time = ((snapData.snapshot.value! as Map)["time"]);
        String services = ((snapData.snapshot.value! as Map)["Servece"]);
        String? sosRequestId = snapData.snapshot.key;



        UserProviderRequestInfo userProviderRequestDetails =
        UserProviderRequestInfo();
        userProviderRequestDetails.originLatLing =
            LatLng(originLat, originLing);
        userProviderRequestDetails.locationName = locationName;
        userProviderRequestDetails.phone = phone;
        userProviderRequestDetails.name = name;
        userProviderRequestDetails.sosRequestId = sosRequestId;
        userProviderRequestDetails.services = services;





        showDialog(
          context: context,
          builder: (BuildContext context) => NotificationDialogBox(
              userProviderRequestDetails: userProviderRequestDetails),
        );


      } else {
        Fluttertoast.showToast(msg: "This Provider Request ID do not exists,");
      }
    });
  }

  Future generateAndGetToken() async {
    String? registrationToken = await messaging.getToken();
    print("FCM Registration Token : ");
    print(registrationToken);

    FirebaseDatabase.instance
        .ref()
        .child('provider')
        .child(currentFirebaseUser!.uid)
        .child('Token')
        .set(registrationToken);
    messaging.subscribeToTopic("allProviders");
    messaging.subscribeToTopic("allUsers");
  }
}