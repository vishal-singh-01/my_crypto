import 'package:flutter/material.dart';

import '../models/cryptocurrency.dart';
import 'cryptocurrency_details_page.dart';
import '../data/database_helper.dart';


class FavoritesPage extends StatefulWidget {
  final List<Cryptocurrency> favorites;

  FavoritesPage({required this.favorites});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {


// class FavoritesPage extends StatelessWidget {

  // FavoritesPage({required this.favorites});

  @override
  void initState() {
    super.initState();
    print("FavoritesPage called");
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
            final List<Cryptocurrency> favoriteCryptocurrencies = snapshot.data!;
            if (favoriteCryptocurrencies.isEmpty) {
              return Center(child: Text('No favorite cryptocurrencies.'));
            } else {
              return ListView.builder(
                itemCount: favoriteCryptocurrencies.length,
                itemBuilder: (context, index) {
                  final Cryptocurrency cryptocurrency = favoriteCryptocurrencies[index];
                  return  Card(
                      elevation: 0, // Set elevation to 0 to remove the shadow
                      child: ListTile(
                    title: Text('${cryptocurrency.name} (${cryptocurrency.symbol})'),
                    trailing: Icon(Icons.arrow_forward, color: Colors.green,),

                    onTap: () async {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CryptocurrencyDetailsPage(cryptocurrency: cryptocurrency),
                      //   ),
                      // );

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CryptocurrencyDetailsPage(cryptocurrency: cryptocurrency),
                        ),
                      ).then((value) {
                        setState(() {});
                      }
                      );

                      // print("result $result");
                      // Check if the result is true (indicating an item was removed from favorites)
                      // if (result == true) {
                      //   // Refresh the list of favorite cryptocurrencies
                      //   setState(() {});
                      // }
                    },
                  ));
                },
              );
            }
          }
        },
      ),
    );
  }

  Future<List<Cryptocurrency>> _fetchCryptocurrencies() async {
    try {
      // Fetch cryptocurrencies from the database
      final List<Cryptocurrency> cryptocurrencies = await DatabaseHelper().getFavoriteCryptocurrencies();

      return cryptocurrencies;

    } catch (error) {
      throw Exception('Failed to load cryptocurrencies: $error');
    }
  }

}
