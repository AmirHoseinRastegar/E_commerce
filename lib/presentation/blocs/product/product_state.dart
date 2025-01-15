part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductModel> productModel;
  final List<CarouselModel> carouselModel;

  ProductSuccess({required this.productModel, required this.carouselModel});

  @override
  List<Object?> get props => [productModel, carouselModel];
}

final class ProductFailed extends ProductState {
  final String message;

  ProductFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
