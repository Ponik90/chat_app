class UserModel {
  String? name, email, phone, uid;

  UserModel({this.name, this.uid, this.phone, this.email});

  factory UserModel.mapToModel(Map m1) {
    return UserModel(name: m1['name'], email: m1['email'], phone: m1['phone']);
  }
}
