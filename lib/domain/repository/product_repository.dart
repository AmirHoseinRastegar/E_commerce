import 'package:firebase_e_commerce/core/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/model/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> fetchProducts();

  Future<Either<Failure, List<ProductModel>>> fetchDiscountedProducts();

  Future<Either<Failure, ProductModel>> getProductDetails(String id);
}
