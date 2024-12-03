import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:space_explore/const/api_url.dart';

class MarsRoverService {
  final String _baseUrl = '${ApiUrl.baseUrl}/mars-photos/api/v1/rovers';
  final String _apiKey = dotenv.env['NASA_API_KEY'] ?? 'DEMO_KEY';

  Future<List<dynamic>> fetchMarsPhotos({
    // required String rover,
    required int sol,
    String? camera,
  }) async {
    String url = '$_baseUrl/mars-photos/api/v1/rovers/curiosity/photos?sol=$sol&api_key=$_apiKey';
    if (camera != null) {
      url += '&camera=$camera';
    }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['photos'];
    } else {
      throw Exception('Failed to load Mars photos');
    }
  }
}
