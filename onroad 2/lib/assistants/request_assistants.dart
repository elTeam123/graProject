import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistant {
  static Future<dynamic> receiveRequest(String url) async {
    http.Response httpResponse = await http.get(Uri.parse(url));
    try
    {
      if (httpResponse.statusCode == 200) //successful
      {
        String responseDate = httpResponse.body; // json data
        var decodeResponseData = jsonDecode(responseDate);
        return decodeResponseData;
      }
      else
      {
        return "Error Occurred, Failed. NO Response.";
      }
    }
    catch (exp)
    {
      return "Error Occurred, Failed. NO Response.";
    }
  }
}
