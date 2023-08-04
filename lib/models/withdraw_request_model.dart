class WithdrawRequestModel {
  final String withdrawRequestID;
  final String date;
  final String uid;
  final int amount;
  final String paymentMethod;
  final String gatewayNumber;
  final String withdrawStatus;
  WithdrawRequestModel({
    required this.withdrawRequestID,
    required this.date,
    required this.uid,
    required this.amount,
    required this.paymentMethod,
    required this.gatewayNumber,
    required this.withdrawStatus,
  });

  WithdrawRequestModel copyWith({
    String? withdrawRequestID,
    String? date,
    String? uid,
    int? amount,
    String? paymentMethod,
    String? gatewayNumber,
    String? withdrawStatus,
  }) {
    return WithdrawRequestModel(
      withdrawRequestID: withdrawRequestID ?? this.withdrawRequestID,
      date: date ?? this.date,
      uid: uid ?? this.uid,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      gatewayNumber: gatewayNumber ?? this.gatewayNumber,
      withdrawStatus: withdrawStatus ?? this.withdrawStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'withdrawRequestID': withdrawRequestID,
      'date': date,
      'uid': uid,
      'amount': amount,
      'paymentMethod': paymentMethod,
      'gatewayNumber': gatewayNumber,
      'withdrawStatus': withdrawStatus,
    };
  }

  factory WithdrawRequestModel.fromMap(Map<String, dynamic> map) {
    return WithdrawRequestModel(
      withdrawRequestID: map['withdrawRequestID'] as String,
      date: map['date'] as String,
      uid: map['uid'] as String,
      amount: map['amount'] as int,
      paymentMethod: map['paymentMethod'] as String,
      gatewayNumber: map['gatewayNumber'] as String,
      withdrawStatus: map['withdrawStatus'] as String,
    );
  }
}
