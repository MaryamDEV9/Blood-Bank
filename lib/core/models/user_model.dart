class UserModel {
  String uid;
  String name;
  String email;
  String bloodType;
  String governorate;
  String phone;
  int points;
  bool isAdmin;
  bool isDonor;
  DateTime? lastDonation;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bloodType,
    required this.governorate,
    required this.phone,
    this.points = 0,
    this.isAdmin = false,
    this.isDonor = false,
    this.lastDonation,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      bloodType: data['bloodType'] ?? '',
      governorate: data['governorate'] ?? '',
      phone: data['phone'] ?? '',
      points: data['points'] ?? 0,
      isAdmin: data['isAdmin'] ?? false,
      isDonor: data['isDonor'] ?? false,
      lastDonation: data['lastDonation'] != null ? DateTime.tryParse(data['lastDonation'].toString()) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'bloodType': bloodType,
      'governorate': governorate,
      'phone': phone,
      'points': points,
      'isAdmin': isAdmin,
      'isDonor': isDonor,
      'lastDonation': lastDonation?.toIso8601String(),
    };
  }
}
