import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/cryptocurrency.dart';
import 'data/database_helper.dart';


class ApiService {
  static const String apiKey = '2592e201-7cb0-41b4-81d5-abacc60ac4ee';
  static const String baseUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency';

  static Future<List<Cryptocurrency>> fetchCryptocurrencies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/map?CMC_PRO_API_KEY=$apiKey'),
    );

    print("url called ${Uri.parse('$baseUrl/map?CMC_PRO_API_KEY=$apiKey')}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> cryptocurrenciesData = responseData['data'];

      print("url response ${responseData['data']}");
      print("url all response ${cryptocurrenciesData.length}");
      // print("url all response ${cryptocurrenciesData.toString()}");


      final List<Cryptocurrency> cryptocurrencies =  cryptocurrenciesData.map((data) {
        return Cryptocurrency(
          id: data['id'],
          name: data['name'] ?? '',
          symbol: data['symbol'] ?? '',
          slug: data['slug'] ?? '',
          first_historical_data: data['first_historical_data'] ?? '',
          last_historical_data: data['last_historical_data'] ?? '',
        );
      }).toList();

      // Save cryptocurrencies data to database
      await _saveCryptocurrenciesToDatabase(cryptocurrencies);

      return cryptocurrencies;
    } else {
      throw Exception('Failed to load cryptocurrencies');
    }
  }

  static Future<void> _saveCryptocurrenciesToDatabase(List<Cryptocurrency> cryptocurrencies) async {
    final dbHelper = DatabaseHelper();
    print("_saveCryptocurrenciesToDatabase called ${cryptocurrencies.length}");

    for (final cryptocurrency in cryptocurrencies) {
      await dbHelper.insertCryptocurrency(cryptocurrency);
    }
  }
}