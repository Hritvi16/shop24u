/// status : true
/// data : [{"id":"3","customer_id":"117","product_id":"11139","product_name":"25CM Mini 4 Pin to 1 Sata SSD power supply cables for lenovo M410 M610 M415 B_DS","qty":"2","amount":"799.00","product_image":"https://i0.wp.com/shop24u.com/wp-content/uploads/2022/06/156133.jpg?fit=1280%2C1280&ssl=1","created_date":"2022-07-09 16:10:50"}]

class CartResponse {
  CartResponse({
      bool? status, 
      List<CartData>? data,}){
    _status = status;
    _data = data;
}

  CartResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CartData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<CartData>? _data;

  bool? get status => _status;
  List<CartData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// customer_id : "117"
/// product_id : "11139"
/// product_name : "25CM Mini 4 Pin to 1 Sata SSD power supply cables for lenovo M410 M610 M415 B_DS"
/// qty : "2"
/// amount : "799.00"
/// product_image : "https://i0.wp.com/shop24u.com/wp-content/uploads/2022/06/156133.jpg?fit=1280%2C1280&ssl=1"
/// created_date : "2022-07-09 16:10:50"

class CartData {
  CartData({
      String? id, 
      String? customerId, 
      String? productId, 
      String? productName, 
      String? qty, 
      String? amount, 
      String? productImage, 
      String? createdDate,}){
    _id = id;
    _customerId = customerId;
    _productId = productId;
    _productName = productName;
    _amount = amount;
    _productImage = productImage;
    _createdDate = createdDate;
}

  CartData.fromJson(dynamic json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _productId = json['product_id'];
    _productName = json['product_name'];
     qty = json['qty'];
    _amount = json['amount'];
    _productImage = json['product_image'];
    _createdDate = json['created_date'];
  }
  String? _id;
  String? _customerId;
  String? _productId;
  String? _productName;
  String? qty;
  String? _amount;
  String? _productImage;
  String? _createdDate;

  String? get id => _id;
  String? get customerId => _customerId;
  String? get productId => _productId;
  String? get productName => _productName;
  String? get amount => _amount;
  String? get productImage => _productImage;
  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['customer_id'] = _customerId;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['qty'] = qty;
    map['amount'] = _amount;
    map['product_image'] = _productImage;
    map['created_date'] = _createdDate;
    return map;
  }

}