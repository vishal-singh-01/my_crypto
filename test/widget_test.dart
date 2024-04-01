
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';
import '../lib/api_service.dart';
import '../lib/data/database_helper.dart';
import '../lib/models/cryptocurrency.dart';

void main() {
  test('Fetch Cryptocurrencies', () async {
    // Test ApiService.fetchCryptocurrencies()
    try {
      final List<Cryptocurrency> cryptocurrencies = await ApiService.fetchCryptocurrencies();
      // Check if cryptocurrencies list is not empty
      expect(cryptocurrencies.isNotEmpty, true);
    } catch (e) {
      fail('Failed to fetch cryptocurrencies: $e');
    }
  });

  test('Test DatabaseHelper', () async {
    // Test DatabaseHelper functions
    final dbHelper = DatabaseHelper();

    // Test inserting a cryptocurrency into the database
    final Cryptocurrency cryptocurrency = Cryptocurrency(
      id: 1,
      name: 'Bitcoin',
      symbol: 'BTC',
      slug: 'bitcoin',
      first_historical_data: '2010-07-13T00:05:00.000Z',
      last_historical_data: '2024-03-27T13:30:00.000Z',
    );
    await dbHelper.insertCryptocurrency(cryptocurrency);

    final List<Cryptocurrency> favoriteCryptocurrencies = await dbHelper.getFavoriteCryptocurrencies();

    expect(favoriteCryptocurrencies.isNotEmpty, true);
  });
}
