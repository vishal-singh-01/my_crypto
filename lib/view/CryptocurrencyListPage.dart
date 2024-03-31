import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/cryptocurrency.dart';
import 'CryptocurrencyDetailsPage.dart';

class CryptocurrencyListPage extends StatelessWidget {
  final List<Cryptocurrency> cryptocurrencies;

  CryptocurrencyListPage({required this.cryptocurrencies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Cryptocurrencies'),
      // ),
      body: ListView.builder(
        itemCount: cryptocurrencies.length,
        itemBuilder: (context, index) {
          final cryptocurrency = cryptocurrencies[index];
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
