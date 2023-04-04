import 'package:geolocator/geolocator.dart';
import 'package:onroad/assistants/request_assistants.dart';
import 'package:onroad/infoHnadler/app_info.dart';
import 'package:onroad/infoHnadler/directions.dart';
import 'package:provider/provider.dart';
import '../global/mab_Key.dart';

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoDrdinates(
      Position position,context ) async {
    String humanReadableAddress = '';
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);
    if (requestResponse != "Error Occurred, Failed. NO Response.") {
      humanReadableAddress = requestResponse['results'][0]['formatted_address'];
      Directions userPickupAddress = Directions();
      userPickupAddress.locationLatitude = position.latitude;
      userPickupAddress.locationLatitude = position.longitude;
      userPickupAddress.locationName = humanReadableAddress;
      Provider.of<AppInfo>(context).updatePickUpLocationAddress(userPickupAddress);
    }
    return humanReadableAddress;
  }
}
