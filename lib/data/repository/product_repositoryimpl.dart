import 'package:firebase_e_commerce/data/data_source/product_datasource.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
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


}
