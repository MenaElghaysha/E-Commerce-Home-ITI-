import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Description',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body:  Padding(
        padding: EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to ShopSphere: Your Personalized Shopping Hub!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Dive into ShopSphere, where finding and managing your favorite products has never been easier. With our app, you can enjoy:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              _buildFeatureRow(Icons.shopping_basket, 'Diverse Product Range:',
                  'Explore an extensive selection of products, from tech gadgets to stylish apparel, all presented with rich details and vibrant images.'),
              SizedBox(height: 20),
              _buildFeatureRow(Icons.search, 'Smart Search and Filters:',
                  'Effortlessly locate products with our powerful search tools and customizable filters. Narrow down your choices by category, price, and more.'),
              SizedBox(height: 20),
              _buildFeatureRow(Icons.favorite, 'Organized Wishlists:',
                  'Save your top picks and create personalized wishlists to keep track of items you love.'),
              SizedBox(height: 20),
              _buildFeatureRow(Icons.visibility, 'Detailed Product Views:',
                  'Access in-depth information on each product, including specifications, pricing, and high-quality visuals.'),
              SizedBox(height: 30),
              Text(
                'Download ShopSphere now and experience the future of shopping at your fingertips!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 30, color: Colors.black),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
