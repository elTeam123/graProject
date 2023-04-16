// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/Models/activate_nearbyavailabledrivers.dart';
import 'package:onroad/user_assistants/assistant_methods.dart';
import 'package:onroad/user_assistants/geofire_assistant.dart';

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
      print('this is your address=$humanReadableAddress');
    }
    initializeGeoFireListener();
  }

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  bool activeNearbyProviderKeysLoaded = false;

  @override
  void initState() {
    super.initState();
    checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: AnimatedSize(
          //     curve: Curves.easeIn,
          //     duration: const Duration(milliseconds: 120),
          //     child: Container(
          //       height: searchLocationContainerHeight,
          //       decoration: const BoxDecoration(
          //         color: Colors.black87,
          //         borderRadius: BorderRadius.only(
          //           topRight: Radius.circular(20),
          //           topLeft: Radius.circular(20),
          //         ),
          //       ),
          //       child: Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          //         child: Column(
          //           children: [
          //             //from
          //             Row(
          //               children: [
          //                 const Icon(
          //                   Icons.add_location_alt_outlined,
          //                   color: Colors.grey,
          //                 ),
          //                 const SizedBox(
          //                   width: 12.0,
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     const Text(
          //                       "From",
          //                       style:
          //                           TextStyle(color: Colors.grey, fontSize: 12),
          //                     ),
          //                     Text(
          //                       Provider.of<AppInfo>(context)
          //                                   .userPickupLocation !=
          //                               null
          //                           ? "${(Provider.of<AppInfo>(context).userPickupLocation!.locationName!).substring(0, 24)}..."
          //                           : "not getting address",
          //                       style: const TextStyle(
          //                           color: Colors.grey, fontSize: 14),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
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
