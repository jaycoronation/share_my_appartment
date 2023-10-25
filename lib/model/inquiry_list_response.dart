/// inquiries : [{"id":"2","property_id":"3","email":"mayur@coronation.in","contact":"8401358881","name":"chhatbar mayur","message":"this is message","date":"04/04/2022","title":"property on rent in pose area","location":"Prahlad Nagar\nPrahlad Nagar, Ahmedabad, Gujarat 380015, India","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/3/property_on_rent_in_pose_area_1648818112_0.jpg"},{"id":"1","property_id":"3","email":"mayur@coronation.in","contact":"8401358881","name":"chhatbar mayur","message":"this is message","date":"28/03/2022","title":"property on rent in pose area","location":"Prahlad Nagar\nPrahlad Nagar, Ahmedabad, Gujarat 380015, India","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/3/property_on_rent_in_pose_area_1648818112_0.jpg"}]
/// total_records : 2
/// message : ""
/// success : 1

class InquiryListResponse {
  InquiryListResponse({
      List<Inquiries>? inquiries, 
      int? totalRecords, 
      String? message, 
      int? success,}){
    _inquiries = inquiries;
    _totalRecords = totalRecords;
    _message = message;
    _success = success;
}

  InquiryListResponse.fromJson(dynamic json) {
    if (json['inquiries'] != null) {
      _inquiries = [];
      json['inquiries'].forEach((v) {
        _inquiries?.add(Inquiries.fromJson(v));
      });
    }
    _totalRecords = json['total_records'];
    _message = json['message'];
    _success = json['success'];
  }
  List<Inquiries>? _inquiries;
  int? _totalRecords;
  String? _message;
  int? _success;
InquiryListResponse copyWith({  List<Inquiries>? inquiries,
  int? totalRecords,
  String? message,
  int? success,
}) => InquiryListResponse(  inquiries: inquiries ?? _inquiries,
  totalRecords: totalRecords ?? _totalRecords,
  message: message ?? _message,
  success: success ?? _success,
);
  List<Inquiries>? get inquiries => _inquiries;
  int? get totalRecords => _totalRecords;
  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_inquiries != null) {
      map['inquiries'] = _inquiries?.map((v) => v.toJson()).toList();
    }
    map['total_records'] = _totalRecords;
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// id : "2"
/// property_id : "3"
/// email : "mayur@coronation.in"
/// contact : "8401358881"
/// name : "chhatbar mayur"
/// message : "this is message"
/// date : "04/04/2022"
/// title : "property on rent in pose area"
/// location : "Prahlad Nagar\nPrahlad Nagar, Ahmedabad, Gujarat 380015, India"
/// image : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/3/property_on_rent_in_pose_area_1648818112_0.jpg"

class Inquiries {
  Inquiries({
      String? id, 
      String? propertyId, 
      String? email, 
      String? contact, 
      String? name, 
      String? message, 
      String? date, 
      String? title, 
      String? location, 
      String? image,}){
    _id = id;
    _propertyId = propertyId;
    _email = email;
    _contact = contact;
    _name = name;
    _message = message;
    _date = date;
    _title = title;
    _location = location;
    _image = image;
}

  Inquiries.fromJson(dynamic json) {
    _id = json['id'];
    _propertyId = json['property_id'];
    _email = json['email'];
    _contact = json['contact'];
    _name = json['name'];
    _message = json['message'];
    _date = json['date'];
    _title = json['title'];
    _location = json['location'];
    _image = json['image'];
  }
  String? _id;
  String? _propertyId;
  String? _email;
  String? _contact;
  String? _name;
  String? _message;
  String? _date;
  String? _title;
  String? _location;
  String? _image;
Inquiries copyWith({  String? id,
  String? propertyId,
  String? email,
  String? contact,
  String? name,
  String? message,
  String? date,
  String? title,
  String? location,
  String? image,
}) => Inquiries(  id: id ?? _id,
  propertyId: propertyId ?? _propertyId,
  email: email ?? _email,
  contact: contact ?? _contact,
  name: name ?? _name,
  message: message ?? _message,
  date: date ?? _date,
  title: title ?? _title,
  location: location ?? _location,
  image: image ?? _image,
);
  String? get id => _id;
  String? get propertyId => _propertyId;
  String? get email => _email;
  String? get contact => _contact;
  String? get name => _name;
  String? get message => _message;
  String? get date => _date;
  String? get title => _title;
  String? get location => _location;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['property_id'] = _propertyId;
    map['email'] = _email;
    map['contact'] = _contact;
    map['name'] = _name;
    map['message'] = _message;
    map['date'] = _date;
    map['title'] = _title;
    map['location'] = _location;
    map['image'] = _image;
    return map;
  }

}