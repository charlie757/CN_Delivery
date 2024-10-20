class UpcomingOrderModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  UpcomingOrderModel({this.status, this.message, this.data});

  UpcomingOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic orderStatus;
  dynamic paymentMethod;
  dynamic orderAmount;
  dynamic orderDate;
  dynamic deliverymanCharge;
  dynamic distance;
  List<Product>? product;

  Data(
      {this.id,
      this.orderStatus,
      this.paymentMethod,
      this.orderAmount,
      this.orderDate,
      this.deliverymanCharge,
      this.distance,
      this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    orderAmount = json['order_amount'];
    orderDate = json['order_date'];
    deliverymanCharge = json['deliveryman_charge'];
    distance = json['distance'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add( Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['order_status'] = orderStatus;
    data['payment_method'] = paymentMethod;
    data['order_amount'] = orderAmount;
    data['order_date'] = orderDate;
    data['deliveryman_charge'] = deliverymanCharge;
    data['distance'] = distance;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
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
    title = json['title'];
    image = json['image'];
    qty = json['qty'];
    price = json['price'];
    tax = json['tax'];
    discount = json['discount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
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
