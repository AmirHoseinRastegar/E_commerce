import 'package:firebase_e_commerce/core/failure.dart';
import 'package:firebase_e_commerce/data/data_source/search_datasource.dart';

import 'package:firebase_e_commerce/data/model/product_model.dart';

import 'package:fpdart/src/either.dart';

import '../../domain/repository/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource searchDataSource;

  SearchRepositoryImpl({required this.searchDataSource});

  @override
  Future<Either<Failure, List<ProductModel>>> searchedProducts(
      String query) async {
    try {
      final res = await searchDataSource.searchedProducts(query);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
