class BloodRequestModel {
  String id;
  String requesterId;
  String requesterName;
  String bloodType;
  String governorate;
  String bankId;
  String bankName;
  String urgency; 
  int units;
  String status; 
  DateTime createdAt;

  BloodRequestModel({
    required this.id,
    required this.requesterId,
    required this.requesterName,
    required this.bloodType,
    required this.governorate,
    required this.bankId,
    required this.bankName,
    required this.urgency,
    required this.units,
    required this.status,
    required this.createdAt,
  });

  factory BloodRequestModel.fromFirestore(Map<String, dynamic> data, String id) {
    return BloodRequestModel(
      id: id,
      requesterId: data['requesterId'] ?? '',
      requesterName: data['requesterName'] ?? '',
      bloodType: data['bloodType'] ?? '',
      governorate: data['governorate'] ?? '',
      bankId: data['bankId'] ?? '',
      bankName: data['bankName'] ?? '',
      urgency: data['urgency'] ?? 'routine',
      units: data['units'] ?? 1,
      status: data['status'] ?? 'pending',
      createdAt: data['createdAt'] != null ? DateTime.tryParse(data['createdAt'].toString()) ?? DateTime.now() : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'requesterId': requesterId,
      'requesterName': requesterName,
      'bloodType': bloodType,
      'governorate': governorate,
      'bankId': bankId,
      'bankName': bankName,
      'urgency': urgency,
      'units': units,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
