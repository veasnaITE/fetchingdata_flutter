
class Beer {
  int id;
  String name;
  String tagline;
  String firstBrewed;
  String description;
  String imageUrl;
  double abv;
  List<String> foodPairing;
  String brewersTips;
  Beer({
    required this.id,
    required this.name,
    required this.tagline,
    required this.firstBrewed,
    required this.description,
    required this.imageUrl,
    required this.abv,
    required this.foodPairing,
    required this.brewersTips

  });

  factory Beer.fromJson(Map<String, dynamic> json) => Beer(
    id: json["id"],
    name: json["name"],
    tagline: json["tagline"],
    firstBrewed: json["first_brewed"],
    description: json["description"],
    imageUrl: json["image_url"],
    abv: json["abv"]?.toDouble(),
    foodPairing: List<String>.from(json["food_pairing"].map((x) => x)),
    brewersTips: json["brewers_tips"],
  );

}
