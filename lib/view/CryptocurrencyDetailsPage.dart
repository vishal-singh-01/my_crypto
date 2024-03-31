import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/cryptocurrency.dart';

class CryptocurrencyDetailsPage extends StatelessWidget {
  final Cryptocurrency cryptocurrency;

  CryptocurrencyDetailsPage({required this.cryptocurrency});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cryptocurrency.name),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text('ID: ${cryptocurrency.id}'),
      //       Text('Symbol: ${cryptocurrency.symbol}'),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Add to favorites functionality
      //         },
      //         child: Text('Add to Favorites'),
      //       ),
      //     ],
      //   ),
      // ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildParameterRow('ID', cryptocurrency.id.toString()),
            _buildParameterRow('Name', cryptocurrency.name.toString()),
            _buildParameterRow('Symbol', cryptocurrency.symbol),
            _buildParameterRow('Slug', cryptocurrency.slug),
            _buildParameterRow('First Historical Data', cryptocurrency.first_historical_data),
            _buildParameterRow('Last Historical Data', cryptocurrency.last_historical_data),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add to favorites functionality
              },
              child: Text('Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}