class UserModel {
  String firstName;
  String lastName;
  String email;
  DateTime dob;
  String gender;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dob,
    required this.gender,
  });

  // Method to convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob.toIso8601String(),
      'gender': gender,
    };
  }
}