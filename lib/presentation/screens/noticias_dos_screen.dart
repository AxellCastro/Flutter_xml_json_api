import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class NoticiasDosScreen extends StatefulWidget {
  const NoticiasDosScreen({super.key});

  @override
  State<NoticiasDosScreen> createState() => _NoticiasDosScreenState();
}

class _NoticiasDosScreenState extends State<NoticiasDosScreen> {
  late Future<RssFeed> _feed;

  @override
  void initState() {
    super.initState();
    _feed = getNews();
  }

  Future<RssFeed> getNews() async {
    var response =
        await http.get(Uri.parse("http://feeds.bbci.co.uk/mundo/rss.xml"));
    return RssFeed.parse(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias de BBC Mundo'),
      ),
      body: FutureBuilder<RssFeed>(
        future: _feed,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.items != null) {
            return ListView.builder(
              itemCount: snapshot.data!.items!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data!.items![index];
                return _buildNewsCard(item);
              },
            );
          } else {
            return const Center(child: Text('No se encontraron noticias.'));
          }
        },
      ),
    );
  }

  Widget _buildNewsCard(RssItem item) {
    String? imageUrl;
    if (item.media?.thumbnails != null && item.media!.thumbnails!.isNotEmpty) {
      imageUrl = item.media!.thumbnails!.first.url;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description ?? '',
                    style: const TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
