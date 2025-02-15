import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_model.dart';

abstract class SearchDataSource {
  Future<List<ProductModel>> searchedProducts(String query);
}

class SearchDataSourceImpl implements SearchDataSource {
  final FirebaseFirestore firebaseFireStore;

  SearchDataSourceImpl({required this.firebaseFireStore});

  @override
  Future<List<ProductModel>> searchedProducts(String query) async {
    try {
      final result = await firebaseFireStore
          .collection('product')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '${query}z')
          .get();
      return result.docs
          .map((e) => ProductModel.fromJson(e.data(), e.id))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
