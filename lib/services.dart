import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_news_api/news_model.dart';
import 'package:http/http.dart' as http;

class NewsApiService {

  /*static Future<NewsModel> fetchNews() async {
    print('Reading from url');
    final response = await http.get(
        Uri.parse(
            'https://riad-news-api.vercel.app/api/news/source?code=US-FN'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print('${response.body}');
      return NewsModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}*/
  static Future<NewsModel> fetchNews() async {
    print('Reading from asset');
    final String response =
    await rootBundle.loadString('assets/sample_news.json');

    if (response != null) {
      Map<String, dynamic> jsonResponse = jsonDecode(response);
      print('${jsonResponse}');

      return NewsModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}