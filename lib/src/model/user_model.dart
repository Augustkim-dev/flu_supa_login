class UserModel {
  String? id;
  String? profile_url;
  String name;
  String email;
  String introduce;
  String uid;
  String? createdAt;

  UserModel({
    this.id,
    this.profile_url,
    required this.name,
    required this.email,
    required this.introduce,
    required this.uid,
    this.createdAt,
  });
}
