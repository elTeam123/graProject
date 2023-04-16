import 'package:flutter/cupertino.dart';
import 'package:onroad/provider_InfoHnadler/providerDirections.dart';

class ProviderAppInfo extends ChangeNotifier {
  ProviderDirections? providerPickupLocation;

  void updatePickUpLocationAddress(ProviderDirections providerPickupLocation) {
    providerPickupLocation = providerPickupLocation;
    notifyListeners();
  }
}
