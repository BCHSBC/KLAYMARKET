import 'package:flutter/material.dart';
import 'package:klaymarket/pages/mint_page.dart';
import 'package:klaymarket/pages/mynft_page.dart';
import 'package:klaymarket/pages/purchase_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    MintPage(),
    MyNFTPage(),
    PurchasePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff010101),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text("BCHS MarketPlace",
            style: TextStyle(fontFamily: 'ONE', fontSize: 30)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.hive_sharp),
            label: 'Mint',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings_sharp),
            label: 'Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_sharp),
            label: 'Purchase',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
        backgroundColor: Colors.black12,
      ),
    );
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
