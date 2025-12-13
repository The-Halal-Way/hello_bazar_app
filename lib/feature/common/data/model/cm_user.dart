// ignore_for_file: public_member_api_docs, sort_constructors_first
class CmUser {
  final String id;
  final String name;
  final String email;
  final String image;
  final String gender;
  final String mobileNo;
  final bool isVerified;
  final DateTime joinDate;
  
  // Additional fields that might be useful
  final String? address;
  final String? nid; // National ID
  final String userType; // 'customer', 'staff', 'admin'
  final double creditLimit;
  final String? notes;
  final bool isActive;
  final DateTime? lastPurchaseDate;
  final double totalSpent;
  final int loyaltyPoints;
  
  CmUser({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.gender,
    required this.mobileNo,
    required this.isVerified,
    required this.joinDate,
    this.address,
    this.nid,
    this.userType = 'customer',
    this.creditLimit = 0.0,
    this.notes,
    this.isActive = true,
    this.lastPurchaseDate,
    this.totalSpent = 0.0,
    this.loyaltyPoints = 0,
  });
}

