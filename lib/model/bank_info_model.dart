class bankInfoModel {
  dynamic status;
  dynamic message;
  Data? data;

  bankInfoModel({this.status, this.message, this.data});

  bankInfoModel.fromJson(Map<String, dynamic> json) {
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
  dynamic bankName;
  dynamic branch;
  dynamic accountNo;
  dynamic holderName;

  Data({this.bankName, this.branch, this.accountNo, this.holderName});

  Data.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['bank_name'] = bankName;
    data['branch'] = branch;
    data['account_no'] = accountNo;
    data['holder_name'] = holderName;
    return data;
  }
}
