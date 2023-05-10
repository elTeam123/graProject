import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/provider_Assistants/assistabtprovider_methods.dart';
import 'package:onroad/puch_notification/puch_notification_system.dart';

class ProviderHomeTabPage extends StatefulWidget {
  const ProviderHomeTabPage({super.key});

  @override
  State<ProviderHomeTabPage> createState() => _ProviderHomeTabPageState();
}

class _ProviderHomeTabPageState extends State<ProviderHomeTabPage> {

  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  //جزء هتاكد منو بتاع السيرش عن المكان
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  double searchLocationContainerHeight = 220;
  //جزء تحديد الموقع
  var geolocator = Geolocator();
  LocationPermission? _locationPremission;

  String statusText = "Offline";
  Color buttonColor = Colors.grey;
  bool isProviderActivate = false;

  checkIfLocationPermissionAllowed() async {
    _locationPremission = await Geolocator.requestPermission();
    if (_locationPremission == LocationPermission.denied) {
      _locationPremission = await Geolocator.requestPermission();
    }
  }

  locateProviderPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    providerCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(
        providerCurrentPosition!.latitude, providerCurrentPosition!.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    String humanReadableAddress = await ProviderAssistantMethods
        .searchProviderAddressForGeographicCoDrdinates(
            providerCurrentPosition!, context);
      print('this is your address=$humanReadableAddress');

  }

  readCurrentProviderInfo()async
  {
    currentFirebaseUser = fAuth.currentUser;
    FirebaseDatabase.instance.ref().child("provider").child(currentFirebaseUser!.uid).once().then((snap)
    {
     if(snap.snapshot.value != null)
     {
       onlineproviderData.id  = (snap.snapshot.value as Map)["id"];
       onlineproviderData.fname=(snap.snapshot.value as Map)["fname"];
       onlineproviderData.lname=(snap.snapshot.value as Map)["lname"];
       onlineproviderData.phone=(snap.snapshot.value as Map)["phone"];
       onlineproviderData.email=(snap.snapshot.value as Map)["email"];
     }
    });
    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();

    pushNotificationSystem.initializeCloudMessaging(context);
    pushNotificationSystem.generateAndGetToken();
  }

  @override
  void initState() {
    super.initState();
    checkIfLocationPermissionAllowed();
    readCurrentProviderInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              locateProviderPosition();
            },
          ),
          //on and off UI
          statusText != "Online"
              ? Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.black87,
          )
              : Container(),
          // button for online offline provider
          Positioned(
            top: statusText != "Online"
                ? MediaQuery.of(context).size.height * 0.46
                : 25,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (isProviderActivate != true) //offline
                        {
                     providerIsOnline();
                      updateProviderLocationAtRealtime();

                      setState(() {
                        statusText = "Online";
                        isProviderActivate = true;
                        buttonColor = Colors.transparent;
                      });

                      //display Toast
                      Fluttertoast.showToast(msg: "you are Online Now");
                    } else //online
                        {
                      providerIsOffline();

                      setState(() {
                        statusText = "Offline";
                        isProviderActivate = false;
                        buttonColor = Colors.grey;
                      });
                      //display Toast
                      Fluttertoast.showToast(msg: "you are Offline Now");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: statusText != "Online"
                      ? Text(
                    statusText,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  )
                      : const Icon(
                    Icons.phonelink_ring,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }

  providerIsOnline() async {
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    providerCurrentPosition = pos;
    Geofire.initialize("activeProvider");

    Geofire.setLocation(
      currentFirebaseUser!.uid,
      providerCurrentPosition!.latitude,
      providerCurrentPosition!.longitude,
    );
    DatabaseReference ref = FirebaseDatabase.instance.ref()
        .child('provider')
        .child(currentFirebaseUser!.uid)
        .child('newProviderStatus');
    ref.set("watting"); //ready to have a request
    ref.onValue.listen((event) {});
  }

  updateProviderLocationAtRealtime() {
    streamSubscriptionPosition = Geolocator.getPositionStream()
        .listen((Position position)
    {
        providerCurrentPosition = position;
        if (isProviderActivate == true)
        {
          Geofire.setLocation(
              currentFirebaseUser!.uid,
              providerCurrentPosition!.latitude,
              providerCurrentPosition!.longitude,
          );
        }
        LatLng latLng = LatLng(
          providerCurrentPosition!.latitude,
          providerCurrentPosition!.longitude,
        );
        newGoogleMapController!.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
      },
    );
  }

  providerIsOffline() {
    Geofire.removeLocation(currentFirebaseUser!.uid);
    DatabaseReference? ref = FirebaseDatabase.instance
        .ref()
        .child('provider')
        .child(currentFirebaseUser!.uid)
        .child('newProviderStatus');
    ref.onDisconnect();
    ref.remove();
    ref = null;

    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        // SystemChannels.platform.invokeMethod("systemNavigator.pop()");
         SystemNavigator.pop();
      },
    );
  }
}
// ignore_for_file: use_build_context_synchronously
