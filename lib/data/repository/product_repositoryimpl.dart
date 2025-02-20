import 'package:firebase_e_commerce/data/data_source/product_datasource.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';
import '../../domain/repository/product_repository.dart';
import '../model/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl({required this.productDataSource});

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts() async {
    try {
      final res = await productDataSource.fetchProducts();
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchDiscountedProducts() async {
    try {
      final result = await productDataSource.fetchDiscountedProducts();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductDetails(String id) async {
    try {
      final result = await productDataSource.getProductDetails(id);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> categoryProducts(
      String category) async {
    try {
      final res = await productDataSource.getProductCategory(category);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
