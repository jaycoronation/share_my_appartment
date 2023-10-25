/// user : {"user_id":"2","name":"Chhatbar mayur","contact":8401358881,"email":"mayur@coronation.in","notification":1,"is_active":1,"timestamp":"28/01/2022","is_id_verified":"1","is_superhero":"1","about_user":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","dob":"681982462","budget":"5000","stay_length":"24","is_ready_to_move":"1","property_preferances":[{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"funrnished room","value":"flexible"},{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"bathroom","value":"flexible"},{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"max no of","value":"2"},{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"internet","value":"required"},{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"parking","value":"on street"}],"preffered_location":[{"location":"prahladnagar"},{"location":"makarba"},{"location":"bopal"}],"age":"30","preferances":[{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"4","preferance":"students"},{"preferance_id":"5","preferance":"no pets"}],"profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg","rating":3.5,"total_review_count":1,"reviews":[{"review":"excellent","review_by":"3","review_by_name":"Maharshi saparia","review_by_profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/164319989020190328153826IMG9308.JPG"}]}
/// message : ""
/// success : 1

class UserProfileResponse {
  UserProfileResponse({
      User? user, 
      String? message, 
      int? success,}){
    _user = user;
    _message = message;
    _success = success;
}

  UserProfileResponse.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _message = json['message'];
    _success = json['success'];
  }
  User? _user;
  String? _message;
  int? _success;

  User? get user => _user;
  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// user_id : "2"
/// name : "Chhatbar mayur"
/// contact : 8401358881
/// email : "mayur@coronation.in"
/// notification : 1
/// is_active : 1
/// timestamp : "28/01/2022"
/// is_id_verified : "1"
/// is_superhero : "1"
/// about_user : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
/// dob : "681982462"
/// budget : "5000"
/// stay_length : "24"
/// is_ready_to_move : "1"
/// property_preferances : [{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"funrnished room","value":"flexible"},{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"bathroom","value":"flexible"},{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"max no of","value":"2"},{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"internet","value":"required"},{"icon":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png","type":"parking","value":"on street"}]
/// preffered_location : [{"location":"prahladnagar"},{"location":"makarba"},{"location":"bopal"}]
/// age : "30"
/// preferances : [{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"4","preferance":"students"},{"preferance_id":"5","preferance":"no pets"}]
/// profile_pic : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg"
/// rating : 3.5
/// total_review_count : 1
/// reviews : [{"review":"excellent","review_by":"3","review_by_name":"Maharshi saparia","review_by_profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/164319989020190328153826IMG9308.JPG"}]

class User {
  User({
      String? userId, 
      String? name, 
      int? contact, 
      String? email, 
      int? notification, 
      int? isActive, 
      String? timestamp, 
      String? isIdVerified, 
      String? isSuperhero, 
      String? aboutUser, 
      String? dob, 
      String? budget, 
      String? stayLength, 
      String? isReadyToMove, 
      List<Property_preferances>? propertyPreferances, 
      List<Preffered_location>? prefferedLocation, 
      String? age, 
      List<Preferances>? preferances, 
      String? profilePic, 
      double? rating, 
      int? totalReviewCount, 
      List<Reviews>? reviews,}){
    _userId = userId;
    _name = name;
    _contact = contact;
    _email = email;
    _notification = notification;
    _isActive = isActive;
    _timestamp = timestamp;
    _isIdVerified = isIdVerified;
    _isSuperhero = isSuperhero;
    _aboutUser = aboutUser;
    _dob = dob;
    _budget = budget;
    _stayLength = stayLength;
    _isReadyToMove = isReadyToMove;
    _propertyPreferances = propertyPreferances;
    _prefferedLocation = prefferedLocation;
    _age = age;
    _preferances = preferances;
    _profilePic = profilePic;
    _rating = rating;
    _totalReviewCount = totalReviewCount;
    _reviews = reviews;
}

  User.fromJson(dynamic json) {
    _userId = json['user_id'];
    _name = json['name'];
    _contact = json['contact'];
    _email = json['email'];
    _notification = json['notification'];
    _isActive = json['is_active'];
    _timestamp = json['timestamp'];
    _isIdVerified = json['is_id_verified'];
    _isSuperhero = json['is_superhero'];
    _aboutUser = json['about_user'];
    _dob = json['dob'];
    _budget = json['budget'];
    _stayLength = json['stay_length'];
    _isReadyToMove = json['is_ready_to_move'];
    if (json['property_preferances'] != null) {
      _propertyPreferances = [];
      json['property_preferances'].forEach((v) {
        _propertyPreferances?.add(Property_preferances.fromJson(v));
      });
    }
    if (json['preffered_location'] != null) {
      _prefferedLocation = [];
      json['preffered_location'].forEach((v) {
        _prefferedLocation?.add(Preffered_location.fromJson(v));
      });
    }
    _age = json['age'];
    if (json['preferances'] != null) {
      _preferances = [];
      json['preferances'].forEach((v) {
        _preferances?.add(Preferances.fromJson(v));
      });
    }
    _profilePic = json['profile_pic'];
    _rating = json['rating'];
    _totalReviewCount = json['total_review_count'];
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
  }
  String? _userId;
  String? _name;
  int? _contact;
  String? _email;
  int? _notification;
  int? _isActive;
  String? _timestamp;
  String? _isIdVerified;
  String? _isSuperhero;
  String? _aboutUser;
  String? _dob;
  String? _budget;
  String? _stayLength;
  String? _isReadyToMove;
  List<Property_preferances>? _propertyPreferances;
  List<Preffered_location>? _prefferedLocation;
  String? _age;
  List<Preferances>? _preferances;
  String? _profilePic;
  double? _rating;
  int? _totalReviewCount;
  List<Reviews>? _reviews;

