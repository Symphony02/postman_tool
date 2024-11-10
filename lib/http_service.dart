// lib/http_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class HttpService {
  Future<List> fetchNews(String category) async {
    final response = await http.get(Uri.parse('$apiUrl/top-headlines?country=us&category=$category&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
