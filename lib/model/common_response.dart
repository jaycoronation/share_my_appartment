/// message : "OTP sent to given mobile number"
/// success : 1

class CommonResponse {
  CommonResponse({
      String? message, 
      int? success}){
    _message = message;
    _success = success;
}

  CommonResponse.fromJson(dynamic json) {
    _message = json['message'];
    _success = json['success'];
  }
  String? _message;
  int? _success;

  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }
}