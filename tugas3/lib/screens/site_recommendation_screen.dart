import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/site_recommendation.dart';

class SiteRecommendationScreen extends StatefulWidget {
  @override
  _SiteRecommendationScreenState createState() =>
      _SiteRecommendationScreenState();
}

class _SiteRecommendationScreenState extends State<SiteRecommendationScreen> {
  final List<SiteRecommendation> sites = [
    SiteRecommendation(
      name: 'Flutter',
      imageUrl: 'https://flutter.dev/images/flutter-logo-sharing.png',
      link: 'https://flutter.dev',
    ),
    SiteRecommendation(
      name: 'Dart',
      imageUrl:
          'https://cdn.iconscout.com/icon/free/png-256/dart-2752168-2284971.png',
      link: 'https://dart.dev',
    ),
    SiteRecommendation(
      name: 'Stack Overflow',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/e/ef/Stack_Overflow_icon.svg',
      link: 'https://stackoverflow.com',
    ),
    SiteRecommendation(
      name: 'GitHub',
      imageUrl:
          'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
      link: 'https://github.com',
    ),
  ];

  void _toggleFavorite(SiteRecommendation site) {
    setState(() {
      site.isFavorite = !site.isFavorite;
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka $url')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Situs Rekomendasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        itemCount: sites.length,
        itemBuilder: (context, index) {
          final site = sites[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: site.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      CircularProgressIndicator(strokeWidth: 2),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.broken_image, size: 40),
                ),
              ),
              title: Text(
                site.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                site.link,
                style: TextStyle(color: Colors.grey[600]),
              ),
              trailing: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: IconButton(
                  key: ValueKey(site.isFavorite),
                  icon: Icon(
                    site.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: site.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => _toggleFavorite(site),
                ),
              ),
              onTap: () => _launchURL(site.link),
            ),
          );
        },
      ),
    );
  }
}
