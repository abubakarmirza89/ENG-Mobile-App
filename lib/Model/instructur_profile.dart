class instructorr {
  int? id;
  String? password;
  Null? lastLogin;
  String? name;
  Null? image;
  String? surname;
  String? email;
  String? title;
  Null? bio;
  String? phone;
  Null? address;
  String? nationality;
  Null? birthdate;
  bool? isStaff;
  bool? isSuperuser;
  bool? isActive;
  String? resetToken;
  Null? profileImage;
  String? userId;
  String? userType;
  String? rewardPoints;
  int? engTokens;
  String? joinedOn;

  instructorr(
      {this.id,
        this.password,
        this.lastLogin,
        this.name,
        this.image,
        this.surname,
        this.email,
        this.title,
        this.bio,
        this.phone,
        this.address,
        this.nationality,
        this.birthdate,
        this.isStaff,
        this.isSuperuser,
        this.isActive,
        this.resetToken,
        this.profileImage,
        this.userId,
        this.userType,
        this.rewardPoints,
        this.engTokens,
        this.joinedOn});

  instructorr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    lastLogin = json['last_login'];
    name = json['name'];
    image = json['image'];
    surname = json['surname'];
    email = json['email'];
    title = json['title'];
    bio = json['bio'];
    phone = json['phone'];
    address = json['address'];
    nationality = json['nationality'];
    birthdate = json['birthdate'];
    isStaff = json['is_staff'];
    isSuperuser = json['is_superuser'];
    isActive = json['is_active'];
    resetToken = json['reset_token'];
    profileImage = json['profile_image'];
    userId = json['user_id'];
    userType = json['user_type'];
    rewardPoints = json['reward_points'];
    engTokens = json['eng_tokens'];
    joinedOn = json['joined_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['last_login'] = this.lastLogin;
    data['name'] = this.name;
    data['image'] = this.image;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['title'] = this.title;
    data['bio'] = this.bio;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['nationality'] = this.nationality;
    data['birthdate'] = this.birthdate;
    data['is_staff'] = this.isStaff;
    data['is_superuser'] = this.isSuperuser;
    data['is_active'] = this.isActive;
    data['reset_token'] = this.resetToken;
    data['profile_image'] = this.profileImage;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['reward_points'] = this.rewardPoints;
    data['eng_tokens'] = this.engTokens;
    data['joined_on'] = this.joinedOn;
    return data;
  }
}
