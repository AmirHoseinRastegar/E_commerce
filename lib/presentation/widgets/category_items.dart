import 'package:firebase_e_commerce/presentation/screens/categories_view/category_view.dart';
import 'package:flutter/material.dart';

class CategoryItems extends StatelessWidget {
  final String category;

  const CategoryItems({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(CategoriesView.screenRout, arguments: category);


      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 4,
        child: Center(
          child: Text(
            category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

List<String> categories = [
  'tech',
  'kitchen',
  'car and bike',
  'phone',
  'laptop',
  'food',
];
