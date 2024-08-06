import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Product> favoriteProducts;

  FavoritesScreen({required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            Text(
              "Favorite Products",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: favoriteProducts.isEmpty
                  ? Center(child: Text('No favorite products yet'))
                  : GridView.builder(
                      itemCount: favoriteProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        final product = favoriteProducts[index];
                        return InkWell(
                          onTap: () {
                            // Handle product tap
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        product.thumbnail ?? '',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    product.title ?? '',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.price.toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.attach_money,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
