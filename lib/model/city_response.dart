/// cities : [{"city_id":"706","name":"Delhi","state_id":"10","background":"#e91e63","is_mega_city":"1","icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/city/delhi.png"},{"city_id":"783","name":"Ahmedabad","state_id":"12","background":"#ff5722","is_mega_city":"1","icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/city/ahmedabad.png"},{"city_id":"2707","name":"Mumbai","state_id":"22","background":"#673ab7","is_mega_city":"1","icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/city/mumbai.png"},{"city_id":"5583","name":"Kolkata","state_id":"41","background":"#9c27b0","is_mega_city":"1","icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/city/kolkata.png"}]
/// success : 1
/// message : ""

class CityResponse {
  CityResponse({
      List<Cities>? cities, 
      int? success, 
      String? message,}){
    _cities = cities;
    _success = success;
    _message = message;
}

  CityResponse.fromJson(dynamic json) {
    if (json['cities'] != null) {
      _cities = [];
      json['cities'].forEach((v) {
        _cities?.add(Cities.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Cities>? _cities;
  int? _success;
  String? _message;

  List<Cities>? get cities => _cities;
  int? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cities != null) {
      map['cities'] = _cities?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// city_id : "706"
/// name : "Delhi"
/// state_id : "10"
/// background : "#e91e63"
/// is_mega_city : "1"
/// icon : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/city/delhi.png"

class Cities {
  Cities({
      String? cityId, 
      String? name, 
      String? stateId, 
      String? background, 
      String? isMegaCity, 
      String? icon,}){
    _cityId = cityId;
    _name = name;
    _stateId = stateId;
    _background = background;
    _isMegaCity = isMegaCity;
    _icon = icon;
}

  Cities.fromJson(dynamic json) {
    _cityId = json['city_id'];
    _name = json['name'];
    _stateId = json['state_id'];
    _background = json['background'];
    _isMegaCity = json['is_mega_city'];
    _icon = json['icon'];
  }
  String? _cityId;
  String? _name;
  String? _stateId;
  String? _background;
  String? _isMegaCity;
  String? _icon;

  String? get cityId => _cityId;
  String? get name => _name;
  String? get stateId => _stateId;
  String? get background => _background;
  String? get isMegaCity => _isMegaCity;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city_id'] = _cityId;
    map['name'] = _name;
    map['state_id'] = _stateId;
    map['background'] = _background;
    map['is_mega_city'] = _isMegaCity;
    map['icon'] = _icon;
    return map;
  }

}