class LoginModel {
  dynamic status;
  dynamic message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  dynamic fName;
  dynamic lName;
  dynamic address;
  dynamic countryCode;
  dynamic phone;
  dynamic email;
  dynamic image;
  dynamic isActive;
  dynamic isOnline;
  dynamic fcmToken;
  dynamic identityNumber;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic token;

  Data(
      {this.fName,
      this.lName,
      this.address,
      this.countryCode,
      this.phone,
      this.email,
      this.image,
      this.isActive,
      this.isOnline,
      this.fcmToken,
      this.identityNumber,
      this.city,
      this.state,
      this.country,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    address = json['address'];
    countryCode = json['country_code'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    isActive = json['is_active'];
    isOnline = json['is_online'];
    fcmToken = json['fcm_token'];
    identityNumber = json['identity_number'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['address'] = address;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['is_active'] = isActive;
    data['is_online'] = isOnline;
    data['fcm_token'] = fcmToken;
    data['identity_number'] = identityNumber;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['token'] = token;
    return data;
  }
}
