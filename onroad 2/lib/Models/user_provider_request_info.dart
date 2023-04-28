import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProviderRequestInfo {
  LatLng? originLatLing;
  String? locationName;
  String? name;
  String? phone;
  DateTime? time;
  UserProviderRequestInfo({
    this.originLatLing,
    this.locationName,
    this.name,
    this.phone,
    this.time,
  });
}
