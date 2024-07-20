import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class NoticiasUnoScreen extends StatefulWidget {
  const NoticiasUnoScreen({super.key});

  @override
  State<NoticiasUnoScreen> createState() => _NoticiasUnoScreenState();
}

class _NoticiasUnoScreenState extends State<NoticiasUnoScreen> {
  late Future<RssFeed> _feed;

  @override
  void initState() {
    super.initState();
    _feed = getNews();
  }

  Future<RssFeed> getNews() async {
    var response =
        await http.get(Uri.parse("https://www.elcomercio.com/feed/"));
    return RssFeed.parse(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias de El Comercio'),
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
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.enclosure != null && item.enclosure!.url != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.enclosure!.url!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Mostrar un placeholder o icono de error en caso de falla de carga
                    return const Icon(Icons.error);
                  },
                ),
              ),
            const SizedBox(height: 8),
            Text(
              item.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.description ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
