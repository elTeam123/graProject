import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/Models/user_provider_request_info.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/provider_Assistants/assistabtprovider_methods.dart';
import '../widgets/progress_dialog.dart';

class NewSosScreen extends StatefulWidget {
  UserProviderRequestInfo? userProviderRequestDetails;
  NewSosScreen({
    this.userProviderRequestDetails,
  });

  @override
  State<NewSosScreen> createState() => _NewSosScreenState();
}

class _NewSosScreenState extends State<NewSosScreen> {
  GoogleMapController? newSosGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  String? buttonTitle = "arrived";
  Color? buttonColor = Colors.green;

  Set<Marker> setOfMarkers = <Marker>{};
  Set<Circle> setOfCircle = <Circle>{};
  Set<Polyline> setOfPolyline = <Polyline>{};
  List<LatLng> polyLinePositionCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double mapPadding = 0;
  BitmapDescriptor? iconAnimatedMarker;
  var geoLocator = Geolocator();

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
        pPoints.decodePolyline(directionDetailsInfo!.e_points!);

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

  @override
  Widget build(BuildContext context) {
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
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(18)),
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
                    const Text(
                      "30 mins",
                      style: TextStyle(
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
                    const SizedBox(
                      height: 18,
                    ),
                    //// Type Of SOS////
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                      ),
                      icon: const Icon(
                        Icons.directions_car,
                        color: Colors.black26,
                        size: 25,
                      ),
                      label: Text(
                        buttonTitle!,
                        style: const TextStyle(
                          color: Colors.black38,
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
        .child('SOS Requests')
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
    sosHistoryRef.child(widget.userProviderRequestDetails!.sosRequestId!).set(true);

  }
}
