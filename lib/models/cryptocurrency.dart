
class Cryptocurrency {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final String first_historical_data;
  final String last_historical_data;
  bool isFavorite;

  Cryptocurrency({
    required this.id,
    required this.name,
    required this.symbol,
    required this.slug,
    required this.first_historical_data,
    required this.last_historical_data,
    this.isFavorite = false,
  });

}
