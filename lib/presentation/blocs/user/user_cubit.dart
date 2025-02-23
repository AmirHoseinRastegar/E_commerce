import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../data/model/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirebaseFirestore fireStore;

  UserCubit(this.fireStore) : super(UserInitial());

  Future<void> getUser() async {
    emit(UserLoading());
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      final userDoc = await fireStore.collection('users').doc(user.uid).get();
      // print('this is User UID: ${user.uid}');
      print('User Doc Data: ${userDoc.data()}');
      final userModel = UserModel.fromJson(userDoc.data()!,userDoc.id);
      emit(UserSuccess(userModel));
      print("this is User UID: ${userModel.uid}");
    } catch (e) {
      emit(UserError('Failed to load user data: $e'));
    }
  }
}
