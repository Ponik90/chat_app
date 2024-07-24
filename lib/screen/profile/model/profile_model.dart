class ProfileModel {
  String? name, email, phone;

  ProfileModel({this.name, this.phone, this.email});

  factory ProfileModel.mapToModel(Map m1) {
    return ProfileModel(
        name: m1['name'], email: m1['email'], phone: m1['phone']);
  }

  Map<String, dynamic> modelToMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
