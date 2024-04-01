import 'package:flutter/material.dart';
import 'package:my_crypto/view/cryptocurrency_list_page.dart';
import 'package:my_crypto/view/favorites_page.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'api_service.dart';
import 'models/cryptocurrency.dart';
import 'data/database_helper.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FFI
  // sqfliteFfiInit();

  // Change the default factory. On iOS/Android, if not using `sqlite_flutter_lib` you can forget
  // this step, it will use the sqlite version available on the system.
  // databaseFactory = databaseFactoryFfi;

  final dbHelper = DatabaseHelper();

  // The first time you access the database property,
  // _initDatabase will be called to initialize the database
  final db = await dbHelper.database;
  runApp( MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptocurrency App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Cryptocurrency> _cryptocurrencies = [];
  List<Cryptocurrency> _favorites = [];

  @override
  void initState() {
    super.initState();
    print("MyHomePage called");
    // _loadCryptocurrencies();
  }

  Future<void> _loadCryptocurrencies() async {
    try {
      print("_loadCryptocurrencies called");

      final List<Cryptocurrency> cryptocurrencies = await ApiService.fetchCryptocurrencies();
      setState(() {
        _cryptocurrencies = cryptocurrencies;
      });
    } catch (e) {
      print('Error loading cryptocurrencies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cryptocurrency App'),
          bottom: TabBar(
            tabs: [
              Tab(child: Text(
                'Current cryptocurrencies',
                style: TextStyle(fontSize: 14), // Adjust the font size as needed
              )),
              Tab(child: Text(
                'Favorites',
                style: TextStyle(fontSize: 14), // Adjust the font size as needed
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CryptocurrencyListPage(cryptocurrencies: _cryptocurrencies),
            FavoritesPage(favorites: _favorites),
          ],
        ),
      ),
    );
  }
}