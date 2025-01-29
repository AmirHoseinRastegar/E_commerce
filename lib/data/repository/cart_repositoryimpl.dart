import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_e_commerce/core/failure.dart';

import 'package:firebase_e_commerce/data/model/cart_model.dart';

import 'package:fpdart/src/either.dart';

import '../../domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore firebaseFirestore;

  CartRepositoryImpl({required this.firebaseFirestore});
  @override
  Future<Either<Failure, void>> addToCart(CartModel cartModel, String userId) async{

    try{
      await firebaseFirestore
      .collection('users')
      .doc(userId)
      .collection('cart')
      .doc(cartModel.productId)
      .set(cartModel.toMap());
      return right(null);
    }catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<CartModel>>> fetchCartItems(String userId) {
    return firebaseFirestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) => right<Failure, List<CartModel>>(
      snapshot.docs.map((doc) => CartModel.fromMap(doc.data())).toList(),
    ))
        .handleError((error) {
      return left(Failure(error.toString()));
    });
  }


  @override
  Future<Either<Failure, void>> removeFromCart(String userId, String productId) async{

    try{
      await firebaseFirestore
      .collection('users')
      .doc(userId)
      .collection('cart')
      .doc(productId)
      .delete();
      return right(null);
    }catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuantity(String userId, String productId, int newQuantity) async {

    try{
      await firebaseFirestore
      .collection('users')
      .doc(userId)
      .collection('cart')
      .doc(productId)
      .update({'quantity': newQuantity});
      return right(null);
    }catch(e){
      return left(Failure(e.toString()));
    }
  }

}