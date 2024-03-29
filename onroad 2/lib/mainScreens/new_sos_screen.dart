import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/Models/user_provider_request_info.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/mainScreens/mainScreens_provider.dart';
import 'package:onroad/provider_Assistants/assistabtprovider_methods.dart';
import '../widgets/progress_dialog.dart';

class NewSosScreen extends StatefulWidget {
  final UserProviderRequestInfo? userProviderRequestDetails;
  const NewSosScreen({
    super.key,
    this.userProviderRequestDetails,
  });

  @override
  State<NewSosScreen> createState() => _NewSosScreenState();
}

class _NewSosScreenState extends State<NewSosScreen> {
  GoogleMapController? newSosGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  var srvicesType = onlineUserData.services;
  String? buttonTitle = "arrived";
  Color? buttonColor = Colors.green;
  String statusBtn = "accepted" ; 

  Set<Marker> setOfMarkers = <Marker>{};
  Set<Circle> setOfCircle = <Circle>{};
  Set<Polyline> setOfPolyline = <Polyline>{};
  List<LatLng> polyLinePositionCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double mapPadding = 0;
  BitmapDescriptor? iconAnimatedMarker;
  var geoLocator = Geolocator();
  Position? onliceProviderCurrentPosition;
  String sosRequestStatus = "accepted";
  String durationFromProviderToSoS = "";
  bool isRequestDirectionDetails = false;

