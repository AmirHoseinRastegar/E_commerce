part of 'carousel_bloc.dart';

@immutable
sealed class CarouselState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CarouselInitial extends CarouselState {}
final class CarouseLoading extends CarouselState {}
final class CarouseSuccess extends CarouselState {

  final List<CarouselModel> bannerUrl;
  CarouseSuccess({required this.bannerUrl});
}
final class CarouselFailed extends CarouselState {

  final String message;
  CarouselFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
