import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;

final FirebaseAuth fPAuth = FirebaseAuth.instance;
User? currentFirebaseprovider;

StreamSubscription<Position>? streamSubscriptionPosition;