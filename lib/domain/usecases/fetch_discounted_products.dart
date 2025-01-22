import 'package:firebase_e_commerce/core/failure.dart';
import 'package:firebase_e_commerce/core/usecase_interface.dart';
import 'package:firebase_e_commerce/data/model/product_model.dart';
import 'package:firebase_e_commerce/domain/repository/product_repository.dart';
import 'package:firebase_e_commerce/domain/usecases/fetch_products_usecase.dart';
import 'package:fpdart/src/either.dart';

class FetchDiscountedUseCase implements UseCase<List<ProductModel>, NoParams> {
  final ProductRepository productRepository;

  FetchDiscountedUseCase({required this.productRepository});

  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) async {
    return await productRepository.fetchDiscountedProducts();
  }
}
