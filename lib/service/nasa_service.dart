import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:space_explore/const/api_url.dart';

class NasaService {
  final String _baseUrl = '${ApiUrl.baseUrl}/planetary/apod';
  final String _apiKey = dotenv.env['NASA_API_KEY'] ?? 'DEMO_KEY';

  Future<Map<String, dynamic>> fetchAPOD() async {
    final url = Uri.parse('$_baseUrl?api_key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load APOD');
    }
  }
}
