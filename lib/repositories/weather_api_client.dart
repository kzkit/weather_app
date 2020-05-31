import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/models.dart';

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  //get the location of the city ( Where on Earth id)
  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await http.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception("Cannot find weather data for $city.");
    }
    final locationJson = json.decode(locationResponse.body) as List;
    //api will return Where On Earth ID for the city
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int woeid) async {
    final weatherUrl = '$baseUrl/api/location/$woeid';
    final weatherResponse = await http.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception("Cannot find weather data for the location.");
    }

    final weatherJson = json.decode(weatherResponse.body);

    return Weather.fromJson(weatherJson);
  }
}
