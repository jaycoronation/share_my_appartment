/// types : [{"property_type_id":"1","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png","background":"#d2d2d2","type":"room/bed in bungalow"},{"property_type_id":"2","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png","background":"#d2d2d2","type":"whole property for rent"},{"property_type_id":"3","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png","background":"#d2d2d2","type":"student accomondation"},{"property_type_id":"4","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png","background":"#d2d2d2","type":"grand mothers flat"},{"property_type_id":"5","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png","background":"#d2d2d2","type":"one/bed flat"},{"property_type_id":"6","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png","background":"#d2d2d2","type":"home stay"},{"property_type_id":"7","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png","background":"#d2d2d2","type":"shared room"},{"property_type_id":"8","icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png","background":"#d2d2d2","type":"villas"}]
/// message : ""
/// success : 1

class PropertyTypeResponse {
  PropertyTypeResponse({
    List<Types>? types,
    String? message,
    int? success,
  }) {
    _types = types;
    _message = message;
    _success = success;
  }

  PropertyTypeResponse.fromJson(dynamic json) {
    if (json['types'] != null) {
      _types = [];
      json['types'].forEach((v) {
        _types?.add(Types.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }

  List<Types>? _types;
  String? _message;
  int? _success;

  PropertyTypeResponse copyWith({
    List<Types>? types,
    String? message,
    int? success,
  }) =>
      PropertyTypeResponse(
        types: types ?? _types,
        message: message ?? _message,
        success: success ?? _success,
      );

  List<Types>? get types => _types;

  String? get message => _message;

  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_types != null) {
      map['types'] = _types?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }
}

/// property_type_id : "1"
/// icon : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/property_types/bungalow.png"
/// background : "#d2d2d2"
/// type : "room/bed in bungalow"

class Types {
  Types({
    String? propertyTypeId,
    String? icon,
    String? background,
    String? type,
  }) {
    _propertyTypeId = propertyTypeId;
    _icon = icon;
    _background = background;
    _type = type;
  }

  Types.fromJson(dynamic json) {
    _propertyTypeId = json['property_type_id'];
    _icon = json['icon'];
    _background = json['background'];
    _type = json['type'];
  }

  String? _propertyTypeId;
  String? _icon;
  String? _background;
  String? _type;

  Types copyWith({
    String? propertyTypeId,
    String? icon,
    String? background,
    String? type,
  }) =>
      Types(
        propertyTypeId: propertyTypeId ?? _propertyTypeId,
        icon: icon ?? _icon,
        background: background ?? _background,
        type: type ?? _type,
      );

  String? get propertyTypeId => _propertyTypeId;

  String? get icon => _icon;

  String? get background => _background;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_type_id'] = _propertyTypeId;
    map['icon'] = _icon;
    map['background'] = _background;
    map['type'] = _type;
    return map;
  }
}
