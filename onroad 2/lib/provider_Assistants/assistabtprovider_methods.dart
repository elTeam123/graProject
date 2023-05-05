import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/global/mab_key.dart';
import 'package:onroad/provider_Assistants/providerrequest_assistants.dart';
import 'package:onroad/provider_InfoHnadler/provider_directions.dart';
import 'package:onroad/provider_InfoHnadler/providerapp_info.dart';
import 'package:provider/provider.dart';

import '../Models/directions_details.dart';
import '../user_assistants/request_assistants.dart';

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
  static Future<DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetails(LatLng origionPosition, LatLng destinationPosition) async
  {
    String urlOriginToDestinationDirectionDetails = "https://maps.googleapis.com/maps/api/directions/json?origin=${origionPosition.latitude},${origionPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=$mapKey";

    var responseDirectionApi = await RequestAssistant.receiveRequest(urlOriginToDestinationDirectionDetails);

    if(responseDirectionApi == "Error Occurred, Failed. No Response.")
    {
      return null;
    }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points = responseDirectionApi["routes"][0]["overview_polyline"]["points"];

    directionDetailsInfo.distance_text = responseDirectionApi["routes"][0]["legs"][0]["distance"]["text"];
    directionDetailsInfo.distance_value = responseDirectionApi["routes"][0]["legs"][0]["distance"]["value"];

    directionDetailsInfo.duration_text = responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];
    directionDetailsInfo.duration_value = responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetailsInfo;
  }

  static pauseLiveLocationUpdates()
  {
    streamSubscriptionPosition!.pause();
    Geofire.removeLocation(currentFirebaseUser!.uid);
  }
  static resumeLiveLocationUpdates()
  {
    streamSubscriptionPosition!.resume();
    Geofire.setLocation(
        currentFirebaseUser!.uid,
        providerCurrentPosition!.latitude,
        providerCurrentPosition!.longitude,

    );
  }
}

