class ProfileModel {
  dynamic status;
  dynamic message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  dynamic identityNumber;
  dynamic isProfileComplete;
  dynamic identityType;
  dynamic passportImage;
  dynamic gender;
  dynamic longitude;
  dynamic latitude;
  dynamic location;
  dynamic accountApprove;
  dynamic vehicleName;
  dynamic vehicleType;
  dynamic vehicleModelNumber;
  dynamic vehicleDateOfManufacture;
  dynamic vehicleDateOfRegistration;
  dynamic vehicleRegistrationNumber;
  dynamic vehicleFeuleType;
  dynamic vehicleInsuranceImage;
  dynamic vehicleTouristPermitImage;
  dynamic vehicleImage;
  dynamic drivingLicenseImage;
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
        this.identityNumber,
        this.isProfileComplete,
        this.identityType,
        this.passportImage,
        this.gender,
        this.longitude,
        this.latitude,
        this.location,
        this.accountApprove,
        this.vehicleName,
        this.vehicleType,
        this.vehicleModelNumber,
        this.vehicleDateOfManufacture,
        this.vehicleDateOfRegistration,
        this.vehicleRegistrationNumber,
        this.vehicleFeuleType,
        this.vehicleInsuranceImage,
        this.vehicleTouristPermitImage,
        this.vehicleImage,
        this.drivingLicenseImage,
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
    identityNumber = json['identity_number'];
    isProfileComplete = json['is_profile_complete'];
    identityType = json['identity_type'];
    passportImage = json['passport_image'];
    gender = json['gender'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    location = json['location'];
    accountApprove = json['account_approve'];
    vehicleName = json['vehicle_name'];
    vehicleType = json['vehicle_type'];
    vehicleModelNumber = json['vehicle_model_number'];
    vehicleDateOfManufacture = json['vehicle_date_of_manufacture'];
    vehicleDateOfRegistration = json['vehicle_date_of_registration'];
    vehicleRegistrationNumber = json['vehicle_registration_number'];
    vehicleFeuleType = json['vehicle_feule_type'];
    vehicleInsuranceImage = json['vehicle_insurance_image'];
    vehicleTouristPermitImage = json['vehicle_tourist_permit_image'];
    vehicleImage = json['vehicle_image'];
    drivingLicenseImage = json['driving_license_image'];
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
    data['identity_number'] = identityNumber;
    data['is_profile_complete'] = isProfileComplete;
    data['identity_type'] = identityType;
    data['passport_image'] = passportImage;
    data['gender'] = gender;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['location'] = location;
    data['account_approve'] = accountApprove;
    data['vehicle_name'] = vehicleName;
    data['vehicle_type'] = vehicleType;
    data['vehicle_model_number'] = vehicleModelNumber;
    data['vehicle_date_of_manufacture'] = vehicleDateOfManufacture;
    data['vehicle_date_of_registration'] = vehicleDateOfRegistration;
    data['vehicle_registration_number'] = vehicleRegistrationNumber;
    data['vehicle_feule_type'] = vehicleFeuleType;
    data['vehicle_insurance_image'] = vehicleInsuranceImage;
    data['vehicle_tourist_permit_image'] = vehicleTouristPermitImage;
    data['vehicle_image'] = vehicleImage;
    data['driving_license_image'] = drivingLicenseImage;
    data['current_balance'] = currentBalance;
    return data;
  }
}
