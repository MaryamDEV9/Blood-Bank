class BloodBankModel {
  String id;
  String name;
  String nameEn;
  String address;
  String addressEn;
  String governorate;
  String city;
  String phone;
  double? lat;
  double? lng;
  Map<String, int> inventory;
  bool isVerified;
  String? adminId;
  DateTime? updatedAt;

  BloodBankModel({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.address,
    required this.addressEn,
    required this.governorate,
    required this.city,
    required this.phone,
    this.lat,
    this.lng,
    required this.inventory,
    this.isVerified = false,
    this.adminId,
    this.updatedAt,
  });

  factory BloodBankModel.fromFirestore(Map<String, dynamic> data, String id) {
    return BloodBankModel(
      id: id,
      name: data['name'] ?? '',
      nameEn: data['nameEn'] ?? '',
      address: data['address'] ?? '',
      addressEn: data['addressEn'] ?? '',
      governorate: data['governorate'] ?? '',
      city: data['city'] ?? '',
      phone: data['phone'] ?? '',
      lat: (data['lat'] as num?)?.toDouble(),
      lng: (data['lng'] as num?)?.toDouble(),
      inventory: Map<String, int>.from(data['inventory'] ?? {}),
      isVerified: data['isVerified'] ?? false,
      adminId: data['adminId'],
      updatedAt: data['updatedAt'] != null ? DateTime.tryParse(data['updatedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'nameEn': nameEn,
      'address': address,
      'addressEn': addressEn,
      'governorate': governorate,
      'city': city,
      'phone': phone,
      'lat': lat,
      'lng': lng,
      'inventory': inventory,
      'isVerified': isVerified,
      'adminId': adminId,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  BloodBankModel copyWith({
    String? id,
    String? name,
    String? nameEn,
    String? address,
    String? addressEn,
    String? governorate,
    String? city,
    String? phone,
    double? lat,
    double? lng,
    Map<String, int>? inventory,
    bool? isVerified,
    String? adminId,
    DateTime? updatedAt,
  }) {
    return BloodBankModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      address: address ?? this.address,
      addressEn: addressEn ?? this.addressEn,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      inventory: inventory ?? this.inventory,
      isVerified: isVerified ?? this.isVerified,
      adminId: adminId ?? this.adminId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
