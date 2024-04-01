import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/cryptocurrency.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../data/database_helper.dart';

class CryptocurrencyDetailsPage extends StatefulWidget {
  final Cryptocurrency cryptocurrency;

  CryptocurrencyDetailsPage({required this.cryptocurrency});

  @override
  _CryptocurrencyDetailsPageState createState() => _CryptocurrencyDetailsPageState();
}

class _CryptocurrencyDetailsPageState extends State<CryptocurrencyDetailsPage> {


  @override
  void initState() {
    super.initState();
    print("CryptocurrencyDetailsPage called");
    // _loadCryptocurrencies();


    buttonText = widget.cryptocurrency.isFavorite ? removeToFavourite : addToFavourite;
  }
// class CryptocurrencyDetailsPage extends StatelessWidget {
//   final Cryptocurrency cryptocurrency;

  // CryptocurrencyDetailsPage({required this.cryptocurrency});

  String addToFavourite = "Add to Favorites";
  String removeToFavourite = "Remove from Favorites";
  String buttonText = "";

  @override
  Widget build(BuildContext context) {
    print("cryptocurrency ${widget.cryptocurrency.toString()}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cryptocurrency.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildParameterRow('ID', widget.cryptocurrency.id.toString()),
            _buildParameterRow('Name', widget.cryptocurrency.name.toString()),
            _buildParameterRow('Symbol', widget.cryptocurrency.symbol),
            _buildParameterRow('Slug', widget.cryptocurrency.slug),
            _buildParameterRow('First Historical Data', widget.cryptocurrency.first_historical_data),
            _buildParameterRow('Last Historical Data', widget.cryptocurrency.last_historical_data),
            SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     // Add to favorites functionality
            //   },
            //   child: Text('Add to Favorites'),
            // ),
            ElevatedButton(
              onPressed: () {
                _toggleFavorite(context);
              },
              child: Text(buttonText),
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

  void _toggleFavorite(BuildContext context) {
    final dbHelper = DatabaseHelper();
    widget.cryptocurrency.isFavorite = !widget.cryptocurrency.isFavorite;
    if (widget.cryptocurrency.isFavorite) {
      dbHelper.updateCryptocurrency(widget.cryptocurrency);
    } else {
      dbHelper.updateCryptocurrency(widget.cryptocurrency);
    }
    setState(() {
      buttonText = widget.cryptocurrency.isFavorite ? removeToFavourite : addToFavourite;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(widget.cryptocurrency.isFavorite ? 'Added to Favorites' : 'Removed from Favorites'),
    ));
  }
}