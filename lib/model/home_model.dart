class HomeModel {
  dynamic status;
  dynamic message;
  Data? data;

  HomeModel({this.status, this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  dynamic totalOrders;
  dynamic totalCurrentOrders;
  dynamic totalDeliveredOrders;
  List<CurrentOrdersList>? currentOrdersList;

  Data(
      {this.totalOrders,
      this.totalCurrentOrders,
      this.totalDeliveredOrders,
      this.currentOrdersList});

  Data.fromJson(Map<String, dynamic> json) {
    totalOrders = json['total_orders'] ?? "";
    totalCurrentOrders = json['total_current_orders'] ?? "";
    totalDeliveredOrders = json['total_delivered_orders'] ?? "";
    if (json['current_orders_list'] != null) {
      currentOrdersList = <CurrentOrdersList>[];
      json['current_orders_list'].forEach((v) {
        currentOrdersList!.add(CurrentOrdersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_orders'] = totalOrders;
    data['total_current_orders'] = totalCurrentOrders;
    data['total_delivered_orders'] = totalDeliveredOrders;
    if (currentOrdersList != null) {
      data['current_orders_list'] =
          currentOrdersList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentOrdersList {
  dynamic id;
  dynamic orderStatus;
  dynamic paymentMethod;
  dynamic orderAmount;
  dynamic orderDate;
  dynamic deliverymanCharge;
  List<Product>? product;

  CurrentOrdersList(
      {this.id,
      this.orderStatus,
      this.paymentMethod,
      this.orderAmount,
      this.orderDate,
      this.deliverymanCharge,
      this.product});

  CurrentOrdersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    orderAmount = json['order_amount'];
    orderDate = json['order_date'];
    deliverymanCharge = json['deliveryman_charge'];
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
    data['payment_method'] = paymentMethod;
    data['order_amount'] = orderAmount;
    data['order_date'] = orderDate;
    data['deliveryman_charge'] = deliverymanCharge;
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