  /////////polyline////////
  // when provider accpet SOS =>
  // originLatLng = provider Location
  // destinationLatLng = User Location
  Future<void> drawPolyLineFromOriginToDestination(
      LatLng originLatLng, LatLng destinationLatLng) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Please wait...",
      ),
    );

    var directionDetailsInfo = await ProviderAssistantMethods
        .obtainOriginToDestinationDirectionDetails(
            originLatLng, destinationLatLng);

    Navigator.pop(context);

    print("These are points = ");
    print(directionDetailsInfo!.e_points);

    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResultList =
        pPoints.decodePolyline(directionDetailsInfo.e_points!);

    polyLinePositionCoordinates.clear();

    if (decodedPolyLinePointsResultList.isNotEmpty) {
      for (var pointLatLng in decodedPolyLinePointsResultList) {
        polyLinePositionCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }

    setOfPolyline.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.purpleAccent,
        polylineId: const PolylineId("PolylineID"),
        jointType: JointType.round,
        points: polyLinePositionCoordinates,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      setOfPolyline.add(polyline);
    });

    LatLngBounds boundsLatLng;
    if (originLatLng.latitude > destinationLatLng.latitude &&
        originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng =
          LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
    } else if (originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
        northeast: LatLng(destinationLatLng.latitude, originLatLng.longitude),
      );
    } else if (originLatLng.latitude > destinationLatLng.latitude) {
      boundsLatLng = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
        northeast: LatLng(originLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      boundsLatLng =
          LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
    }

    newSosGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 65));

    Marker originMarker = Marker(
      markerId: const MarkerId("originID"),
      position: originLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );

    Marker destinationMarker = Marker(
      markerId: const MarkerId("destinationID"),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );

    setState(() {
      setOfMarkers.add(originMarker);
      setOfMarkers.add(destinationMarker);
    });

    Circle originCircle = Circle(
      circleId: const CircleId("originID"),
      fillColor: Colors.green,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: originLatLng,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId("destinationID"),
      fillColor: Colors.red,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: destinationLatLng,
    );

    setState(() {
      setOfCircle.add(originCircle);
      setOfCircle.add(destinationCircle);
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    saveAssignedProviderDetailstoSosRequest();
  }

  createProviderIconMarker() {
    if (iconAnimatedMarker == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(5, 5));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car.png")
          .then((value) {
        iconAnimatedMarker = value;
      });
    }
  }

  getProviderLocationUpdatesAtRealtime() {
    LatLng oldLatLng = const LatLng(0, 0);
    streamSubscriptionLivePosition = Geolocator.getPositionStream().listen(
      (Position position) {
        providerCurrentPosition = position;
        onliceProviderCurrentPosition = position;

        LatLng latLngLiveProvider = LatLng(
          providerCurrentPosition!.latitude,
          providerCurrentPosition!.longitude,
        );
        Marker animatingMarker = Marker(
          markerId: const MarkerId("AnimatedMarker"),
          position: latLngLiveProvider,
          icon: iconAnimatedMarker!,
          infoWindow: const InfoWindow(title: "This is your location"),
        );
        setState(() {
          CameraPosition cameraPosition =
              CameraPosition(target: latLngLiveProvider, zoom: 16);
          newSosGoogleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(cameraPosition),
          );
          setOfMarkers.removeWhere(
              (element) => element.markerId.value == "AnimatedMarker");
          setOfMarkers.add(animatingMarker);
        });
        oldLatLng = latLngLiveProvider;
        upadteDurationTimeAtRealTime();
        Map driverLatLngDataMap = {
          "latitude": onliceProviderCurrentPosition!.latitude.toString(),
          "longitude": onliceProviderCurrentPosition!.longitude.toString(),
        };
        FirebaseDatabase.instance
            .ref()
            .child("SOS Requests")
            .child(widget.userProviderRequestDetails!.sosRequestId!)
            .child("providerLocation")
            .set(driverLatLngDataMap);
      },
    );
  }

  upadteDurationTimeAtRealTime() async {
    if (isRequestDirectionDetails == false) {
      isRequestDirectionDetails = true;
      if (onliceProviderCurrentPosition == null) {
        return;
      }
      var origionPosition = LatLng(onliceProviderCurrentPosition!.latitude,
          onliceProviderCurrentPosition!.longitude);
      LatLng? destinationLatLng;
      if (sosRequestStatus == "accepted") {
        destinationLatLng = widget.userProviderRequestDetails!.originLatLing;
      }
      var directionInformation = await ProviderAssistantMethods
          .obtainOriginToDestinationDirectionDetails(
              origionPosition, destinationLatLng!);
      if (directionInformation != null) {
        setState(() {
          durationFromProviderToSoS = directionInformation.duration_text!;
        });
      }
      isRequestDirectionDetails = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    createProviderIconMarker();
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapPadding),
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            markers: setOfMarkers,
            circles: setOfCircle,
            polylines: setOfPolyline,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newSosGoogleMapController = controller;

              setState(() {
                mapPadding = 320;
              });
              var ProviderCurrentLatLng = LatLng(
                providerCurrentPosition!.latitude,
                providerCurrentPosition!.longitude,
              );
              var sosPositionLatLng =
                  widget.userProviderRequestDetails!.originLatLing;
              drawPolyLineFromOriginToDestination(
                  ProviderCurrentLatLng, sosPositionLatLng!);
              getProviderLocationUpdatesAtRealtime();
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 18,
                      spreadRadius: .5,
                      offset: Offset(0.6, 0.6),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    ////duration////
                    Text(
                      durationFromProviderToSoS,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.black,
                    ),
                    ////user name icon////
                    Row(
                      children: [
                        Text(
                          widget.userProviderRequestDetails!.name!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.phone_android,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    //// User PickUp Location + Icon////
                    Row(
                      children: [
                        Image.asset(
                          "images/info.png", //SOS location Image
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        Expanded(
                          child: Text(
                            widget.userProviderRequestDetails!.locationName!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    //// Type Of SOS////
                    Row(
                      children: [
                        Image.asset(
                          "images/service.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                         Expanded(
                          child: Text(
                            widget.userProviderRequestDetails!.services!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ElevatedButton.icon(
                      onPressed: () {
                        if (statusBtn == "accepted")
                        {
                          statusBtn = "arrived";
                          FirebaseDatabase.instance.ref()
                              .child("SOS Requests")
                              .child(widget.userProviderRequestDetails!.sosRequestId!).child("status").set(statusBtn);
                          setState(() {
                            buttonTitle = "Start Check" ;
                            buttonColor = Colors. green[400];

                          });
                        }
                        else if (statusBtn == "arrived")
                        {
                          statusBtn = "Check SOS";
                          FirebaseDatabase.instance.ref()
                              .child("SOS Requests")
                              .child(widget.userProviderRequestDetails!.sosRequestId!).child("status").set(statusBtn);
                          setState(() {
                            buttonTitle = "Finish" ;
                            buttonColor = Colors.red ;
                          });
                        }
                        else if (statusBtn == "Check SOS")
                        {
                          statusBtn = "done";
                          FirebaseDatabase.instance.ref()
                              .child("SOS Requests")
                              .child(widget.userProviderRequestDetails!.sosRequestId!).child("status").set(statusBtn);
                          streamSubscriptionLivePosition!.cancel();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => const MainScreenProvider(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                      ),
                      icon: const Icon(
                        Icons.directions_car,
                        color: Colors.black,
                        size: 25,
                      ),
                      label: Text(
                        buttonTitle!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  saveAssignedProviderDetailstoSosRequest() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("SOS Requests")
        .child(widget.userProviderRequestDetails!.sosRequestId!);
    Map driverLocationDataMap = {
      "latitude": providerCurrentPosition!.latitude.toString(),
      "longitude": providerCurrentPosition!.longitude.toString(),
    };

    databaseReference.child("providerLocation").set(driverLocationDataMap);
    databaseReference.child("status").set("accepted");
    databaseReference.child("providerId").set(onlineproviderData.id);
    databaseReference.child("providerFname").set(onlineproviderData.fname);
    databaseReference.child("providerLname").set(onlineproviderData.lname);
    databaseReference.child("providerPhone").set(onlineproviderData.phone);
    saveSosRequestToProviderHistory();
  }

  saveSosRequestToProviderHistory() {
    DatabaseReference sosHistoryRef = FirebaseDatabase.instance
        .ref()
        .child("provider")
        .child(currentFirebaseUser!.uid)
        .child("sosHistory");
    sosHistoryRef
        .child(widget.userProviderRequestDetails!.sosRequestId!)
        .set(true);
  }
}
