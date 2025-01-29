part of 'cart_bloc.dart';

@immutable
sealed class CartState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}
final class AddToCartButtonSuccess extends CartState {

}
final class CartSuccess extends CartState {
  final List<CartModel> cartItems;

  CartSuccess(this.cartItems);

  @override
  // TODO: implement props
  List<Object?> get props => [cartItems];
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
