class UserModel {
  final String id;
  final String phone;
  final bool isVerified;
  final String status;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id,
    required this.phone,
    required this.isVerified,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      phone: json['phone'] ?? '',
      isVerified: json['isVerified'] ?? false,
      status: json['status'] ?? 'offline',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'phone': phone,
      'isVerified': isVerified,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
