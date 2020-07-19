import 'package:asuser/screens/filtered_products.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Dresses',
      'Toys',
      'Bay & Kids',
      'Books',
      'Footwears',
      'Bags',
      'Watches',
      'Helth & Beauty',
      'Perfumes',
      'Smartphones',
      'Home Appliance',
      'Kitchen Gadgets',
      'Cleaning Materials',
      'Laptops',
      'Education',
    ];
    void _onCategoryTapped(int index) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return FilteredProductsPage(
            categoryFilter: categories[index],
          );
        }),
      );
    }

    return Scaffold(
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categories[index]),
              onTap: () {
                _onCategoryTapped(index);
              },
            );
          }),
    );
  }
}
