class SiteRecommendation {
  final String name;
  final String imageUrl;
  final String link;
  bool isFavorite;

  SiteRecommendation({
    required this.name,
    required this.imageUrl,
    required this.link,
    this.isFavorite = false,
  });
} //tes pull
