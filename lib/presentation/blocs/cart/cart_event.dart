part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadCartItems extends CartEvent {
  final String userId;

  LoadCartItems({required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class RemoveCartItems extends CartEvent {
  final String userId;
  final String productId;

  RemoveCartItems({required this.userId, required this.productId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId, productId];
}

class AddCartItems extends CartEvent {
  final CartModel cartItem;
  final String userId;

  AddCartItems({
    required this.cartItem,
    required this.userId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userId, cartItem];
}

class UpdateCartItems extends CartEvent {
  final String userId;
  final String productId;
  final int newQuantity; //new quantity

  UpdateCartItems(
      {required this.userId,
      required this.productId,
      required this.newQuantity});

  @override
  // TODO: implement props
  List<Object?> get props => [userId, productId, newQuantity];
}
