class ViewOrderModel {
  dynamic id;
  dynamic orderStatus;
  Customer? customer;
  ShippingAddress? shippingAddress;
  PickUp? pickUp;
  Shop? shop;
  dynamic paymentMethod;
  dynamic orderAmount;
  dynamic orderDate;
  dynamic distance;
  dynamic deliverymanCharge;
  dynamic expectedDeliveryDate;
  List<Product>? product;

  ViewOrderModel(
      {this.id,
      this.orderStatus,
      this.customer,
      this.shippingAddress,
      this.pickUp,
      this.shop,
      this.paymentMethod,
      this.orderAmount,
      this.orderDate,
      this.distance,
      this.deliverymanCharge,
      this.expectedDeliveryDate,
      this.product});

  ViewOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatus = json['order_status'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    pickUp = json['pick_up'] != null ? PickUp.fromJson(json['pick_up']) : null;
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    paymentMethod = json['payment_method'];
    orderAmount = json['order_amount'] ?? "";
    orderDate = json['order_date'];
    distance = json['distance'];
    deliverymanCharge = json['deliveryman_charge'];
    expectedDeliveryDate = json['expected_delivery_date'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['order_status'] = orderStatus;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (shippingAddress != null) {
      data['shipping_address'] = shippingAddress!.toJson();
    }
    if (pickUp != null) {
      data['pick_up'] = pickUp!.toJson();
    }
    data['payment_method'] = paymentMethod;
    data['order_amount'] = orderAmount;
    data['order_date'] = orderDate;
    data['distance'] = distance;
    data['deliveryman_charge'] = deliverymanCharge;
    data['expected_delivery_date'] = expectedDeliveryDate;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  dynamic id;
  dynamic fName;
  dynamic lName;
  dynamic phone;
  dynamic email;
  dynamic image;

  Customer(
      {this.id, this.fName, this.lName, this.phone, this.email, this.image});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'] ?? "";
    lName = json['l_name'] ?? "";
    phone = json['phone'] ?? "'";
    email = json['email'] ?? '';
    image = json['image'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}

class ShippingAddress {
  dynamic contactPersonName;
  dynamic phone;
  dynamic addressType;
  dynamic address;
  dynamic city;
  dynamic zip;
  dynamic country;
  dynamic state;

  ShippingAddress(
      {this.contactPersonName,
      this.phone,
      this.addressType,
      this.address,
      this.city,
      this.zip,
      this.country,
      this.state});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    contactPersonName = json['contact_person_name'];
    phone = json['phone'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['contact_person_name'] = contactPersonName;
    data['phone'] = phone;
    data['address_type'] = addressType;
    data['address'] = address;
    data['city'] = city;
    data['zip'] = zip;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}

class PickUp {
  dynamic name;
  dynamic address;
  dynamic contact;
  dynamic city;
  dynamic country;

  PickUp({this.name, this.address, this.contact, this.city, this.country});

  PickUp.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['address'] = address;
    data['contact'] = contact;
    data['city'] = city;
    data['country'] = country;
    return data;
  }
}

class Shop {
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic address;
  dynamic contact;
  dynamic city;
  dynamic country;
  dynamic image;

  Shop(
      {this.name,
      this.email,
      this.phone,
      this.address,
      this.contact,
      this.city,
      this.country,
      this.image});

  Shop.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    phone = json['phone'] ?? "";
    address = json['address'];
    contact = json['contact'] ?? "";
    city = json['city'];
    country = json['country'];
    image = json['image'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['contact'] = contact;
    data['city'] = city;
    data['country'] = country;
    data['image'] = image;
    return data;
  }
}

class Product {
  dynamic title;
  dynamic image;
  dynamic qty;
  dynamic price;
  dynamic tax;
  dynamic discount;
  dynamic total;

  Product(
      {this.title,
      this.image,
      this.qty,
      this.price,
      this.tax,
      this.discount,
      this.total});

  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    image = json['image'] ?? '';
    qty = json['qty'] ?? "";
    price = json['price'] ?? "";
    tax = json['tax'] ?? "";
    discount = json['discount'] ?? "";
    total = json['total'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['image'] = image;
    data['qty'] = qty;
    data['price'] = price;
    data['tax'] = tax;
    data['discount'] = discount;
    data['total'] = total;
    return data;
  }
}
