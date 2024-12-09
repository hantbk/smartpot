import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plantapp/pages/models/News.dart'; 

class NewsService {
  Client client = Client();
  final String _apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
  final String baseUrl = dotenv.env['NEWS_API_URL'] ?? '';

  Future<List<Article>> fetchNewsList({String category = ''}) async {
    // Construct the URL with the given category (if provided)
    var url = Uri.parse(
      "$baseUrl$_apiKey&category=$category",
    );

    // Send the GET request
    final response = await client.get(url);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return NewsApiResponse.fromRawJson(response.body).articles;
    } else {
      // If that call was not successful, throw an error
      throw Exception('Failed to load news');
    }
  }
}