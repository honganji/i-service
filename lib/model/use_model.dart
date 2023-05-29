class UserModel {
  String uid;
  String? email;
  String? displayName;

  UserModel({
    required this.uid,
    this.email,
    this.displayName,
  });
}
