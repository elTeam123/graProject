import 'package:geolocator/geolocator.dart';
import 'package:onroad/global/mab_key.dart';
import 'package:onroad/provider_Assistants/providerrequest_assistants.dart';
import 'package:onroad/provider_InfoHnadler/providerapp_info.dart';
import 'package:onroad/provider_InfoHnadler/provider_directions.dart';
import 'package:provider/provider.dart';

class ProviderAssistantMethods {
  static Future<String> searchProviderAddressForGeographicCoDrdinates(
      Position position,context ) async {
    String humanReadableAddress = '';
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var requestResponse = await ProviderRequestAssistant.receiveRequest(apiUrl);
    if (requestResponse != "Error Occurred, Failed. NO Response.") {
      humanReadableAddress = requestResponse['results'][0]['formatted_address'];
      ProviderDirections providerPickupAddress = ProviderDirections();
      providerPickupAddress.locationLatitude = position.latitude;
      providerPickupAddress.locationLatitude = position.longitude;
      providerPickupAddress.locationName = humanReadableAddress;
      Provider.of<ProviderAppInfo>(context,listen: false).updatePickUpLocationAddress(providerPickupAddress);
    }
    return humanReadableAddress;
  }
}
