import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/cryptocurrency.dart';
import 'cryptocurrency_details_page.dart';
import '../data/database_helper.dart';
import '../api_service.dart';



class CryptocurrencyListPage extends StatefulWidget {
  final List<Cryptocurrency> cryptocurrencies;

  CryptocurrencyListPage({required this.cryptocurrencies});

  @override
  _CryptocurrencyListPageState createState() => _CryptocurrencyListPageState();
}

class _CryptocurrencyListPageState extends State<CryptocurrencyListPage> {

  @override
  void initState() {
    super.initState();
    print("CryptocurrencyListPage called");
    // _loadCryptocurrencies();
  }


  Future<void> _refreshFavorites() async {
    // Update the UI
    setState(() {
      _fetchCryptocurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshFavorites,
      child:  FutureBuilder<List<Cryptocurrency>>(
        future: _fetchCryptocurrencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Cryptocurrency> cryptocurrencies = snapshot.data!;
            return Scrollbar(
                isAlwaysShown: true,
                child:  ListView.builder(
              // physics: AlwaysScrollableScrollPhysics(),
              itemCount: cryptocurrencies.length,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final Cryptocurrency cryptocurrency = cryptocurrencies[index];
                return
                  Column(
                    children: [
                    Card(
                    elevation: 0, // Set elevation to 0 to remove the shadow
                    child: ListTile(
                        title: Text('${cryptocurrency.name} (${cryptocurrency.symbol})'),
                      trailing: Icon(Icons.arrow_forward, color: Colors.green,),
                      onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CryptocurrencyDetailsPage(cryptocurrency: cryptocurrency),
                            ),
                          );
                        },
                      )),
                    ],
                  );
              },
            ),);
          }
        },
      ),
    );
  }

  Future<List<Cryptocurrency>> _fetchCryptocurrencies() async {
    try {
      // Fetch cryptocurrencies from the database
      final List<Cryptocurrency> cryptocurrencies = await DatabaseHelper().getCryptocurrencies();
      // If the database is empty, fetch from the API and save to the database
      if (cryptocurrencies.isEmpty) {
        final List<Cryptocurrency> apiCryptocurrencies = await ApiService.fetchCryptocurrencies();
        // await DatabaseHelper().saveCryptocurrencies(apiCryptocurrencies);
        return apiCryptocurrencies;
      } else {
        return cryptocurrencies;
      }
    } catch (error) {
      throw Exception('Failed to load cryptocurrencies: $error');
    }
  }
}
