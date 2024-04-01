
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


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'slug' : slug,
      'first_historical_data': first_historical_data,
      'last_historical_data' : last_historical_data,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }

  factory Cryptocurrency.fromMap(Map<String, dynamic> map) {
    return Cryptocurrency(
      id: map['id'],
      name: map['name'],
      symbol: map['symbol'],
      slug: map['slug'],
      first_historical_data: map['first_historical_data'],
      last_historical_data: map['last_historical_data'],
      isFavorite: map['is_favorite'] == 1,
    );
  }

}
