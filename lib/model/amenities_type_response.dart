/// aminities : [{"aminity_id":"1","name":"Home Theater","background":"#D98880","is_active":"1","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/aminities/hometheater.png"},{"aminity_id":"2","name":"Gym With Steam Area","background":"#F2FF70","is_active":"1","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png"},{"aminity_id":"3","name":"Gazebo","background":"#70FF7D","is_active":"1","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/aminities/gazebo.png"},{"aminity_id":"4","name":"Indoor Game Zone","background":"#D98880","is_active":"1","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/aminities/hometheater.png"},{"aminity_id":"5","name":"Garden","background":"#F2FF70","is_active":"1","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png"},{"aminity_id":"6","name":"Splash Pool","background":"#70FF7D","is_active":"1","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/aminities/gazebo.png"}]
/// total_records : 6
/// message : ""
/// success : 1

class AmenitiesTypeResponse {
  AmenitiesTypeResponse({
      List<Aminities>? aminities, 
      int? totalRecords, 
      String? message, 
      int? success,}){
    _aminities = aminities;
    _totalRecords = totalRecords;
    _message = message;
    _success = success;
}

  AmenitiesTypeResponse.fromJson(dynamic json) {
    if (json['aminities'] != null) {
      _aminities = [];
      json['aminities'].forEach((v) {
        _aminities?.add(Aminities.fromJson(v));
      });
    }
    _totalRecords = json['total_records'];
    _message = json['message'];
    _success = json['success'];
  }
  List<Aminities>? _aminities;
  int? _totalRecords;
  String? _message;
  int? _success;
AmenitiesTypeResponse copyWith({  List<Aminities>? aminities,
  int? totalRecords,
  String? message,
  int? success,
}) => AmenitiesTypeResponse(  aminities: aminities ?? _aminities,
  totalRecords: totalRecords ?? _totalRecords,
  message: message ?? _message,
  success: success ?? _success,
);
  List<Aminities>? get aminities => _aminities;
  int? get totalRecords => _totalRecords;
  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aminities != null) {
      map['aminities'] = _aminities?.map((v) => v.toJson()).toList();
    }
    map['total_records'] = _totalRecords;
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// aminity_id : "1"
/// name : "Home Theater"
/// background : "#D98880"
/// is_active : "1"
/// icon : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/aminities/hometheater.png"

class Aminities {
  Aminities({
      String? aminityId, 
      String? name, 
      String? background, 
      String? isActive, 
      String? icon,}){
    _aminityId = aminityId;
    _name = name;
    _background = background;
    _isActive = isActive;
    _icon = icon;
}

  Aminities.fromJson(dynamic json) {
    _aminityId = json['aminity_id'];
    _name = json['name'];
    _background = json['background'];
    _isActive = json['is_active'];
    _icon = json['icon'];
  }
  String? _aminityId;
  String? _name;
  String? _background;
  String? _isActive;
  String? _icon;
  bool? _isSelected;

  Aminities copyWith({  String? aminityId,
  String? name,
  String? background,
  String? isActive,
  String? icon,
}) => Aminities(  aminityId: aminityId ?? _aminityId,
  name: name ?? _name,
  background: background ?? _background,
  isActive: isActive ?? _isActive,
  icon: icon ?? _icon,
);
  String? get aminityId => _aminityId;
  String? get name => _name;
  String? get background => _background;
  String? get isActive => _isActive;
  String? get icon => _icon;

  bool? get selected => _isSelected;

  set setSelected(bool value) {
    _isSelected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aminity_id'] = _aminityId;
    map['name'] = _name;
    map['background'] = _background;
    map['is_active'] = _isActive;
    map['icon'] = _icon;
    return map;
  }

}