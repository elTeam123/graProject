import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/Models/user_provider_request_info.dart';





class NewSosScreen extends StatefulWidget {
  UserProviderRequestInfo? userProviderRequestDetails;
  NewSosScreen({this.userProviderRequestDetails,});



  @override
  State<NewSosScreen> createState() => _NewSosScreenState();
}

class _NewSosScreenState extends State<NewSosScreen> {

  GoogleMapController? newSosGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  String? buttonTitle = "arrived";
  Color? buttonColor = Colors.green;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
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
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newSosGoogleMapController = controller;
            },
          ),
          Positioned(
            bottom: 0,
            left:0 ,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18)
                ),
                boxShadow:[
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 18,
                    spreadRadius:.5,
                    offset: Offset(0.6, 0.6),
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,),
                child: Column(
                  children:  [
                                            ////duration////
                    const Text(
                      "30 mins",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),

                     const SizedBox(height:18 ,),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.black,


                    ),
                                         ////user name icon////
                    Row(
                      children:   [
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
                    const SizedBox(height:18 ,),
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
                    const SizedBox(height:18 ,),
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
                    const SizedBox(height:24 ,),
                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.black,


                    ),
                    const SizedBox(height:10 ,),

                    ElevatedButton.icon(
                      onPressed: ()
                    {

                    },
                      style:ElevatedButton.styleFrom(
                        backgroundColor:buttonColor,
                      ) ,
                        icon: const Icon(
                          Icons.directions_car,
                          color: Colors.black26,
                          size: 25,
                        ),
                        label:  Text(
                          buttonTitle!,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ) ,
                    )

                  ],
                ),
              ),
            ),
          )

        ],
      ) ,
    );
  }
}
