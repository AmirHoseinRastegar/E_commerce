import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final String uid;
  final Timestamp createdAT;

  UserModel(
      {required this.createdAT,
      required this.name,
      required this.email,
      required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json,String uid) {
    return UserModel(
      name: json['name']??'',
      email: json['email']??'',
      uid: uid,
      createdAT: json['created_at']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'created_at': createdAT,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
    Timestamp? createdAT,
  }) {
    return UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        createdAT: createdAT ?? this.createdAT);
  }
}