  String? get userId => _userId;
  String? get name => _name;
  int? get contact => _contact;
  String? get email => _email;
  int? get notification => _notification;
  int? get isActive => _isActive;
  String? get timestamp => _timestamp;
  String? get isIdVerified => _isIdVerified;
  String? get isSuperhero => _isSuperhero;
  String? get aboutUser => _aboutUser;
  String? get dob => _dob;
  String? get budget => _budget;
  String? get stayLength => _stayLength;
  String? get isReadyToMove => _isReadyToMove;
  List<Property_preferances>? get propertyPreferances => _propertyPreferances;
  List<Preffered_location>? get prefferedLocation => _prefferedLocation;
  String? get age => _age;
  List<Preferances>? get preferances => _preferances;
  String? get profilePic => _profilePic;
  double? get rating => _rating;
  int? get totalReviewCount => _totalReviewCount;
  List<Reviews>? get reviews => _reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['name'] = _name;
    map['contact'] = _contact;
    map['email'] = _email;
    map['notification'] = _notification;
    map['is_active'] = _isActive;
    map['timestamp'] = _timestamp;
    map['is_id_verified'] = _isIdVerified;
    map['is_superhero'] = _isSuperhero;
    map['about_user'] = _aboutUser;
    map['dob'] = _dob;
    map['budget'] = _budget;
    map['stay_length'] = _stayLength;
    map['is_ready_to_move'] = _isReadyToMove;
    if (_propertyPreferances != null) {
      map['property_preferances'] = _propertyPreferances?.map((v) => v.toJson()).toList();
    }
    if (_prefferedLocation != null) {
      map['preffered_location'] = _prefferedLocation?.map((v) => v.toJson()).toList();
    }
    map['age'] = _age;
    if (_preferances != null) {
      map['preferances'] = _preferances?.map((v) => v.toJson()).toList();
    }
    map['profile_pic'] = _profilePic;
    map['rating'] = _rating;
    map['total_review_count'] = _totalReviewCount;
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// review : "excellent"
/// review_by : "3"
/// review_by_name : "Maharshi saparia"
/// review_by_profile_pic : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/164319989020190328153826IMG9308.JPG"

class Reviews {
  Reviews({
      String? review, 
      String? reviewBy, 
      String? reviewByName, 
      String? reviewByProfilePic,}){
    _review = review;
    _reviewBy = reviewBy;
    _reviewByName = reviewByName;
    _reviewByProfilePic = reviewByProfilePic;
}

  Reviews.fromJson(dynamic json) {
    _review = json['review'];
    _reviewBy = json['review_by'];
    _reviewByName = json['review_by_name'];
    _reviewByProfilePic = json['review_by_profile_pic'];
  }
  String? _review;
  String? _reviewBy;
  String? _reviewByName;
  String? _reviewByProfilePic;

  String? get review => _review;
  String? get reviewBy => _reviewBy;
  String? get reviewByName => _reviewByName;
  String? get reviewByProfilePic => _reviewByProfilePic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['review'] = _review;
    map['review_by'] = _reviewBy;
    map['review_by_name'] = _reviewByName;
    map['review_by_profile_pic'] = _reviewByProfilePic;
    return map;
  }

}

/// preferance_id : "1"
/// preferance : "working full time"

class Preferances {
  Preferances({
      String? preferanceId, 
      String? preferance,}){
    _preferanceId = preferanceId;
    _preferance = preferance;
}

  Preferances.fromJson(dynamic json) {
    _preferanceId = json['preferance_id'];
    _preferance = json['preferance'];
  }
  String? _preferanceId;
  String? _preferance;

  String? get preferanceId => _preferanceId;
  String? get preferance => _preferance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['preferance_id'] = _preferanceId;
    map['preferance'] = _preferance;
    return map;
  }

}

/// location : "prahladnagar"

class Preffered_location {
  Preffered_location({
      String? location,}){
    _location = location;
}

  Preffered_location.fromJson(dynamic json) {
    _location = json['location'];
  }
  String? _location;

  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location'] = _location;
    return map;
  }

}

/// icon : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/circle.png"
/// type : "funrnished room"
/// value : "flexible"

class Property_preferances {
  Property_preferances({
      String? icon, 
      String? type, 
      String? value,}){
    _icon = icon;
    _type = type;
    _value = value;
}

  Property_preferances.fromJson(dynamic json) {
    _icon = json['icon'];
    _type = json['type'];
    _value = json['value'];
  }
  String? _icon;
  String? _type;
  String? _value;

  String? get icon => _icon;
  String? get type => _type;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = _icon;
    map['type'] = _type;
    map['value'] = _value;
    return map;
  }

}