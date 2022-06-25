/// status : true
/// data : [{"id":146,"name":"Cables &amp; Connectors","image":null},{"id":208,"name":"Compatible Adapters","image":null},{"id":248,"name":"Compatible Battery","image":null},{"id":528,"name":"Converters","image":null},{"id":284,"name":"COOLING PAD","image":null},{"id":160,"name":"Laptop Adapter","image":null},{"id":142,"name":"Laptop Battery","image":null},{"id":158,"name":"Laptop Cabinet","image":null},{"id":164,"name":"Laptop CPU Fans","image":null},{"id":161,"name":"Laptop Dc Jacks","image":null},{"id":170,"name":"Laptop Dvd / Optical Drive","image":null},{"id":171,"name":"Laptop Hard Disk","image":null},{"id":166,"name":"Laptop Hinges","image":null},{"id":162,"name":"Laptop Internal Speaker","image":null},{"id":154,"name":"Laptop Keypad","image":null},{"id":168,"name":"Laptop Lvds / Display Cable","image":null},{"id":167,"name":"Laptop On Off Switch","image":null},{"id":169,"name":"Laptop Ram","image":null},{"id":153,"name":"Laptop Screens","image":null},{"id":165,"name":"Laptop Tools","image":null},{"id":163,"name":"Laptop Topcover","image":null},{"id":506,"name":"Lenovo","image":{"id":10990,"date_created":"2022-05-02T14:28:57","date_created_gmt":"2022-05-02T14:28:57","date_modified":"2022-05-02T14:28:57","date_modified_gmt":"2022-05-02T14:28:57","src":"https://shop24u.com/wp-content/uploads/2022/05/png-clipart-logo-brand-lenovo-thinkpad-ideapad-strategic-blue-text.png","name":"png-clipart-logo-brand-lenovo-thinkpad-ideapad-strategic-blue-text","alt":""}},{"id":508,"name":"NVME SSD","image":null},{"id":519,"name":"Offer of the Day","image":null},{"id":209,"name":"Original Adapter","image":null},{"id":246,"name":"Original Battery","image":null},{"id":79,"name":"Peripherals","image":null},{"id":513,"name":"Power Supply / Smps","image":null},{"id":507,"name":"SSD HARDISK","image":null},{"id":526,"name":"Tonner/Cartridge","image":null},{"id":291,"name":"TOUCHPAD / PALMREST","image":null},{"id":269,"name":"WEBCAM","image":null},{"id":282,"name":"Wireless Keyboard","image":null}]

class CategoryResponse {
  CategoryResponse({
      bool? status, 
      List<CategoryData>? data,}){
    _status = status;
    _data = data;
}

  CategoryResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<CategoryData>? _data;

  bool? get status => _status;
  List<CategoryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 146
/// name : "Cables &amp; Connectors"
/// image : null

class CategoryData {
  CategoryData({
      int? id, 
      String? name, 
      Images? image,}){
    _id = id;
    _name = name;
    _image = image;
}

  CategoryData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = Images.fromJson(json['image']??{});
  }
  int? _id;
  String? _name;
  Images? _image;

  int? get id => _id;
  String? get name => _name;
  Images? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image?.toJson();
    return map;
  }

}

class Images {
  Images({
      int? id,
      String? src, }){
    _id = id;
    _src = src;
}

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _src = json['src'];
  }
  int? _id;
  String? _src;

  int? get id => _id;
  String? get src => _src;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['src'] = _src;
    return map;
  }

}