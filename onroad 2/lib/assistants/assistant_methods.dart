import 'package:geolocator/geolocator.dart';
import 'package:onroad/assistants/request_assistants.dart';

class AssistantMethods
{
  static Future<String> searchAddressForGeographicCoDrdinates(Position position)async
  {
    String humanReadableAddress = '';
   String apiUrl = "add api json URL";
   var requestResponse = await RequestAssistant.receiveRequest(apiUrl);
   if(requestResponse != "Error Occurred, Failed. NO Response." )
   {
     humanReadableAddress = requestResponse['results'][0]['formatted_address'];
   }
   return humanReadableAddress;
  }




}