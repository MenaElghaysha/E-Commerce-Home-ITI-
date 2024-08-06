import 'package:flutter/material.dart';
import '../../customs/most_popular_bottom.dart';
import '../../dio/api_provider.dart';
import '../../models/product_model.dart';

class Home extends StatefulWidget {
  final void Function(int, Product) onFavoriteToggle;
  final Set<int> favoriteProductIds;

  Home({required this.onFavoriteToggle, required this.favoriteProductIds});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<ProductsModel?> futureProducts;
  String selectedCategory = 'All';
  final List<String> categories = [
    "All",
    "beauty",
    "fragrances",
    "furniture",
    "groceries",
  ];

  @override
  void initState() {
    super.initState();
    futureProducts = ApiProvider().getProducts();
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Discover",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          hintText: "Search",
                          controller: controller,
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 32.0)),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                        );
                      },
                      suggestionsBuilder: (BuildContext context, SearchController controller) {
                        final query = controller.value.text.toLowerCase();
                        final filteredCategories = categories
                            .where((category) =>
                            category.toLowerCase().contains(query))
                            .toList();

                        return List<ListTile>.generate(
                          filteredCategories.length,
                              (int index) {
                            final String category = filteredCategories[index];
                            return ListTile(
                              title: Text(category),
                              onTap: () {
                                setState(() {
                                  selectCategory(category);
                                  controller.closeView(category);
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[850],
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.filter_alt_sharp),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  return CustomMostPopularButton(
                    function: () => selectCategory(category),
                    text: category,
                    selected: selectedCategory == category,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            Expanded(
              child: FutureBuilder<ProductsModel?>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final products = snapshot.data?.products ?? [];
                    final filteredProducts = selectedCategory == 'All'
                        ? products
                        : products.where((product) =>
                    product.category?.name.toLowerCase() ==
                        selectedCategory.toLowerCase()).toList();
                    return GridView.builder(
                      itemCount: filteredProducts.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        final isFavorite = widget.favoriteProductIds.contains(product.id);
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
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.network(
                                            product.thumbnail ?? '',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.favorite_rounded,
                                                  color: isFavorite ? Colors.red : Colors.black,
                                                ),
                                                onPressed: () {
                                                  widget.onFavoriteToggle(product.id ?? 0, product);
                                                },
                                                iconSize: 20,
                                                padding: EdgeInsets.zero,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                    );
                  } else {
                    return Center(child: Text('No products found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
