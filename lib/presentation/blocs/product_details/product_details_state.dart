part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final ProductModel product;

  ProductDetailsSuccess({required this.product});

  @override
  // TODO: implement props
  List<Object?> get props => [product];
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
