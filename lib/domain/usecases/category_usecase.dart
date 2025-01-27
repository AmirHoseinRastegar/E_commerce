import 'package:firebase_e_commerce/core/usecase_interface.dart';
import 'package:firebase_e_commerce/data/model/product_model.dart';
import 'package:firebase_e_commerce/domain/repository/product_repository.dart';
import 'package:firebase_e_commerce/domain/usecases/fetch_products_usecase.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';
import '../../data/model/carousel_model.dart';

class CategoryUseCase
    implements UseCase<List<ProductModel>, CategoryStringParams> {
  final ProductRepository productRepository;

  CategoryUseCase({required this.productRepository});

  @override
  Future<Either<Failure, List<ProductModel>>> call(
      CategoryStringParams params) async {
    return await productRepository.categoryProducts(params.category);
  }
}

class CategoryStringParams {
  final String category;

  CategoryStringParams(this.category);
}
