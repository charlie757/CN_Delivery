class NotificationModel {
  dynamic status;
  dynamic message;
  Data? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  dynamic totalSize;
  dynamic limit;
  dynamic offset;
  List<Notifications>? notifications;

  Data({this.totalSize, this.limit, this.offset, this.notifications});

  Data.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add( Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['total_size'] = totalSize;
    data['limit'] =limit;
    data['offset'] = offset;
    if (notifications != null) {
      data['notifications'] =
          notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  dynamic id;
  dynamic deliveryManId;
  dynamic orderId;
  dynamic description;
  dynamic createdAt;
  dynamic updatedAt;
  Order? order;

  Notifications(
      {this.id,
      this.deliveryManId,
      this.orderId,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.order});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryManId = json['delivery_man_id'];
    orderId = json['order_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'] != null ?  Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['delivery_man_id'] = deliveryManId;
    data['order_id'] = orderId;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class Order {
  dynamic id;
  dynamic customerId;
  dynamic customerType;
  dynamic paymentStatus;
  dynamic orderStatus;
  dynamic paymentMethod;
  dynamic transactionRef;
  dynamic paymentBy;
  dynamic paymentNote;
  dynamic orderAmount;
  dynamic sellerAmount;
  dynamic adminCommission;
  dynamic finalAdminCommission;
  dynamic distributionCommission;
  dynamic isPause;
  dynamic cause;
  dynamic shippingAddress;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic discountAmount;
  dynamic discountType;
  dynamic couponCode;
  dynamic couponDiscountBearer;
  dynamic shippingMethodId;
  dynamic shippingCost;
  dynamic orderGroupId;
  dynamic verificationCode;
  dynamic sellerId;
  dynamic sellerIs;
  dynamic shippingAddressData;
  dynamic deliveryManId;
  dynamic deliverymanCharge;
  dynamic expectedDeliveryDate;
  dynamic orderNote;
  dynamic billingAddress;
  dynamic billingAddressData;
  dynamic orderType;
  dynamic extraDiscount;
  dynamic extraDiscountType;
  dynamic checked;
  dynamic shippingType;
  dynamic deliveryType;
  dynamic deliveryServiceName;
  dynamic thirdPartyDeliveryTrackingId;
  dynamic isWallet;
  dynamic distance;
  dynamic isOrder;
  dynamic userReject;
  Customer? customer;
  Seller? seller;

  Order(
      {this.id,
      this.customerId,
      this.customerType,
      this.paymentStatus,
      this.orderStatus,
      this.paymentMethod,
      this.transactionRef,
      this.paymentBy,
      this.paymentNote,
      this.orderAmount,
      this.sellerAmount,
      this.adminCommission,
      this.finalAdminCommission,
      this.distributionCommission,
      this.isPause,
      this.cause,
      this.shippingAddress,
      this.createdAt,
      this.updatedAt,
      this.discountAmount,
      this.discountType,
      this.couponCode,
      this.couponDiscountBearer,
      this.shippingMethodId,
      this.shippingCost,
      this.orderGroupId,
      this.verificationCode,
      this.sellerId,
      this.sellerIs,
      this.shippingAddressData,
      this.deliveryManId,
      this.deliverymanCharge,
      this.expectedDeliveryDate,
      this.orderNote,
      this.billingAddress,
      this.billingAddressData,
      this.orderType,
      this.extraDiscount,
      this.extraDiscountType,
      this.checked,
      this.shippingType,
      this.deliveryType,
      this.deliveryServiceName,
      this.thirdPartyDeliveryTrackingId,
      this.isWallet,
      this.distance,
      this.isOrder,
      this.userReject,
      this.customer,
      this.seller});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    transactionRef = json['transaction_ref'];
    paymentBy = json['payment_by'];
    paymentNote = json['payment_note'];
    orderAmount = json['order_amount'];
    sellerAmount = json['seller_amount'];
    adminCommission = json['admin_commission'];
    finalAdminCommission = json['final_admin_commission'];
    distributionCommission = json['distribution_commission'];
    isPause = json['is_pause'];
    cause = json['cause'];
    shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discountAmount = json['discount_amount'];
    discountType = json['discount_type'];
    couponCode = json['coupon_code'];
    couponDiscountBearer = json['coupon_discount_bearer'];
    shippingMethodId = json['shipping_method_id'];
    shippingCost = json['shipping_cost'];
    orderGroupId = json['order_group_id'];
    verificationCode = json['verification_code'];
    sellerId = json['seller_id'];
    sellerIs = json['seller_is'];
    shippingAddressData = json['shipping_address_data'];
    deliveryManId = json['delivery_man_id'];
    deliverymanCharge = json['deliveryman_charge'];
    expectedDeliveryDate = json['expected_delivery_date'];
    orderNote = json['order_note'];
    billingAddress = json['billing_address'];
    billingAddressData = json['billing_address_data'];
    orderType = json['order_type'];
    extraDiscount = json['extra_discount'];
    extraDiscountType = json['extra_discount_type'];
    checked = json['checked'];
    shippingType = json['shipping_type'];
    deliveryType = json['delivery_type'];
    deliveryServiceName = json['delivery_service_name'];
    thirdPartyDeliveryTrackingId = json['third_party_delivery_tracking_id'];
    isWallet = json['isWallet'];
    distance = json['distance'];
    isOrder = json['is_order'];
    userReject = json['user_reject'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    seller =
        json['seller'] != null ?  Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['customer_id'] = customerId;
    data['customer_type'] = customerType;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    data['payment_method'] = paymentMethod;
    data['transaction_ref'] = transactionRef;
    data['payment_by'] = paymentBy;
    data['payment_note'] = paymentNote;
    data['order_amount'] = orderAmount;
    data['seller_amount'] = sellerAmount;
    data['admin_commission'] = adminCommission;
    data['final_admin_commission'] = finalAdminCommission;
    data['distribution_commission'] = distributionCommission;
    data['is_pause'] = isPause;
    data['cause'] = cause;
    data['shipping_address'] = shippingAddress;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['discount_amount'] = discountAmount;
    data['discount_type'] = discountType;
    data['coupon_code'] = couponCode;
    data['coupon_discount_bearer'] = couponDiscountBearer;
    data['shipping_method_id'] = shippingMethodId;
    data['shipping_cost'] = shippingCost;
    data['order_group_id'] = orderGroupId;
    data['verification_code'] = verificationCode;
    data['seller_id'] = sellerId;
    data['seller_is'] = sellerIs;
    data['shipping_address_data'] = shippingAddressData;
    data['delivery_man_id'] = deliveryManId;
    data['deliveryman_charge'] = deliverymanCharge;
    data['expected_delivery_date'] = expectedDeliveryDate;
    data['order_note'] = orderNote;
    data['billing_address'] = billingAddress;
    data['billing_address_data'] = billingAddressData;
    data['order_type'] = orderType;
    data['extra_discount'] = extraDiscount;
    data['extra_discount_type'] = extraDiscountType;
    data['checked'] = checked;
    data['shipping_type'] = shippingType;
    data['delivery_type'] = deliveryType;
    data['delivery_service_name'] = deliveryServiceName;
    data['third_party_delivery_tracking_id'] =
        thirdPartyDeliveryTrackingId;
    data['isWallet'] = isWallet;
    data['distance'] = distance;
    data['is_order'] = isOrder;
    data['user_reject'] = userReject;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    return data;
  }
}

class Customer {
  dynamic id;
  dynamic username;
  dynamic name;
  dynamic fName;
  dynamic lName;
  dynamic phone;
  dynamic image;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic streetAddress;
  dynamic country;
  dynamic city;
  dynamic zip;
  dynamic houseNo;
  dynamic apartmentNo;
  dynamic cmFirebaseToken;
  dynamic isActive;
  dynamic paymentCardLastFour;
  dynamic paymentCardBrand;
  dynamic paymentCardFawryToken;
  dynamic loginMedium;
  dynamic socialId;
  dynamic isPhoneVerified;
  dynamic temporaryToken;
  dynamic isEmailVerified;
  double? walletBalance;
  dynamic loyaltyPoint;
  dynamic loginHitCount;
  dynamic isTempBlocked;
  dynamic tempBlockTime;
  dynamic referralCode;
  dynamic youtubeReferralCode;
  dynamic shopReferralCode;
  dynamic useReferralUser;
  dynamic accountNumber;
  dynamic routingNumber;
  dynamic bankName;
  dynamic bankCity;
  dynamic bankCountry;
  dynamic stateId;
  dynamic dob;
  dynamic address;
  dynamic state;
  dynamic referralCount;
  dynamic directMember;
  dynamic totalDirectMember;
  dynamic totalMember;
  dynamic totalMemberId;
  dynamic social;
  dynamic isSocialMediaInfluencer;
  dynamic nextUser;
  dynamic userType;

  Customer(
      {this.id,
      this.username,
      this.name,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.streetAddress,
      this.country,
      this.city,
      this.zip,
      this.houseNo,
      this.apartmentNo,
      this.cmFirebaseToken,
      this.isActive,
      this.paymentCardLastFour,
      this.paymentCardBrand,
      this.paymentCardFawryToken,
      this.loginMedium,
      this.socialId,
      this.isPhoneVerified,
      this.temporaryToken,
      this.isEmailVerified,
      this.walletBalance,
      this.loyaltyPoint,
      this.loginHitCount,
      this.isTempBlocked,
      this.tempBlockTime,
      this.referralCode,
      this.youtubeReferralCode,
      this.shopReferralCode,
      this.useReferralUser,
      this.accountNumber,
      this.routingNumber,
      this.bankName,
      this.bankCity,
      this.bankCountry,
      this.stateId,
      this.dob,
      this.address,
      this.state,
      this.referralCount,
      this.directMember,
      this.totalDirectMember,
      this.totalMember,
      this.totalMemberId,
      this.social,
      this.isSocialMediaInfluencer,
      this.nextUser,
      this.userType});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    streetAddress = json['street_address'];
    country = json['country'];
    city = json['city'];
    zip = json['zip'];
    houseNo = json['house_no'];
    apartmentNo = json['apartment_no'];
    cmFirebaseToken = json['cm_firebase_token'];
    isActive = json['is_active'];
    paymentCardLastFour = json['payment_card_last_four'];
    paymentCardBrand = json['payment_card_brand'];
    paymentCardFawryToken = json['payment_card_fawry_token'];
    loginMedium = json['login_medium'];
    socialId = json['social_id'];
    isPhoneVerified = json['is_phone_verified'];
    temporaryToken = json['temporary_token'];
    isEmailVerified = json['is_email_verified'];
    walletBalance = json['wallet_balance'];
    loyaltyPoint = json['loyalty_point'];
    loginHitCount = json['login_hit_count'];
    isTempBlocked = json['is_temp_blocked'];
    tempBlockTime = json['temp_block_time'];
    referralCode = json['referral_code'];
    youtubeReferralCode = json['youtube_referral_code'];
    shopReferralCode = json['shop_referral_code'];
    useReferralUser = json['use_referral_user'];
    accountNumber = json['account_number'];
    routingNumber = json['routing_number'];
    bankName = json['bank_name'];
    bankCity = json['bank_city'];
    bankCountry = json['bank_country'];
    stateId = json['state_id'];
    dob = json['dob'];
    address = json['address'];
    state = json['state'];
    referralCount = json['referral_count'];
    directMember = json['directMember'];
    totalDirectMember = json['total_direct_member'];
    totalMember = json['total_member'];
    totalMemberId = json['total_member_id'];
    social = json['social'];
    isSocialMediaInfluencer = json['is_socialMediaInfluencer'];
    nextUser = json['next_user'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['street_address'] = streetAddress;
    data['country'] = country;
    data['city'] = city;
    data['zip'] = zip;
    data['house_no'] = houseNo;
    data['apartment_no'] = apartmentNo;
    data['cm_firebase_token'] = cmFirebaseToken;
    data['is_active'] = isActive;
    data['payment_card_last_four'] = paymentCardLastFour;
    data['payment_card_brand'] = paymentCardBrand;
    data['payment_card_fawry_token'] = paymentCardFawryToken;
    data['login_medium'] = loginMedium;
    data['social_id'] = socialId;
    data['is_phone_verified'] = isPhoneVerified;
    data['temporary_token'] = temporaryToken;
    data['is_email_verified'] = isEmailVerified;
    data['wallet_balance'] = walletBalance;
    data['loyalty_point'] = loyaltyPoint;
    data['login_hit_count'] = loginHitCount;
    data['is_temp_blocked'] = isTempBlocked;
    data['temp_block_time'] = tempBlockTime;
    data['referral_code'] = referralCode;
    data['youtube_referral_code'] = youtubeReferralCode;
    data['shop_referral_code'] = shopReferralCode;
    data['use_referral_user'] = useReferralUser;
    data['account_number'] = accountNumber;
    data['routing_number'] = routingNumber;
    data['bank_name'] = bankName;
    data['bank_city'] = bankCity;
    data['bank_country'] = bankCountry;
    data['state_id'] = stateId;
    data['dob'] = dob;
    data['address'] = address;
    data['state'] = state;
    data['referral_count'] = referralCount;
    data['directMember'] = directMember;
    data['total_direct_member'] = totalDirectMember;
    data['total_member'] = totalMember;
    data['total_member_id'] = totalMemberId;
    data['social'] = social;
    data['is_socialMediaInfluencer'] = isSocialMediaInfluencer;
    data['next_user'] = nextUser;
    data['user_type'] = userType;
    return data;
  }
}

class Seller {
  dynamic id;
  dynamic username;
  dynamic fName;
  dynamic lName;
  dynamic phone;
  dynamic image;
  dynamic email;
  dynamic password;
  dynamic status;
  dynamic rememberToken;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic bankName;
  dynamic branch;
  dynamic accountNo;
  dynamic holderName;
  dynamic authToken;
  dynamic salesCommissionPercentage;
  dynamic gst;
  dynamic cmFirebaseToken;
  dynamic posStatus;
  dynamic sundayStartTime;
  dynamic sundayEndTime;
  dynamic mondayStartTime;
  dynamic mondayEndTime;
  dynamic tuesdayStartTime;
  dynamic tuesdayEndTime;
  dynamic wednesdayStartTime;
  dynamic wednesdayEndTime;
  dynamic thursdayStartTime;
  dynamic thursdayEndTime;
  dynamic fridayStartTime;
  dynamic fridayEndTime;
  dynamic saturdayStartTime;
  dynamic saturdayEndTime;
  dynamic commissionPercentageLevel1;
  dynamic commissionPercentageLevel2;
  dynamic commissionPercentageLevel3;
  dynamic commissionPercentageLevel4;
  dynamic commissionPercentageLevel5;
  dynamic walletBalance;
  dynamic temporaryToken;

  Seller(
      {this.id,
      this.username,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      this.password,
      this.status,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.bankName,
      this.branch,
      this.accountNo,
      this.holderName,
      this.authToken,
      this.salesCommissionPercentage,
      this.gst,
      this.cmFirebaseToken,
      this.posStatus,
      this.sundayStartTime,
      this.sundayEndTime,
      this.mondayStartTime,
      this.mondayEndTime,
      this.tuesdayStartTime,
      this.tuesdayEndTime,
      this.wednesdayStartTime,
      this.wednesdayEndTime,
      this.thursdayStartTime,
      this.thursdayEndTime,
      this.fridayStartTime,
      this.fridayEndTime,
      this.saturdayStartTime,
      this.saturdayEndTime,
      this.commissionPercentageLevel1,
      this.commissionPercentageLevel2,
      this.commissionPercentageLevel3,
      this.commissionPercentageLevel4,
      this.commissionPercentageLevel5,
      this.walletBalance,
      this.temporaryToken});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bankName = json['bank_name'];
    branch = json['branch'];
    accountNo = json['account_no'];
    holderName = json['holder_name'];
    authToken = json['auth_token'];
    salesCommissionPercentage = json['sales_commission_percentage'];
    gst = json['gst'];
    cmFirebaseToken = json['cm_firebase_token'];
    posStatus = json['pos_status'];
    sundayStartTime = json['sunday_start_time'];
    sundayEndTime = json['sunday_end_time'];
    mondayStartTime = json['monday_start_time'];
    mondayEndTime = json['monday_end_time'];
    tuesdayStartTime = json['tuesday_start_time'];
    tuesdayEndTime = json['tuesday_end_time'];
    wednesdayStartTime = json['wednesday_start_time'];
    wednesdayEndTime = json['wednesday_end_time'];
    thursdayStartTime = json['thursday_start_time'];
    thursdayEndTime = json['thursday_end_time'];
    fridayStartTime = json['friday_start_time'];
    fridayEndTime = json['friday_end_time'];
    saturdayStartTime = json['saturday_start_time'];
    saturdayEndTime = json['saturday_end_time'];
    commissionPercentageLevel1 = json['commission_percentage_level_1'];
    commissionPercentageLevel2 = json['commission_percentage_level_2'];
    commissionPercentageLevel3 = json['commission_percentage_level_3'];
    commissionPercentageLevel4 = json['commission_percentage_level_4'];
    commissionPercentageLevel5 = json['commission_percentage_level_5'];
    walletBalance = json['wallet_balance'];
    temporaryToken = json['temporary_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['image'] = image;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bank_name'] = bankName;
    data['branch'] = branch;
    data['account_no'] = accountNo;
    data['holder_name'] = holderName;
    data['auth_token'] = authToken;
    data['sales_commission_percentage'] = salesCommissionPercentage;
    data['gst'] = gst;
    data['cm_firebase_token'] = cmFirebaseToken;
    data['pos_status'] = posStatus;
    data['sunday_start_time'] = sundayStartTime;
    data['sunday_end_time'] = sundayEndTime;
    data['monday_start_time'] = mondayStartTime;
    data['monday_end_time'] = mondayEndTime;
    data['tuesday_start_time'] = tuesdayStartTime;
    data['tuesday_end_time'] = tuesdayEndTime;
    data['wednesday_start_time'] = wednesdayStartTime;
    data['wednesday_end_time'] = wednesdayEndTime;
    data['thursday_start_time'] = thursdayStartTime;
    data['thursday_end_time'] = thursdayEndTime;
    data['friday_start_time'] = fridayStartTime;
    data['friday_end_time'] = fridayEndTime;
    data['saturday_start_time'] = saturdayStartTime;
    data['saturday_end_time'] = saturdayEndTime;
    data['commission_percentage_level_1'] = commissionPercentageLevel1;
    data['commission_percentage_level_2'] = commissionPercentageLevel2;
    data['commission_percentage_level_3'] = commissionPercentageLevel3;
    data['commission_percentage_level_4'] = commissionPercentageLevel4;
    data['commission_percentage_level_5'] = commissionPercentageLevel5;
    data['wallet_balance'] = walletBalance;
    data['temporary_token'] = temporaryToken;
    return data;
  }
}
