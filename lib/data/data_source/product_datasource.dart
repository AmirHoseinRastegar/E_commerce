import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
import 'package:firebase_e_commerce/data/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts();

  Future<List<ProductModel>> fetchDiscountedProducts();
}

class ProductDataSourceImpl implements ProductDataSource {
  final FirebaseFirestore db;

  ProductDataSourceImpl({required this.db});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final data = await db
          .collection('product')
          .where('isDiscounted', isEqualTo: false )
          .get();
      return data.docs.map((e) {
        return ProductModel.fromJson(e.data(), e.id);
      }).toList();
    } catch (e) {
      print('Error fetching discounted products: $e');

      throw Exception('FAILED TO FETCH PRODUCTS : $e');
    }
  }

  @override
  Future<List<ProductModel>> fetchDiscountedProducts() async {
    try {
      final data = await db
          .collection('product')
          .where('isDiscounted', isEqualTo: true)
          .get();

      return data.docs.map((e) {
        return ProductModel.fromJson(e.data(), e.id);
      }).toList();
    } catch (e) {
      print('Error fetching discounted products: $e');

      throw Exception('FAILED TO FETCH DISCOUNTED PRODUCTS: $e');
    }
  }
}
