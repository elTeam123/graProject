import 'package:onroad/Models/activate_nearbyavailabledrivers.dart';

class GeoFireAssistant
{
  ///active Provider
  static List<ActivateNearbyAvailableProvider> activateNearbyAvailableProvideList=[];
  ///off line Provider
  static void deleteOfflineProviderFromList(String providerId)
  {
    int indexNumber = activateNearbyAvailableProvideList.indexWhere((element) => element.providerId == providerId);
    activateNearbyAvailableProvideList.removeAt(indexNumber);

  }
  //Real time active provider
  static void updateActivateNearbyAvailableProviderLocation(ActivateNearbyAvailableProvider providerMove)
  {
    int indexNumber = activateNearbyAvailableProvideList.indexWhere((element) => element.providerId == providerMove.providerId);
    activateNearbyAvailableProvideList[indexNumber].locationLatitude= providerMove.locationLatitude ;
    activateNearbyAvailableProvideList[indexNumber].locationLongitude= providerMove.locationLongitude ;

  }
}