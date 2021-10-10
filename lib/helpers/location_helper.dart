import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';

final mapboxAPI = FlutterConfig.get('MAPBOX_API_KEY');
final accessToken = FlutterConfig.get('API_TOKEN');

class LocationHelper{
    static String generateLocationPreviewImage({required double latitude, required double longitude})
    {
      return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$mapboxAPI';
    }

    static Future<String> getPlaceAddress(double latitude, double longitude) async{
        final url = Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$accessToken');
        final response = await http.get(url);
        return json.decode(response.body)['features'][0]['place_name'];
    }
}