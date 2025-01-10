import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';
import '../../core/usecase_interface.dart';
import '../../data/model/product_model.dart';
import '../repository/product_repository.dart';

class FetchProductUseCase implements UseCase<List<ProductModel>, NoParams> {
  final ProductRepository productRepository;
  FetchProductUseCase({required this.productRepository});
  @override
  Future<Either<Failure, List<ProductModel>>> call(NoParams params) async {
    return await productRepository.fetchProducts();
  }
}

class NoParams {}