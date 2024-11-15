class WalletEarnModel {
  dynamic status;
  dynamic message;
  Data? data;

  WalletEarnModel({this.status, this.message, this.data});

  WalletEarnModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
  dynamic adminCommission;
  List<TransactionHistory>? transactionHistory;

  Data(
      {this.withdrawableBalance,
      this.currentBalance,
      this.cashInHand,
      this.pendingWithdraw,
      this.totalWithdraw,
      this.totalEarn,
      this.adminCommission,
      this.transactionHistory});

  Data.fromJson(Map<String, dynamic> json) {
    withdrawableBalance = json['withdrawable_balance']??'';
    currentBalance = json['current_balance']??'';
    cashInHand = json['cash_in_hand'];
    pendingWithdraw = json['pending_withdraw']??'';
    totalWithdraw = json['total_withdraw']??'';
    totalEarn = json['total_earn']??'';
    adminCommission = json['admin_commission']??"";
    if (json['transaction_history'] != null) {
      transactionHistory = <TransactionHistory>[];
      json['transaction_history'].forEach((v) {
        transactionHistory!.add( TransactionHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['withdrawable_balance'] = withdrawableBalance;
    data['current_balance'] = currentBalance;
    data['cash_in_hand'] = cashInHand;
    data['pending_withdraw'] = pendingWithdraw;
    data['total_withdraw'] = totalWithdraw;
    data['total_earn'] = totalEarn;
    if (transactionHistory != null) {
      data['transaction_history'] =
          transactionHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionHistory {
  dynamic transactionId;
  dynamic debit;
  dynamic credit;
  dynamic transactionType;
  dynamic createdAt;
  dynamic id;
  dynamic balance;

  TransactionHistory(
      {this.transactionId,
      this.debit,
      this.credit,
      this.transactionType,
      this.createdAt,
      this.id,this.balance});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    debit = json['debit'];
    credit = json['credit'];
    transactionType = json['transaction_type'];
    createdAt = json['created_at'];
    id = json['id'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['transaction_id'] = transactionId;
    data['debit'] = debit;
    data['credit'] = credit;
    data['transaction_type'] = transactionType;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['balance']=balance;
    return data;
  }
}
