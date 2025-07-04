part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartItems extends CartEvent {
  final String userId;

  const LoadCartItems({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class RemoveCartItems extends CartEvent {
  final String userId;
  final String productId;

  const RemoveCartItems({required this.userId, required this.productId});

  @override
  List<Object?> get props => [userId, productId];
}

class AddCartItems extends CartEvent {
  final CartModel cartItem;
  final String userId;

  const AddCartItems({required this.cartItem, required this.userId});

  @override
  List<Object?> get props => [cartItem, userId];
}

class UpdateCartItems extends CartEvent {
  final String userId;
  final String productId;
  final int newQuantity;

  const UpdateCartItems({
    required this.userId,
    required this.productId,
    required this.newQuantity,
  });

  @override
  List<Object?> get props => [userId, productId, newQuantity];
}

class ClearCart extends CartEvent {
  final String userId;

  const ClearCart({required this.userId});

  @override
  List<Object?> get props => [userId];
}
