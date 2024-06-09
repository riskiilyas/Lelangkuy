class AuctionParticipation {
  final int id; // Unique identifier for the participation
  final int userId; // ID of the user who participates
  final int auctionId; // ID of the auction being participated in
  final String bidAmount;

  AuctionParticipation({
    required this.id,
    required this.userId,
    required this.auctionId,
    required this.bidAmount,
  });

  factory AuctionParticipation.fromJson(Map<String, dynamic> json) {
    return AuctionParticipation(
      id: json['id'],
      userId: json['userId'],
      auctionId: json['auctionId'],
      bidAmount: json['bidAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'auctionId': auctionId,
      'bidAmount': bidAmount,
    };
  }
}
