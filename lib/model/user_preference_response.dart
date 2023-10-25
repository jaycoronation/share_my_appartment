/// user_preferances_types : [{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"4","preferance":"students"},{"preferance_id":"5","preferance":"no pets"}]
/// total_records : 5
/// message : ""
/// success : 1

class UserPreferenceResponse {
  UserPreferenceResponse({
      List<UserPreferancesTypes>? userPreferancesTypes, 
      int? totalRecords, 
      String? message, 
      int? success,}){
    _userPreferancesTypes = userPreferancesTypes;
    _totalRecords = totalRecords;
    _message = message;
    _success = success;
}

  UserPreferenceResponse.fromJson(dynamic json) {
    if (json['user_preferances_types'] != null) {
      _userPreferancesTypes = [];
      json['user_preferances_types'].forEach((v) {
        _userPreferancesTypes?.add(UserPreferancesTypes.fromJson(v));
      });
    }
    _totalRecords = json['total_records'];
    _message = json['message'];
    _success = json['success'];
  }
  List<UserPreferancesTypes>? _userPreferancesTypes;
  int? _totalRecords;
  String? _message;
  int? _success;
UserPreferenceResponse copyWith({  List<UserPreferancesTypes>? userPreferancesTypes,
  int? totalRecords,
  String? message,
  int? success,
}) => UserPreferenceResponse(  userPreferancesTypes: userPreferancesTypes ?? _userPreferancesTypes,
  totalRecords: totalRecords ?? _totalRecords,
  message: message ?? _message,
  success: success ?? _success,
);
  List<UserPreferancesTypes>? get userPreferancesTypes => _userPreferancesTypes;
  int? get totalRecords => _totalRecords;
  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userPreferancesTypes != null) {
      map['user_preferances_types'] = _userPreferancesTypes?.map((v) => v.toJson()).toList();
    }
    map['total_records'] = _totalRecords;
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// preferance_id : "1"
/// preferance : "working full time"

class UserPreferancesTypes {
  UserPreferancesTypes({
      String? preferanceId, 
      String? preferance,}){
    _preferanceId = preferanceId;
    _preferance = preferance;
}

  UserPreferancesTypes.fromJson(dynamic json) {
    _preferanceId = json['preferance_id'];
    _preferance = json['preferance'];
  }
  String? _preferanceId;
  String? _preferance;
  bool? _isSelected;
UserPreferancesTypes copyWith({  String? preferanceId,
  String? preferance,
}) => UserPreferancesTypes(  preferanceId: preferanceId ?? _preferanceId,
  preferance: preferance ?? _preferance,
);
  String? get preferanceId => _preferanceId;
  String? get preferance => _preferance;

  bool? get selected => _isSelected;

  set setSelected(bool value) {
    _isSelected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preferance_id'] = _preferanceId;
    map['preferance'] = _preferance;
    return map;
  }

}