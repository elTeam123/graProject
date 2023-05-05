// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
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
import 'package:onroad/user_TabPages/services_TabPage.dart';
import 'package:onroad/user_assistants/assistant_methods.dart';
import 'package:onroad/user_assistants/geofire_assistant.dart';
import '../Models/activate_nearbyavailabledrivers.dart';
import 'package:http/http.dart' as http;

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  //جزء هتاكد منو بتاع السيرش عن المكان
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  double searchLocationContainerHeight = 220;
  //جزء تحديد الموقع
  Position? userCurrentPosition;
  var geolocator = Geolocator();

  LocationPermission? _locationPremission;

  checkIfLocationPermissionAllowed() async {
    _locationPremission = await Geolocator.requestPermission();
    if (_locationPremission == LocationPermission.denied) {
      _locationPremission = await Geolocator.requestPermission();
    }
  }

  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    userCurrentPosition = cPosition;

    LatLng latLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCoDrdinates(
            userCurrentPosition!, context);

    if (kDebugMode) {
      print('this is your address= $humanReadableAddress');
    }
    initializeGeoFireListener();
  }

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  bool activeNearbyProviderKeysLoaded = false;

  List<ActivateNearbyAvailableProvider> onlineNearByAvailableProvidersList = [];

  DatabaseReference? referenceProviderRequest;

  @override
  void initState() {
    super.initState();
    checkIfLocationPermissionAllowed();
  }

  void saveProviderRequestInformation() async {
    referenceProviderRequest =
        FirebaseDatabase.instance.ref().child("SOS Requests").push();
    // Get the current location and time
    Position position = await Geolocator.getCurrentPosition();
    // Create a reference to the Firebase database
    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCoDrdinates(
            userCurrentPosition!, context);

    // Save the user's location, time, and other information to the database

    Map<String, dynamic> originLocationMap = {
      "latitude": position.latitude.toString(),
      "longitude": position.longitude.toString(),
    };
    Map userInfoMap = {
      "name": "dfgdf ",
      "phone": "dfgdfg ",
      "origin": originLocationMap,
      "time": DateTime.now().toString(),
      "providerID": "waww ",
      "locationName": humanReadableAddress,
    };
    // Call other functions here if needed
    referenceProviderRequest!.set(userInfoMap);

    onlineNearByAvailableProvidersList =
        GeoFireAssistant.activateNearbyAvailableProvideList;
    searchNearestOnlineProvider();
  }

  searchNearestOnlineProvider() async {
    // cancel the request
    if (onlineNearByAvailableProvidersList.isEmpty) {
      referenceProviderRequest!.remove();
      setState(() {
        markersSet.clear();
        circlesSet.clear();
      });
      Fluttertoast.showToast(msg: "No Online Provider");
      Fluttertoast.showToast(
          msg: "Please Search Again later, App Will Restarting Now");

      Future.delayed(
        const Duration(microseconds: 4000),
        () {
          SystemNavigator.pop();
        },
      );

      return;
    }

    //available provider
    await retrieveOnlineProviderInfo(onlineNearByAvailableProvidersList);
    var response = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) =>
            ServicesTabPage(referenceProviderRequest: referenceProviderRequest),
      ),
    );
    if (response == "providerChoosed") {
      FirebaseDatabase.instance
          .ref()
          .child("provider")
          .child(chosenProviderId!)
          .once()
          .then((snap) {
        if (snap.snapshot.value != null) {
          sendNotificationtoProviderNow(chosenProviderId!);
        } else {
          Fluttertoast.showToast(msg: "Not exist ,Try again");
        }
      });
    }
  }

  ///////////////////////send a requist////////////////////
  sendNotificationtoProviderNow(String chosenProviderId) {
    // assign providerRequist
    FirebaseDatabase.instance
        .ref()
        .child("provider")
        .child(chosenProviderId)
        .child("newProviderStatus")
        .set(referenceProviderRequest!.key);
    //////////////////automate the push notification system//////////////////
    FirebaseDatabase.instance
        .ref()
        .child("provider")
        .child(chosenProviderId)
        .child("Token")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        String deviceRegistrationToken = snap.snapshot.value.toString();
        ///////// send Notification Now ///////////
        AssistantMethods.sendNotificationToProviderNow(
            deviceRegistrationToken,
            referenceProviderRequest!.key.toString(),
            context);
        Fluttertoast.showToast(msg: "Notification sent Successfully.");
      } else {
        Fluttertoast.showToast(msg: "Please Choose another provider.");
        return;
      }
    });
  }

  // retrieveOnlineProviderInfo(List onlineNearestProvidersList) async {
  //   DatabaseReference ref = FirebaseDatabase.instance.ref().child('provider');
  //   for (int i = 0; i < onlineNearestProvidersList.length; i++) {
  //     String providerId = onlineNearestProvidersList[i].providerId.toString();
  //     await ref.child(providerId).once().then((dataSnapshot) {
  //       var providerInfoKey = dataSnapshot.snapshot.value;
  //       // Check if providerInfoKey already exists in dList
  //       bool providerExists = dList.contains((element) => element['key']== providerInfoKey!);
  //       if (!providerExists) {
  //         dList.add(providerInfoKey); // dList have active providers Info
  //       }
  //     });
  //   }
  //   return dList;
  // }

  retrieveOnlineProviderInfo(List onlineNearestProvidersList) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('provider');
    for (int i = 0; i < onlineNearByAvailableProvidersList.length; i++) {
      await ref
          .child(
            onlineNearestProvidersList[i].providerId.toString(),
          )
          .once()
          .then(
        (dataSnapshot) {
          var providerInfoKey = dataSnapshot.snapshot.value;
          dList.add(providerInfoKey); // dList have active providers Info
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 150,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          elevation: 5,
          onPressed: () {
            saveProviderRequestInformation();
          },
          child: const Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              locateUserPosition();
            },
          ),
        ],
      ),
    );
  }

  initializeGeoFireListener() {
    Geofire.initialize('activeProvider');
    Geofire.queryAtLocation(
      userCurrentPosition!.latitude,
      userCurrentPosition!.longitude,
      15, ///////Kilo meters////
    )!
        .listen(
      (map) {
        if (kDebugMode) {
          print(map);
        }

        if (map != null) {
          var callBack = map['callBack'];

          //latitude will be retrieved from map['latitude']
          //longitude will be retrieved from map['longitude']

          switch (callBack) {
            //when any provider become online
            case Geofire.onKeyEntered:
              ActivateNearbyAvailableProvider activateNearbyAvailableProvider =
                  ActivateNearbyAvailableProvider();
              activateNearbyAvailableProvider.locationLatitude =
                  map['latitude'];
              activateNearbyAvailableProvider.locationLongitude =
                  map['longitude'];
              activateNearbyAvailableProvider.providerId = map['key'];
              GeoFireAssistant.activateNearbyAvailableProvideList
                  .add(activateNearbyAvailableProvider);
              if (activeNearbyProviderKeysLoaded == true) {
                displayActiveProviderOnMap();
              }
              break;

            //when any provider become offline
            case Geofire.onKeyExited:
              GeoFireAssistant.deleteOfflineProviderFromList(map['key']);
              break;

            //when provider move
            case Geofire.onKeyMoved:
              ActivateNearbyAvailableProvider activateNearbyAvailableProvider =
                  ActivateNearbyAvailableProvider();
              activateNearbyAvailableProvider.locationLatitude =
                  map['latitude'];
              activateNearbyAvailableProvider.locationLongitude =
                  map['longitude'];
              activateNearbyAvailableProvider.providerId = map['key'];
              GeoFireAssistant.updateActivateNearbyAvailableProviderLocation(
                  activateNearbyAvailableProvider);
              displayActiveProviderOnMap();
              break;

            //display active provider on user map
            case Geofire.onGeoQueryReady:
              displayActiveProviderOnMap();
              break;
          }
        }

        setState(() {});
      },
    );
  }

  displayActiveProviderOnMap() {
    setState(
      () {
        markersSet.clear();
        circlesSet.clear();
        Set<Marker> providerMarkerSet = <Marker>{};
        for (ActivateNearbyAvailableProvider eachProvider
            in GeoFireAssistant.activateNearbyAvailableProvideList) {
          LatLng eachDriverActivePosition = LatLng(
              eachProvider.locationLatitude!, eachProvider.locationLongitude!);
          Marker marker = Marker(
            markerId: MarkerId(eachProvider.providerId!),
            position: eachDriverActivePosition,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta),
            rotation: 360,
          );

          providerMarkerSet.add(marker);
        }
        setState(
          () {
            markersSet = providerMarkerSet;
          },
        );
      },
    );
  }
}
