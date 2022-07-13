/// status : true
/// data : "Successfully added cart"

class Response {
  Response({
      bool? status, 
      String? data,}){
    _status = status;
    _data = data;
}

  Response.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'];
  }
  bool? _status;
  String? _data;

  bool? get status => _status;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['data'] = _data;
    return map;
  }

}