import 'package:firebase_e_commerce/core/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../data/model/product_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<ProductModel>>> searchedProducts(String query);
}
