class User {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? role;
  String? address;
  String? imageName;
  String? emailVerifiedAt;
  String? authorization;

  User(
      {this.id,
      this.username,
      this.email,
      this.phone,
      this.role,
      this.address,
      this.imageName,
      this.emailVerifiedAt,
      this.authorization});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    address = json['address'];
    imageName = json['image_name'];
    emailVerifiedAt = json['email_verified_at'];
    authorization = json['Authorization'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['address'] = address;
    data['image_name'] = imageName;
    data['email_verified_at'] = emailVerifiedAt;
    data['Authorization'] = authorization;
    return data;
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, phone: $phone, '
        'role: $role, address: $address, imageName: $imageName, '
        'emailVerifiedAt: $emailVerifiedAt, authorization: $authorization}';
  }
}
