import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:space_explore/const/api_url.dart';

class EarthImageService {
  final String _baseUrl = '${ApiUrl.baseUrl}/planetary/earth/assets';
  final String _apiKey = dotenv.env['NASA_API_KEY'] ?? 'DEMO_KEY';

  Future<String?> fetchEarthImage({
    required double lat,
    required double lon,
    required String date,
  }) async {
    final url = '$_baseUrl?lon=$lon&lat=$lat&date=$date&dim=0.1&api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['url'];
    } else {
      return null;
    }
  }
}
