/// data : {"data":{"ID":"117","user_login":"tarak3","user_pass":"$P$BSGW2Z3cmqScon9Z9nSAO7B1ylAW7P0","user_nicename":"tarak3","user_email":"t3@gmail.com","user_url":"","user_registered":"2022-07-09 09:33:00","user_activation_key":"1657359180:$P$BeT/BqhzdrKrYKSXz4QqP9fRG..pm31","user_status":"0","display_name":"tarak3"},"ID":117,"caps":{"customer":true},"cap_key":"wp_capabilities","roles":["customer"],"allcaps":{"read":true,"customer":true},"filter":null}
/// status : true

class LoginResponse {
  LoginResponse({
      Data? data, 
      bool? status,}){
    _data = data;
    _status = status;
}

  LoginResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _status = json['status'];
  }
  Data? _data;
  bool? _status;

  Data? get data => _data;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['status'] = _status;
    return map;
  }

}

/// data : {"ID":"117","user_login":"tarak3","user_pass":"$P$BSGW2Z3cmqScon9Z9nSAO7B1ylAW7P0","user_nicename":"tarak3","user_email":"t3@gmail.com","user_url":"","user_registered":"2022-07-09 09:33:00","user_activation_key":"1657359180:$P$BeT/BqhzdrKrYKSXz4QqP9fRG..pm31","user_status":"0","display_name":"tarak3"}
/// ID : 117
/// caps : {"customer":true}
/// cap_key : "wp_capabilities"
/// roles : ["customer"]
/// allcaps : {"read":true,"customer":true}
/// filter : null

class Data {
  Data({
      SubData? data,
      int? id, 
      Caps? caps, 
      String? capKey, 
      List<String>? roles, 
      Allcaps? allcaps, 
      dynamic filter,}){
    _data = data;
    _id = id;
    _caps = caps;
    _capKey = capKey;
    _roles = roles;
    _allcaps = allcaps;
    _filter = filter;
}

  Data.fromJson(dynamic json) {
    _data = json['data'] != null ? SubData.fromJson(json['data']) : null;
    _id = json['ID'];
    _caps = json['caps'] != null ? Caps.fromJson(json['caps']) : null;
    _capKey = json['cap_key'];
    _roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    _allcaps = json['allcaps'] != null ? Allcaps.fromJson(json['allcaps']) : null;
    _filter = json['filter'];
  }
  SubData? _data;
  int? _id;
  Caps? _caps;
  String? _capKey;
  List<String>? _roles;
  Allcaps? _allcaps;
  dynamic _filter;

  SubData? get data => _data;
  int? get id => _id;
  Caps? get caps => _caps;
  String? get capKey => _capKey;
  List<String>? get roles => _roles;
  Allcaps? get allcaps => _allcaps;
  dynamic get filter => _filter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['ID'] = _id;
    if (_caps != null) {
      map['caps'] = _caps?.toJson();
    }
    map['cap_key'] = _capKey;
    map['roles'] = _roles;
    if (_allcaps != null) {
      map['allcaps'] = _allcaps?.toJson();
    }
    map['filter'] = _filter;
    return map;
  }

}

/// read : true
/// customer : true

class Allcaps {
  Allcaps({
      bool? read, 
      bool? customer,}){
    _read = read;
    _customer = customer;
}

  Allcaps.fromJson(dynamic json) {
    _read = json['read'];
    _customer = json['customer'];
  }
  bool? _read;
  bool? _customer;

  bool? get read => _read;
  bool? get customer => _customer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['read'] = _read;
    map['customer'] = _customer;
    return map;
  }

}

/// customer : true

class Caps {
  Caps({
      bool? customer,}){
    _customer = customer;
}

  Caps.fromJson(dynamic json) {
    _customer = json['customer'];
  }
  bool? _customer;

  bool? get customer => _customer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer'] = _customer;
    return map;
  }

}

/// ID : "117"
/// user_login : "tarak3"
/// user_pass : "$P$BSGW2Z3cmqScon9Z9nSAO7B1ylAW7P0"
/// user_nicename : "tarak3"
/// user_email : "t3@gmail.com"
/// user_url : ""
/// user_registered : "2022-07-09 09:33:00"
/// user_activation_key : "1657359180:$P$BeT/BqhzdrKrYKSXz4QqP9fRG..pm31"
/// user_status : "0"
/// display_name : "tarak3"

class SubData {
  SubData({
      String? id, 
      String? userLogin, 
      String? userPass, 
      String? userNicename, 
      String? userEmail, 
      String? userUrl, 
      String? userRegistered, 
      String? userActivationKey, 
      String? userStatus, 
      String? displayName,}){
    _id = id;
    _userLogin = userLogin;
    _userPass = userPass;
    _userNicename = userNicename;
    _userEmail = userEmail;
    _userUrl = userUrl;
    _userRegistered = userRegistered;
    _userActivationKey = userActivationKey;
    _userStatus = userStatus;
    _displayName = displayName;
}

  SubData.fromJson(dynamic json) {
    _id = json['ID'];
    _userLogin = json['user_login'];
    _userPass = json['user_pass'];
    _userNicename = json['user_nicename'];
    _userEmail = json['user_email'];
    _userUrl = json['user_url'];
    _userRegistered = json['user_registered'];
    _userActivationKey = json['user_activation_key'];
    _userStatus = json['user_status'];
    _displayName = json['display_name'];
  }
  String? _id;
  String? _userLogin;
  String? _userPass;
  String? _userNicename;
  String? _userEmail;
  String? _userUrl;
  String? _userRegistered;
  String? _userActivationKey;
  String? _userStatus;
  String? _displayName;

  String? get id => _id;
  String? get userLogin => _userLogin;
  String? get userPass => _userPass;
  String? get userNicename => _userNicename;
  String? get userEmail => _userEmail;
  String? get userUrl => _userUrl;
  String? get userRegistered => _userRegistered;
  String? get userActivationKey => _userActivationKey;
  String? get userStatus => _userStatus;
  String? get displayName => _displayName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = _id;
    map['user_login'] = _userLogin;
    map['user_pass'] = _userPass;
    map['user_nicename'] = _userNicename;
    map['user_email'] = _userEmail;
    map['user_url'] = _userUrl;
    map['user_registered'] = _userRegistered;
    map['user_activation_key'] = _userActivationKey;
    map['user_status'] = _userStatus;
    map['display_name'] = _displayName;
    return map;
  }

}