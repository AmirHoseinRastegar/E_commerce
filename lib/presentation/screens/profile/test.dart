
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ProductModel2 {
  final String name;
  final String description;
  final String imageUrl;
  final num price;
  final num discount;
  final bool isDiscounted;
  final String category;

  ProductModel2({
    this.discount = 0.0,
    this.isDiscounted = false,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'discount': discount,
      'isDiscounted': isDiscounted,
      'category': category,
    };
  }
}


class ProductUploader extends StatelessWidget {
  static const String screenRout = '/';
  final List<ProductModel2> products = [
    ProductModel2(
        name: 'Product 1',
        description: 'Description of product 1',
        price: 29.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/0/07/Macbook_Pro_PSD.png',
        category: 'Electronics',
        isDiscounted: false),
    ProductModel2(
      isDiscounted: true,
      discount: 10,
      name: 'Product 2',
      description: 'Description of product 2',
      price: 19.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/0/07/Macbook_Pro_PSD.png',
      category: 'Clothing',
    ),
  ];

  ProductUploader({super.key});

  Future<void> uploadProducts() async {
    final CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('product');

    for (var product in products) {
      try {
        await productsCollection.add(product.toMap());
        print("Product added: ${product.name}");
      } catch (e) {
        print("Failed to add product: ${e.toString()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Products')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadProducts();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Products Uploaded Successfully!')),
            );
          },
          child: const Text('Upload Products to Firebase'),
        ),
      ),
    );
  }
}
