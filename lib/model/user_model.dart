class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? dob;
  final String? gender;
  final String? avatarPath;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.gender,
    this.avatarPath,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'dob': dob,
    'gender': gender,
    'avatarPath': avatarPath,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    dob: json['dob'],
    gender: json['gender'],
    avatarPath: json['avatarPath'],
  );
}
