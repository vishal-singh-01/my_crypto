import 'package:flutter/material.dart';

import '../models/cryptocurrency.dart';
import 'CryptocurrencyDetailsPage.dart';

class FavoritesPage extends StatelessWidget {
  final List<Cryptocurrency> favorites;

  FavoritesPage({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Favorites'),
      // ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final cryptocurrency = favorites[index];
          return ListTile(
            title: Text('${cryptocurrency.name} (${cryptocurrency.symbol})'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CryptocurrencyDetailsPage(cryptocurrency: cryptocurrency),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
