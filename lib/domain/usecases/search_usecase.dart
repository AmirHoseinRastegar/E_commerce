import 'package:firebase_e_commerce/core/failure.dart';
import 'package:firebase_e_commerce/core/usecase_interface.dart';
import 'package:firebase_e_commerce/domain/repository/search_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../data/model/product_model.dart';

class SearchUseCase implements UseCase<List<ProductModel>, String>{
  final SearchRepository searchRepository;

  SearchUseCase({required this.searchRepository});
  @override
  Future<Either<Failure, List<ProductModel>>> call(String params) async {
     final result = await searchRepository.searchedProducts(params);
     return result;
  }
}