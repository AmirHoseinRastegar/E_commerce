import 'package:firebase_e_commerce/core/failure.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/model/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> fetchProducts();
}
