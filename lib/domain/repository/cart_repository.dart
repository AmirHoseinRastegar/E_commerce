import 'package:fpdart/fpdart.dart';

import '../../core/failure.dart';
import '../../data/model/cart_model.dart';

abstract class CartRepository {
  Stream<Either<Failure, List<CartModel>>> fetchCartItems(String userId);

  Future<Either<Failure, void>> addToCart(CartModel cartModel, String userId);

  Future<Either<Failure, void>> removeFromCart(String userId, String productId);

  Future<Either<Failure, void>> updateQuantity(
      String userId, String productId, int newQuantity);
}
