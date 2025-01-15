import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';
import '../../data/model/carousel_model.dart';

abstract class CarouselRepository{
  Future<Either<Failure, List<CarouselModel>>> fetchCarousel();
}