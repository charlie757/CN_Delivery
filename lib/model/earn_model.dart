class EarnModel {
  dynamic status;
  dynamic message;
  Data? data;

  EarnModel({this.status, this.message, this.data});

  EarnModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic withdrawableBalance;
  dynamic currentBalance;
  dynamic cashInHand;
  dynamic pendingWithdraw;
  dynamic totalWithdraw;
  dynamic totalEarn;

  Data(
      {this.withdrawableBalance,
      this.currentBalance,
      this.cashInHand,
      this.pendingWithdraw,
      this.totalWithdraw,
      this.totalEarn});

  Data.fromJson(Map<String, dynamic> json) {
    withdrawableBalance = json['withdrawable_balance'];
    currentBalance = json['current_balance'];
    cashInHand = json['cash_in_hand'];
    pendingWithdraw = json['pending_withdraw'];
    totalWithdraw = json['total_withdraw'];
    totalEarn = json['total_earn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['withdrawable_balance'] = withdrawableBalance;
    data['current_balance'] = currentBalance;
    data['cash_in_hand'] = cashInHand;
    data['pending_withdraw'] = pendingWithdraw;
    data['total_withdraw'] = totalWithdraw;
    data['total_earn'] = totalEarn;
    return data;
  }
}
