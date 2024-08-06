import 'package:flutter/material.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';
import '../../models/product_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomNavBarCurrentIndex = 0;
  Set<int> favoriteProductIds = Set<int>();
  List<Product> favoriteProducts = [];

  void toggleFavorite(int productId, Product product) {
    setState(() {
      if (favoriteProductIds.contains(productId)) {
        favoriteProductIds.remove(productId);
        favoriteProducts.removeWhere((p) => p.id == productId);
      } else {
        favoriteProductIds.add(productId);
        favoriteProducts.add(product);
      }
    });
  }

  List<Widget> _screens() {
    return [
      Home(
        onFavoriteToggle: toggleFavorite,
        favoriteProductIds: favoriteProductIds,
      ),
      FavoritesScreen(
        favoriteProducts: favoriteProducts,
      ),
      Center(child: Text('Account Screen')), // Placeholder for the Account screen
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavBarCurrentIndex,
        onTap: (value) => setState(() {
          bottomNavBarCurrentIndex = value;
        }),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
      body: _screens()[bottomNavBarCurrentIndex],
    );
  }
}
