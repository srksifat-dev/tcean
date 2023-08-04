
class UserModel {
  final String uid;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final int balance;
  final String? liveActivity;
  final bool isActive;
  String? lastWithdrawID;
  UserModel({
    required this.uid,
    this.name,
    this.phoneNumber,
    this.email,
    required this.balance,
    this.liveActivity,
    required this.isActive,
    this.lastWithdrawID,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? phoneNumber,
    String? email,
    int? balance,
    String? liveActivity,
    bool? isActive,
    String? lastWithdrawID,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      liveActivity: liveActivity ?? this.liveActivity,
      isActive: isActive ?? this.isActive,
      lastWithdrawID: lastWithdrawID ?? this.lastWithdrawID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'balance': balance,
      'liveActivity': liveActivity,
      'isActive': isActive,
      'lastWithdrawID': lastWithdrawID,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      phoneNumber: map["phoneNumber"] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      balance: map['balance'] as int,
      liveActivity:
          map['liveActivity'] != null ? map['liveActivity'] as String : null,
      isActive: map['isActive'] as bool,
      lastWithdrawID: map['lastWithdrawID'] != null
          ? map['lastWithdrawID'] as String
          : null,
    );
  }
}

UserModel dummyAccount = UserModel(
  uid: "uid",
  name: "name",
  phoneNumber: "phoneNumber",
  email: "srksifat.dev@gmail.com",
  balance: 300,
  liveActivity: "Explore screen",
  isActive: true,
);
