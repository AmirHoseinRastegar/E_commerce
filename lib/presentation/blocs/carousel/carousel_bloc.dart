import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_e_commerce/data/model/carousel_model.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/carousel_usecase.dart';
import '../../../domain/usecases/fetch_products_usecase.dart';

part 'carousel_event.dart';
part 'carousel_state.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  final CarouselUseCase carouselUseCase;
  CarouselBloc({required this.carouselUseCase}) : super(CarouselInitial()) {
    on<FetchCarouselEvent>(onCarouselFetch);
  }
  void onCarouselFetch(
      FetchCarouselEvent event, Emitter<CarouselState> emit) async {
    emit(CarouseLoading());
    try {
      final res = await carouselUseCase.call(NoParams());
      res.fold(
            (l) => emit(
          CarouselFailed(message: l.message),
        ),
            (r) => emit(
          CarouseSuccess(bannerUrl: r),
        ),
      );
    } catch (e) {
      emit(CarouselFailed(message: e.toString()));
    }
  }
}
