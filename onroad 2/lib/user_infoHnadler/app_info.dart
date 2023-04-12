import 'package:flutter/cupertino.dart';
import 'package:onroad/user_infoHnadler/directions.dart';

class AppInfo extends ChangeNotifier {
  Directions? userPickupLocation;

  void updatePickUpLocationAddress(Directions userPickupLocation) {
    userPickupLocation = userPickupLocation;
    notifyListeners();
  }
}
