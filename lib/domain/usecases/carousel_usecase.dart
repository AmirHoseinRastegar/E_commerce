import 'package:firebase_e_commerce/core/failure.dart';
import 'package:firebase_e_commerce/core/usecase_interface.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
import 'package:firebase_e_commerce/domain/repository/carousel_repository.dart';
import 'package:fpdart/src/either.dart';

import 'fetch_products_usecase.dart';

class CarouselUseCase implements UseCase<List<CarouselModel>, NoParams>{
  final CarouselRepository carouselRepository;
  CarouselUseCase({required this.carouselRepository});
  @override
  Future<Either<Failure, List<CarouselModel>>> call(NoParams params) async{

    return  await carouselRepository.fetchCarousel();
  }
}