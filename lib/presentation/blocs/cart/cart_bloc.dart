import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

import '../../../core/failure.dart';
import '../../../data/model/cart_model.dart';
import '../../../domain/repository/cart_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<LoadCartItems>((event, emit) async {
      emit(CartLoading());

      try {
        await emit.forEach(
          cartRepository.fetchCartItems(event.userId),
          // Listening to the stream
          onData: (Either<Failure, List<CartModel>> cartItems) {
            return cartItems.fold(
              (failure) => CartError(failure.toString()), // Handle failure
              (cartList) => CartSuccess(cartList), // Handle success
            );
          },
          onError: (error, stackTrace) =>
              CartError(error.toString()), // Catch errors
        );
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<AddCartItems>((event, emit) async {
      emit(CartLoading());
      try {
        await cartRepository.addToCart(event.cartItem, event.userId);
        emit(AddToCartButtonSuccess());
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<RemoveCartItems>((event, emit) async {
      try {
        await cartRepository.removeFromCart(event.userId, event.productId);
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<UpdateCartItems>((event, emit) async {
      try {
        await cartRepository.updateQuantity(
            event.userId, event.productId, event.newQuantity);
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
}
