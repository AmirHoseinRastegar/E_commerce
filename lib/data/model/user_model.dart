class UserModel {
  final String name;
  final String email;
  final String uid;
  final DateTime createdAT;

  UserModel(
      {required this.createdAT,
      required this.name,
      required this.email,
      required this.uid});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uid: json['uid'],
      createdAT: json['created_at'],
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
    DateTime? createdAT,
  }) {
    return UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        createdAT: createdAT ?? this.createdAT);
  }
}
