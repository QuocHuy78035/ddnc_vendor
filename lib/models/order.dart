class Orders {
  String? sId;
  User? user;
  Checkout? checkout;
  Payment? payment;
  String? trackingNumber;
  List<Foods>? foods;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? distance;
  int? iV;
  String? shippingAddress;

  Orders(
      {this.sId,
        this.user,
        this.checkout,
        this.payment,
        this.trackingNumber,
        this.foods,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.distance,
        this.iV,
        this.shippingAddress});

  Orders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null
        ? User.fromJson(json['user'])
        : null;
    checkout = json['checkout'] != null
        ? Checkout.fromJson(json['checkout'])
        : null;
    payment =
    json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    trackingNumber = json['trackingNumber'];
    distance = json['distance'];
    if (json['foods'] != null) {
      foods = <Foods>[];
      json['foods'].forEach((v) {
        foods!.add(Foods.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    shippingAddress = json['shipping_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (checkout != null) {
      data['checkout'] = checkout!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    data['trackingNumber'] = trackingNumber;
    data['distance'] = distance;
    if (foods != null) {
      data['foods'] = foods!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['shipping_address'] = shippingAddress;
    return data;
  }
}

class Checkout {
  int? totalPrice;
  int? totalApplyDiscount;
  int? feeShip;
  String? sId;

  Checkout({this.totalPrice, this.totalApplyDiscount, this.feeShip, this.sId});

  Checkout.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    totalApplyDiscount = json['totalApplyDiscount'];
    feeShip = json['feeShip'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPrice'] = totalPrice;
    data['totalApplyDiscount'] = totalApplyDiscount;
    data['feeShip'] = feeShip;
    data['_id'] = sId;
    return data;
  }
}

class User{
  String? userId;
  String? userName;

  User({this.userId, this.userName});

  User.fromJson(Map<String, dynamic> json){
    userId = json['_id'];
    userName = json['name'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = userId;
    data['name'] = userName;
    return data;
  }
}

class Payment {
  String? method;

  Payment({this.method});

  Payment.fromJson(Map<String, dynamic> json) {
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['method'] = method;
    return data;
  }
}

class Foods {
  String? food;
  int? quantity;
  String? sId;

  Foods({this.food, this.quantity, this.sId});

  Foods.fromJson(Map<String, dynamic> json) {
    food = json['food'];
    quantity = json['quantity'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food'] = food;
    data['quantity'] = quantity;
    data['_id'] = sId;
    return data;
  }
}