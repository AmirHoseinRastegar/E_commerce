import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
import 'package:firebase_e_commerce/data/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts();

  Future<List<ProductModel>> fetchDiscountedProducts();

  Future<ProductModel> getProductDetails(String id);

  Future<List<ProductModel>> getProductCategory(String category);
}

class ProductDataSourceImpl implements ProductDataSource {
  final FirebaseFirestore db;

  ProductDataSourceImpl({required this.db});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final data = await db
          .collection('product')
          .where('isDiscounted', isEqualTo: false)
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

  @override
  Future<ProductModel> getProductDetails(String id) async {
    try {
      final res = await db.collection('product').doc(id).get();
      if (res.exists) {
        return ProductModel.fromJson(res.data()!, res.id);
      } else {
        throw Exception('FAILED TO FETCH PRODUCT DETAILS');
      }
    } catch (e) {
      throw Exception('FAILED TO FETCH PRODUCT DETAILS : $e');
    }
  }

  @override
  Future<List<ProductModel>> getProductCategory(String category) async {
    try {
      final result = await db
          .collection('product')
          .where('category', isEqualTo: category)
          .get();
      return result.docs.map((e) {
        return ProductModel.fromJson(e.data(), e.id);
      }).toList();
    } catch (e) {
      throw Exception('NO PRODUCTS LOADED');
    }
  }
}
