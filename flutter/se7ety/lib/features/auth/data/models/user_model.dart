class UserModel {
  String? uid;
  String? email;
  String? name;
  String? image;
  String? userType;
  bool? isCompletedProfile;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.image,
    this.userType,
    this.isCompletedProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      image: json['image'],
      userType: json['userType'],
      isCompletedProfile: json['isCompletedProfile'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['name'] = name;
    data['image'] = image;
    data['userType'] = userType;
    data['isCompletedProfile'] = isCompletedProfile;
    return data;
  }

  Map<String, dynamic> toUpdateData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (uid != null) data['uid'] = uid;
    if (email != null) data['email'] = email;
    if (name != null) data['name'] = name;
    if (image != null) data['image'] = image;
    if (userType != null) data['userType'] = userType;
    if (isCompletedProfile != null) {
      data['isCompletedProfile'] = isCompletedProfile;
    }
    return data;
  }
}
