class User {
  int id; // Add id property
  String name;
  String email;
  String password;

  User({
    required this.id, // Update constructor to include id
    required this.name,
    required this.email,
    required this.password,
  });

  // Factory method to create a User object from a Map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // Initialize id from JSON
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  // Method to convert a User object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
