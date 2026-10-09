class DonationModel {
  String id;
  String userId;
  String bankId;
  String bankName;
  DateTime date;
  int pointsEarned;
  String status;

  DonationModel({
    required this.id,
    required this.userId,
    required this.bankId,
    required this.bankName,
    required this.date,
    required this.pointsEarned,
    required this.status,
  });

  factory DonationModel.fromFirestore(Map<String, dynamic> data, String id) {
    return DonationModel(
      id: id,
      userId: data['userId'] ?? '',
      bankId: data['bankId'] ?? '',
      bankName: data['bankName'] ?? '',
      date: data['date'] != null ? DateTime.tryParse(data['date'].toString()) ?? DateTime.now() : DateTime.now(),
      pointsEarned: data['pointsEarned'] ?? 0,
      status: data['status'] ?? 'completed',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'bankId': bankId,
      'bankName': bankName,
      'date': date.toIso8601String(),
      'pointsEarned': pointsEarned,
      'status': status,
    };
  }
}
