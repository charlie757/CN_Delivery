class ProfileModel {
  dynamic status;
  dynamic message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  dynamic identityImage;
  dynamic gender;
  dynamic longitude;
  dynamic latitude;
  dynamic location;
  dynamic accountApprove;
  dynamic city;
  dynamic country;
  dynamic vehicleType;
  dynamic isVehicleAdd;
  dynamic currentBalance;

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
      this.identityImage,
      this.gender,
      this.longitude,
      this.latitude,
      this.location,
      this.accountApprove,
      this.city,
      this.country,
      this.vehicleType,
      this.isVehicleAdd,
      this.currentBalance});

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
    identityImage = json['identity_image'];
    gender = json['gender'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
    accountApprove = json['account_approve'];
    city = json['city'];
    country = json['country'];
    vehicleType = json['vehicle_type'];
    isVehicleAdd = json['is_vehicle_add'];
    currentBalance = json['current_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
    data['identity_image'] = identityImage;
    data['gender'] = gender;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['location'] = location;
    data['account_approve'] = accountApprove;
    data['city'] = city;
    data['country'] = country;
    data['vehicle_type'] = vehicleType;
    data['is_vehicle_add'] = isVehicleAdd;
    data['current_balance'] = currentBalance;
    return data;
  }
}
