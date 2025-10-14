class UserData {
  int? id;
  Null name;
  String? username;
  String? email;
  String? phone;
  Null address;
  bool? isAdmin;
  String? emailVerifiedAt;
  String? createdAt;
  Null activeSubscription;

  UserData({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.address,
    this.isAdmin,
    this.emailVerifiedAt,
    this.createdAt,
    this.activeSubscription,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    isAdmin = json['is_admin'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    activeSubscription = json['active_subscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['is_admin'] = isAdmin;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['active_subscription'] = activeSubscription;
    return data;
  }
}
