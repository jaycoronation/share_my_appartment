/// users : [{"user_id":"3","name":"Maharshi saparia","distance":"1.5 Km","profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/164319989020190328153826IMG9308.JPG"},{"user_id":"4","name":"Jay Mistry","distance":"1.5 Km","profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1642773119IMG20211111121343555.jpg"},{"user_id":"5","name":"chhatbar mayur","distance":"1.5 Km","profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1642773300IMG20220121170839855.jpg"},{"user_id":"6","name":"Ravi","distance":"1.5 Km","profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643118149IMG20201227190407698.jpg"}]
/// message : ""
/// success : 1

class UserListResponse {
  UserListResponse({
      List<Users>? users, 
      String? message, 
      int? success,}){
    _users = users;
    _message = message;
    _success = success;
}

  UserListResponse.fromJson(dynamic json) {
    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        _users?.add(Users.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }
  List<Users>? _users;
  String? _message;
  int? _success;

  List<Users>? get users => _users;
  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// user_id : "3"
/// name : "Maharshi saparia"
/// distance : "1.5 Km"
/// profile_pic : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/164319989020190328153826IMG9308.JPG"

class Users {
  Users({
      String? userId, 
      String? name, 
      String? distance, 
      String? profilePic,}){
    _userId = userId;
    _name = name;
    _distance = distance;
    _profilePic = profilePic;
}

  Users.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _distance = json['distance'];
    _profilePic = json['profile_pic'];
  }
  String? _userId;
  String? _name;
  String? _distance;
  String? _profilePic;

  String? get userId => _userId;
  String? get name => _name;
  String? get distance => _distance;
  String? get profilePic => _profilePic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['distance'] = _distance;
    map['profile_pic'] = _profilePic;
    return map;
  }

}