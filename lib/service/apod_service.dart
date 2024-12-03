import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:space_explore/const/api_url.dart';

class ApodService {
  final String apiKey;

  ApodService({required this.apiKey});

  Future<Map<String, dynamic>> fetchApodData() async {
    final url = '${ApiUrl.baseUrl}/planetary/apod?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load APOD data');
      }
    } catch (error) {
      throw Exception('Error fetching APOD data: $error');
    }
  }
}
