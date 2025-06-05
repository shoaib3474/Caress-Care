class ProfileService {
  // Simulated user data for demonstration purposes
  Map<String, dynamic> _userData = {
    'firstName': 'John',
    'lastName': 'Doe',
    'email': 'john.doe@example.com',
    'dob': 'January 1, 1990',
    'gender': 'Male',
  };

  // Fetch user profile data
  Future<Map<String, dynamic>> fetchUserProfile() async {
    // Simulate a network call with a delay
    await Future.delayed(Duration(seconds: 2));
    return _userData;
  }

  // Update user profile data
  Future<bool> updateUserProfile(
    Map<String, dynamic> updatedData, {
    required String firstName,
  }) async {
    // Simulate a network call with a delay
    await Future.delayed(Duration(seconds: 2));

    // Update the user data with the new values
    _userData['firstName'] = updatedData['firstName'] ?? _userData['firstName'];
    _userData['lastName'] = updatedData['lastName'] ?? _userData['lastName'];
    _userData['email'] = updatedData['email'] ?? _userData['email'];
    _userData['dob'] = updatedData['dob'] ?? _userData['dob'];
    _userData['gender'] = updatedData['gender'] ?? _userData['gender'];

    return true; // Indicate success
  }
}
