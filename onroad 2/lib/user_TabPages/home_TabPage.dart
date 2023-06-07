// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/main.dart';
import 'package:onroad/user_TabPages/services_TabPage.dart';
import 'package:onroad/user_assistants/assistant_methods.dart';
import 'package:onroad/user_assistants/geofire_assistant.dart';
import '../Models/activate_nearbyavailabledrivers.dart';
import '../mainScreens/rate_driver_screen.dart';

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
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  double waitingResponseFromProviderContainerHight = 0;
  double assignedProviderInfoContainerHight = 0;


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
  StreamSubscription<DatabaseEvent>? sosRequsestInfoStream;
  DatabaseReference? referenceProviderRequest;
  String providerSosStatus = " ";

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
      "name": "Mohammed Salah",
      "phone": "01012404838",
      "origin": originLocationMap,
      "time": DateTime.now().toString(),
      "providerId": "waiting",
      "locationName": humanReadableAddress,
      "Servece" :"",
    };
    referenceProviderRequest!.set(userInfoMap);

    sosRequsestInfoStream = referenceProviderRequest!.onValue.listen((eventSnap)
    {
      if(eventSnap.snapshot.value == null)
      {
        return;
      }
      if((eventSnap.snapshot.value as Map)["providerFname"] != null)
      {
        setState(() {
          providerFname = (eventSnap.snapshot.value as Map)["providerFname"].toString();
        });
      }
        if((eventSnap.snapshot.value as Map)["providerLname"]!= null)
      {
        setState(() {
          providerLname = (eventSnap.snapshot.value as Map)["providerLname"].toString();
        });
      }
      if((eventSnap.snapshot.value as Map)["providerPhone"] != null)
      {
        setState(() {
          providerPhone = (eventSnap.snapshot.value as Map)["providerPhone"].toString();
        });
        if((eventSnap.snapshot.value as Map)["status"] != null)
        {
          providerSosStatus = (eventSnap.snapshot.value as Map)["status"].toString();
        }
        if(providerSosStatus == "done")
        {
                                           ///////////// User Rate Provider \\\\\\\\\\\\\\
          if((eventSnap.snapshot.value as Map)["providerId"] != null)
        {
          String assignedProviderId = (eventSnap.snapshot.value as Map)["providerId"].toString();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> RateProviderScreen(
            assignedProviderId : assignedProviderId,
          ),),);
          referenceProviderRequest!.onDisconnect();
          sosRequsestInfoStream!.cancel();
        }
        }


      }
    });

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

                           //available provider//
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
        if (snap.snapshot.value != null)
        {
                                           ////sendNotificationtoProvider////
          sendNotificationtoProviderNow(chosenProviderId!);
                                                // watting resopnses UI //
          showWaitingResponseFromProvider();
                                           /////Response from a Provider/////
          FirebaseDatabase.instance
              .ref()
              .child("provider")
              .child(chosenProviderId!)
              .child("newProviderStatus")
              .onValue
              .listen(
                (eventSnapshot) {
                  /////////////////Provider cancel the SOS => push Notification///////////////////
                  if(eventSnapshot.snapshot.value == "watting")
                  {
                    Fluttertoast.showToast(msg: "The provider has Cancelled your SOS.");
                    Future.delayed(const Duration(milliseconds: 3000),()
                    {
                      Fluttertoast.showToast(msg: "please choose another provider.");
                      MyApp.restartApp(context);
                    }
                    );
                  }
                 ////////////////Provider Accpet the SOS and UI => push Notification////////////////
                  if(eventSnapshot.snapshot.value == "accepted")
                  {
                    showUiForAssignedProviderInfo();
                  }
                },
              );
        } else {
          Fluttertoast.showToast(msg: "Not exist ,Try again");
        }
      });
    }
  }


  showUiForAssignedProviderInfo()
  {
   setState(() {
     waitingResponseFromProviderContainerHight = 0;
     assignedProviderInfoContainerHight = 220 ;
   });
  }

  showWaitingResponseFromProvider()
  {
    setState(() {
      waitingResponseFromProviderContainerHight = 220;
    });
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
        AssistantMethods.sendNotificationToProviderNow(deviceRegistrationToken,
            referenceProviderRequest!.key.toString(), context);
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
        //  UI for waiting response
          Positioned(
            bottom:200,
            left: 10,
            right: 10,
            child: Container(
              height:waitingResponseFromProviderContainerHight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )
              ),
              child:Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'waiting for Response',
                        duration: const Duration(seconds:10),
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(fontSize: 30.0, color:Colors.green , fontFamily: "Brand-Regular"),
                      ),
                      ScaleAnimatedText(
                        'please wait...',
                        duration: const Duration(seconds:10),
                        textAlign: TextAlign.center,
                        textStyle: const TextStyle(fontSize: 32.0, color:Colors.green, fontFamily:"Brand-Regular"),
                        scalingFactor: .10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //ui for assigned provider info
          Positioned(
            bottom:200,
            left: 10,
            right: 10,
            child: Container(
              height:assignedProviderInfoContainerHight ,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      providerSosStatus,
                      textAlign:TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Divider(
                      height: 2,
                      thickness: 2,
                      color:Colors.white24,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                                        //provider name//
                     Text(
                      "$providerFname $providerLname",
                      textAlign:TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                                       //Call provider button//
                    ElevatedButton.icon(
                        onPressed:()
                        {

                        },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                        icon: const Icon(
                          Icons.phone_android,
                          color: Colors.black54,
                          size: 22,
                        ),
                        label: const Text(
                          "Call provider",
                          style: TextStyle(
                            color:Colors.black54,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                    )


                  ],
                ),
              ),
            )

          )
        ],
      ),
    );
  }

  initializeGeoFireListener() {
    Geofire.initialize('activeProvider');
    Geofire.queryAtLocation(
      userCurrentPosition!.latitude,
      userCurrentPosition!.longitude,
      25,)!.listen((map) {
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
