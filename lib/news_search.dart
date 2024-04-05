import 'package:flutter/material.dart';
import 'package:flutter_news_api/news_model.dart';
import 'package:flutter_news_api/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<SearchScreen> {
  late List<Data> _news = [];
  late List<Data> _filteredNews = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    try {
      NewsModel response = await NewsApiService.fetchNews();
      setState(() {
        _news = response.data!;
        _filteredNews = _news;
      });
    } catch (e) {
      print('Error loading News: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
            TextField(
            controller: _searchController,
            onChanged: _filterNews,
            decoration: InputDecoration(
              hintText: 'Search news...',
              contentPadding: EdgeInsets.all(12),
            ),
          ),
          Expanded(
            child: _news.isEmpty
                ? Center(
              child: CircularProgressIndicator(),
            )
                : ListView.builder(
              itemCount: _filteredNews.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _launchURL(_filteredNews[index].link);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Text('source : ${_filteredNews[index].source}'),
                        Text('title : ${_filteredNews[index].title}'),
                        Text('Link : ${_filteredNews[index].link}'),
                        Text(
                            'Description : ${_filteredNews[index].description}'),
                        Text('PubDate : ${_filteredNews[index].pubDate}'),
                      ],
                ),
              ),
            );
          },
      ),
          )
      ],

    ),
        )
    );
  }


  void _filterNews(String query) {
    setState(() {
      _filteredNews = _news.where((news) {
        return news.title!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  _launchURL(String? link) async {
    final Uri url = Uri.parse(
        'https://www.foxnews.com/opinion/greg-gutfeld-carl-heastie-holding-captive-'
            'progressive-delusions-crime-no-punishment');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
