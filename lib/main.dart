// lib/main.dart
import 'package:flutter/material.dart';
import 'http_service.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NewsHomePage(),
    );
  }
}

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({Key? key}) : super(key: key);

  @override
  _NewsHomePageState createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  final HttpService httpService = HttpService();
  String _selectedCategory = 'general';
  List _articles = [];

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    List news = await httpService.fetchNews(_selectedCategory);
    setState(() {
      _articles = news;
    });
  }

  void _changeCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _loadNews();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News - $_selectedCategory'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('General'),
              onTap: () => _changeCategory('general'),
            ),
            ListTile(
              title: const Text('Business'),
              onTap: () => _changeCategory('business'),
            ),
            ListTile(
              title: const Text('Technology'),
              onTap: () => _changeCategory('technology'),
            ),
            ListTile(
              title: const Text('Sports'),
              onTap: () => _changeCategory('sports'),
            ),
            // Add more categories if needed
          ],
        ),
      ),
      body: _articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_articles[index]['title']),
                  subtitle: Text(_articles[index]['description'] ?? 'No description available'),
                );
              },
            ),
    );
  }
}
