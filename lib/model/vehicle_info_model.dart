class VehicleInfoModel {
  dynamic status;
  dynamic message;
  Data? data;

  VehicleInfoModel({this.status, this.message, this.data});

  VehicleInfoModel.fromJson(Map<String, dynamic> json) {
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
  dynamic vehicleType;
  dynamic vehicleBrand;
  dynamic vehicleSize;
  dynamic vehicleColor;
   String? vehicleName;
  String? vehicleModelNumber;
  String? vehicleDateOfRegistration;
  String? vehicleRegistrationNumber;
  String? vehicleLicenseNumber;
  String? vehicleImage;
  String? vehicleImageTwo;
  String? vehicleLicenseImage;
  String? vehicleInspectionImage;
  String? vehicleInsuranceImage;
  String? vehicleCriminalRecordImage;
  int? isVehicleAdd;

  Data(
      {this.vehicleType,
      this.vehicleBrand,
      this.vehicleSize,
      this.vehicleColor,
      this.vehicleImage,
      this.vehicleName,
      this.vehicleModelNumber,
      this.vehicleDateOfRegistration,
      this.vehicleRegistrationNumber,
      this.vehicleLicenseNumber,
      this.vehicleImageTwo,
      this.vehicleLicenseImage,
      this.vehicleInspectionImage,
      this.vehicleInsuranceImage,
      this.vehicleCriminalRecordImage,
      this.isVehicleAdd});

  Data.fromJson(Map<String, dynamic> json) {
    vehicleType = json['vehicle_type'];
    vehicleBrand = json['vehicle_brand'];
    vehicleSize = json['vehicle_size'];
    vehicleColor = json['vehicle_color'];
    vehicleName = json['vehicle_name'];
    vehicleModelNumber = json['vehicle_model_number'];
    vehicleDateOfRegistration = json['vehicle_date_of_registration'];
    vehicleRegistrationNumber = json['vehicle_registration_number'];
    vehicleLicenseNumber = json['vehicle_license_number'];
    vehicleImage = json['vehicle_image'];
    vehicleImageTwo = json['vehicle_image_two'];
    vehicleLicenseImage = json['vehicle_license_image'];
    vehicleInspectionImage = json['vehicle_inspection_image'];
    vehicleInsuranceImage = json['vehicle_insurance_image'];
    vehicleCriminalRecordImage = json['vehicle_criminal_record_image'];
    isVehicleAdd = json['is_vehicle_add'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['vehicle_type'] = vehicleType;
    data['vehicle_name'] = vehicleName;
    data['vehicle_brand'] = vehicleBrand;
    data['vehicle_size'] = vehicleSize;
    data['vehicle_color'] = vehicleColor;
    data['vehicle_model_number'] = vehicleModelNumber;
    data['vehicle_date_of_registration'] = vehicleDateOfRegistration;
    data['vehicle_registration_number'] = vehicleRegistrationNumber;
    data['vehicle_license_number'] = vehicleLicenseNumber;
    data['vehicle_image'] = vehicleImage;
    data['vehicle_image_two'] = vehicleImageTwo;
    data['vehicle_license_image'] = vehicleLicenseImage;
    data['vehicle_inspection_image'] = vehicleInspectionImage;
    data['vehicle_insurance_image'] = vehicleInsuranceImage;
    data['vehicle_criminal_record_image'] = vehicleCriminalRecordImage;
    data['is_vehicle_add'] = isVehicleAdd;
    return data;
  }
}
