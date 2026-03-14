class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? password;
  String? photo;
  String? createdDate;
  String? sId;

  UserModel(
      {this.email,
        this.firstName,
        this.lastName,
        this.mobile,
        this.password,
        this.photo,
        this.createdDate,
        this.sId});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    password = json['password'];
    photo = json['photo'];
    createdDate = json['createdDate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['password'] = password;
    data['photo'] = photo;
    data['createdDate'] = createdDate;
    data['_id'] = sId;
    return data;
  }
}
