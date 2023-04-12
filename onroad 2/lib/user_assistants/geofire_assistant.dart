import 'package:onroad/Models/activate_nearbyavailabledrivers.dart';

class GeoFireAssistant
{
  static List<ActivateNearbyAvailableProvider> activateNearbyAvailableProvideList=[];
  static void deleteOfflineProviderFromList(String providerId)
  {
    int indexNumber = activateNearbyAvailableProvideList.indexWhere((element) => element.providerId == providerId);
    activateNearbyAvailableProvideList.removeAt(indexNumber);

  }
  static void updateActivateNearbyAvailableProviderLocation(ActivateNearbyAvailableProvider providerMove)
  {
    int indexNumber = activateNearbyAvailableProvideList.indexWhere((element) => element.providerId == providerMove.providerId);
    activateNearbyAvailableProvideList[indexNumber].locationLatitude= providerMove.locationLatitude ;
    activateNearbyAvailableProvideList[indexNumber].locationLongitude= providerMove.locationLongitude ;

  }
}