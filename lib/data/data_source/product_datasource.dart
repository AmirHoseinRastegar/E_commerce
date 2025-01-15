import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
import 'package:firebase_e_commerce/data/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts();
}

class ProductDataSourceImpl implements ProductDataSource {
  final FirebaseFirestore db;

  ProductDataSourceImpl({required this.db});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final data = await db.collection('product').get();
      return data.docs.map((e) {
        return ProductModel.fromJson(e.data(), e.id);
      }).toList();
    } catch (e) {
    throw Exception('FAILED TO FETCH PRODUCTS : $e');
    }
    }


  }
