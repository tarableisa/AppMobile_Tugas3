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
  final List<SiteRecommendation> allSites = [
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

  List<SiteRecommendation> filteredSites = [];

  @override
  void initState() {
    super.initState();
    filteredSites = allSites;
  }

  void _filterSites(String query) {
    setState(() {
      filteredSites = allSites
          .where((site) =>
              site.name.toLowerCase().contains(query.toLowerCase()) ||
              site.link.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleFavorite(SiteRecommendation site) {
    setState(() {
      site.isFavorite = !site.isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(site.isFavorite
            ? '${site.name} ditambahkan ke favorit!'
            : '${site.name} dihapus dari favorit.'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
        title: const Text(
          "Daftar Situs Rekomendasi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Icon(Icons.link, color: Colors.white),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: _filterSites,
              decoration: InputDecoration(
                hintText: 'Cari situs...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredSites.length,
              itemBuilder: (context, index) {
                final site = filteredSites[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
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
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          key: ValueKey(site.isFavorite),
                          icon: Icon(
                            site.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: site.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => _toggleFavorite(site),
                        ),
                        Icon(Icons.chevron_right, color: Colors.grey[400]),
                      ],
                    ),
                    onTap: () => _launchURL(site.link),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
