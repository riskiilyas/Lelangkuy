class Auction {
  final int id;
  final int userId; // Foreign key for the user who creates the auction
  final String title;
  final String description;
  final double startingPrice;
  // final DateTime startDate;
  // final DateTime endDate;

  Auction({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.startingPrice,
    // required this.startDate,
    // required this.endDate,
  });

  factory Auction.fromJson(Map<String, dynamic> json) {
    return Auction(
      id: json['id'],
      userId: json['userId'], // Assign userId from JSON
      title: json['title'],
      description: json['description'],
      startingPrice: json['startingPrice'].toDouble(),
      // startDate: DateTime.parse(json['startDate']),
      // endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId, // Include userId in the JSON representation
      'title': title,
      'description': description,
      'startingPrice': startingPrice,
      // 'startDate': startDate.toIso8601String(),
      // 'endDate': endDate.toIso8601String(),
    };
  }
}
