import 'package:firebase_e_commerce/core/failure.dart';
import 'package:firebase_e_commerce/data/data_source/carousel_datasource.dart';

import 'package:firebase_e_commerce/data/model/carousel_model.dart';

import 'package:fpdart/src/either.dart';

import '../../domain/repository/carousel_repository.dart';

class CarouselRepositoryImpl extends CarouselRepository {
  final CarouselDataSource carouselDataSource;

  CarouselRepositoryImpl({required this.carouselDataSource});

  @override
  Future<Either<Failure, List<CarouselModel>>> fetchCarousel() async {
    try {
      final result = await carouselDataSource.fetchCarousel();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
