import 'dart:async';
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onroad/Models/provider_data.dart';
import 'package:onroad/Models/user_provider_request_info.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
StreamSubscription<Position>? streamSubscriptionPosition;
StreamSubscription<Position>? streamSubscriptionLivePosition;

List dList = []; // provider key info
String? chosenProviderId ="";
Position? providerCurrentPosition;
ProviderData onlineproviderData = ProviderData();
UserProviderRequestInfo onlineUserData = UserProviderRequestInfo();

String sreverToken = "key=AAAAaQbYg9o:APA91bHYQnFhBhE4UjhkN0lqYdlAQS7TnMG8wCdUBIK79D22RzUdBJoC_71uiOPff6K4_aBkK7XZYQp5Bnh_gLRGeAayBhBMr7JDeQJglG8wQEM9caqbee6hOP2fsEUR1ZX6wlXz4i1n";
String providerFname = '';
String providerLname = '';
String providerPhone = '';


