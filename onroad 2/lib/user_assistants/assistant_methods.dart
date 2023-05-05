import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:onroad/global/mab_key.dart';
import 'package:onroad/user_assistants/request_assistants.dart';
import 'package:onroad/user_infoHnadler/app_info.dart';
import 'package:onroad/user_infoHnadler/directions.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../global/global.dart';

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoDrdinates(
      Position position, context) async {
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
      Provider.of<AppInfo>(context, listen: false)
          .updatePickUpLocationAddress(userPickupAddress);
    }
    return humanReadableAddress;
  }

  static sendNotificationToProviderNow(
      String deviceRegistrationToken, String userSosRequestId, context) async {
    Map<String, String> headerNotificatioon = {
      "Content-Type": "application/json",
     "Authorization": sreverToken,
    };
    Map bodyNotification = {
      "body": "hello, new SOS request. please check.",
      "title": "SOS"
    };
    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "providerRequestedId": userSosRequestId
    };
    Map officialNotificationFormat = {
      "notification": bodyNotification,
      "priority": "high",
      "data": dataMap,
      "to": deviceRegistrationToken,
    };
    var responseNotification = http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headerNotificatioon,
      body: jsonEncode(officialNotificationFormat),
    );
  }
}
