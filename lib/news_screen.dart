import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_api/news_model.dart';
import 'package:flutter_news_api/news_search.dart';
import 'package:flutter_news_api/services.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<NewsScreen> {
  late List<Data> _news = [];
  Map<int, bool> _bookmarks = {};


  @override
  void initState() {
    super.initState();
    _loadNews();
    // initBookmarkState();
  }

  Future<void> _loadNews() async {
    try {
      NewsModel response = await NewsApiService.fetchNews();
      setState(() {
        _news = response.data!;
        // _filteredNews = _news;
      });
    } catch (e) {
      print('Error loading News: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ANTUVN',style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.green ),),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notification_important)),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SearchScreen()));
              }, // Show search field
            ),
          ],
        ),
        body: _news == null || _news.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: [
                        GestureDetector(
                          onTap: _launchURL,
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage('images/mountain.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _launchURL1,
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage('images/health.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _launchURL2,
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage('images/politics.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _launchURL3,
                          child: Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage('images/sports.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: _news.map((data) {
                        int index = _news.indexOf(data);
                        return GestureDetector(
                          onTap: () {
                            _launchURL();
                          },
                            child:Card(
                              elevation: 4,
                              margin: EdgeInsets.all(8),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Source: ${data.source}',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Title: ${data.title}',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Description: ${data.description}',
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'PubDate: ${data.pubDate}',
                                    ),
                                    SizedBox(height: 8), // Adjust spacing as per your design
                                    IconButton(
                                      icon: _bookmarks.containsKey(index) && _bookmarks[index] == true
                                          ? Icon(Icons.bookmark,color: Colors.green,)
                                          : Icon(Icons.bookmark_border),
                                      onPressed: () {
                                        _toggleBookmark(index);
                                      },
                                    ),
                                  ],
                                ),
                              ),

                            ),

                        );
                      }).toList(),
                    )
                  ],
                ),
              ));
  }

  _launchURL() async {
    final Uri url = Uri.parse(
        'https://www.foxnews.com/opinion/greg-gutfeld-carl-heastie-holding-captive-'
        'progressive-delusions-crime-no-punishment');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _toggleBookmark(int index) {
    setState(() {
      if (_bookmarks.containsKey(index)) {
        _bookmarks[index] = !_bookmarks[index]!;
      } else {
        _bookmarks[index] = true;
      }
    });
  }

  _launchURL1() async {
    final Uri url = Uri.parse(
        'https://www.foxnews.com/media/sean-hannity-biden-back-hiding-basement');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  _launchURL2() async {
    final Uri url = Uri.parse(
        'https://www.foxnews.com/politics/nyc-migrant-squatters-drugs-guns-previously-caught-southern-border-released-ice');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  _launchURL3() async {
    final Uri url = Uri.parse(
        'https://www.foxnews.com/lifestyle/hefty-feline-mistaken-dangerous-mountain-lion-frantic-911-call-thats-big-cat');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
