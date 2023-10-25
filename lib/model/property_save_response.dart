/// success : 1
/// message : "Property added successfully"
/// property : {"property_id":"19","title":"property on rent in pose area","price":"6000","location_latitude":"23.009530","location_longitude":"72.510960","location":"prahladnagar","beds":"2","bathrooms":"3","balcony":"3","looking_for":"females only","status":"1","rateings":"1","about_property":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s","state_id":"12","property_type_id":"2","max_flatmates":"5","internet":"0","parking":"0","available_from":"1648547020","available_from_format":"29 Mar 2022","property_type":"whole property for rent","is_favourite":0,"state_name":"Gujarat","city_id":"783","city_name":"Ahmedabad","images":[{"is_default":"1","image":""}],"aminities":[{"name":"Home Theater","icon":"https://sma.coronation.in/api/assets/aminities/hometheater.png","background":"#D98880"},{"name":"Gym With Steam Area","icon":"https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png","background":"#F2FF70"},{"name":"Gazebo","icon":"https://sma.coronation.in/api/assets/aminities/gazebo.png","background":"#70FF7D"},{"name":"Indoor Game Zone","icon":"https://sma.coronation.in/api/assets/aminities/hometheater.png","background":"#D98880"},{"name":"Garden","icon":"https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png","background":"#F2FF70"}],"user_details":{"user_id":"2","name":"Chhatbar mayur","contact":8401358881,"email":"mayur@coronation.in","notification":0,"is_active":1,"timestamp":"27/05/2022","is_id_verified":"1","is_superhero":"1","about_user":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","dob":"681982462","budget":"5000","stay_length":"24","is_ready_to_move":"1","property_preferances":[{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"funrnished room","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"bathroom","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"max no of","value":"2"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"internet","value":"required"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"parking","value":"on street"}],"preffered_location":[{"location":"prahladnagar"},{"location":"makarba"},{"location":"bopal"}],"age":"30","preferances":[{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"4","preferance":"students"},{"preferance_id":"5","preferance":"no pets"}],"profile_pic":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg","rating":3.5,"total_review_count":1,"reviews":[{"review":"excellent","review_by":"3","review_by_name":"Maharshi","review_by_profile_pic":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/164880315461172.jpeg"}]}}

class PropertySaveResponse {
  PropertySaveResponse({
      int? success, 
      String? message, 
      Property? property,}){
    _success = success;
    _message = message;
    _property = property;
}

  PropertySaveResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _property = json['property'] != null ? Property.fromJson(json['property']) : null;
  }
  int? _success;
  String? _message;
  Property? _property;
PropertySaveResponse copyWith({  int? success,
  String? message,
  Property? property,
}) => PropertySaveResponse(  success: success ?? _success,
  message: message ?? _message,
  property: property ?? _property,
);
  int? get success => _success;
  String? get message => _message;
  Property? get property => _property;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_property != null) {
      map['property'] = _property?.toJson();
    }
    return map;
  }

}

/// property_id : "19"
/// title : "property on rent in pose area"
/// price : "6000"
/// location_latitude : "23.009530"
/// location_longitude : "72.510960"
/// location : "prahladnagar"
/// beds : "2"
/// bathrooms : "3"
/// balcony : "3"
/// looking_for : "females only"
/// status : "1"
/// rateings : "1"
/// about_property : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
/// state_id : "12"
/// property_type_id : "2"
/// max_flatmates : "5"
/// internet : "0"
/// parking : "0"
/// available_from : "1648547020"
/// available_from_format : "29 Mar 2022"
/// property_type : "whole property for rent"
/// is_favourite : 0
/// state_name : "Gujarat"
/// city_id : "783"
/// city_name : "Ahmedabad"
/// images : [{"is_default":"1","image":""}]
/// aminities : [{"name":"Home Theater","icon":"https://sma.coronation.in/api/assets/aminities/hometheater.png","background":"#D98880"},{"name":"Gym With Steam Area","icon":"https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png","background":"#F2FF70"},{"name":"Gazebo","icon":"https://sma.coronation.in/api/assets/aminities/gazebo.png","background":"#70FF7D"},{"name":"Indoor Game Zone","icon":"https://sma.coronation.in/api/assets/aminities/hometheater.png","background":"#D98880"},{"name":"Garden","icon":"https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png","background":"#F2FF70"}]
/// user_details : {"user_id":"2","name":"Chhatbar mayur","contact":8401358881,"email":"mayur@coronation.in","notification":0,"is_active":1,"timestamp":"27/05/2022","is_id_verified":"1","is_superhero":"1","about_user":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.","dob":"681982462","budget":"5000","stay_length":"24","is_ready_to_move":"1","property_preferances":[{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"funrnished room","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"bathroom","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"max no of","value":"2"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"internet","value":"required"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"parking","value":"on street"}],"preffered_location":[{"location":"prahladnagar"},{"location":"makarba"},{"location":"bopal"}],"age":"30","preferances":[{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"4","preferance":"students"},{"preferance_id":"5","preferance":"no pets"}],"profile_pic":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg","rating":3.5,"total_review_count":1,"reviews":[{"review":"excellent","review_by":"3","review_by_name":"Maharshi","review_by_profile_pic":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/164880315461172.jpeg"}]}

class Property {
  Property({
      String? propertyId, 
      String? title, 
      String? price, 
      String? locationLatitude, 
      String? locationLongitude, 
      String? location, 
      String? beds, 
      String? bathrooms, 
      String? balcony, 
      String? lookingFor, 
      String? status, 
      String? rateings, 
      String? aboutProperty, 
      String? stateId, 
      String? propertyTypeId, 
      String? maxFlatmates, 
      String? internet, 
      String? parking, 
      String? availableFrom, 
      String? availableFromFormat, 
      String? propertyType, 
      int? isFavourite, 
      String? stateName, 
      String? cityId, 
      String? cityName, 
      List<Images>? images, 
      List<Aminities>? aminities, 
      UserDetails? userDetails,}){
    _propertyId = propertyId;
    _title = title;
    _price = price;
    _locationLatitude = locationLatitude;
    _locationLongitude = locationLongitude;
    _location = location;
    _beds = beds;
    _bathrooms = bathrooms;
    _balcony = balcony;
    _lookingFor = lookingFor;
    _status = status;
    _rateings = rateings;
    _aboutProperty = aboutProperty;
    _stateId = stateId;
    _propertyTypeId = propertyTypeId;
    _maxFlatmates = maxFlatmates;
    _internet = internet;
    _parking = parking;
    _availableFrom = availableFrom;
    _availableFromFormat = availableFromFormat;
    _propertyType = propertyType;
    _isFavourite = isFavourite;
    _stateName = stateName;
    _cityId = cityId;
    _cityName = cityName;
    _images = images;
    _aminities = aminities;
    _userDetails = userDetails;
}

  Property.fromJson(dynamic json) {
    _propertyId = json['property_id'];
    _title = json['title'];
    _price = json['price'];
    _locationLatitude = json['location_latitude'];
    _locationLongitude = json['location_longitude'];
    _location = json['location'];
    _beds = json['beds'];
    _bathrooms = json['bathrooms'];
    _balcony = json['balcony'];
    _lookingFor = json['looking_for'];
    _status = json['status'];
    _rateings = json['rateings'];
    _aboutProperty = json['about_property'];
    _stateId = json['state_id'];
    _propertyTypeId = json['property_type_id'];
    _maxFlatmates = json['max_flatmates'];
    _internet = json['internet'];
    _parking = json['parking'];
    _availableFrom = json['available_from'];
    _availableFromFormat = json['available_from_format'];
    _propertyType = json['property_type'];
    _isFavourite = json['is_favourite'];
    _stateName = json['state_name'];
    _cityId = json['city_id'];
    _cityName = json['city_name'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    if (json['aminities'] != null) {
      _aminities = [];
      json['aminities'].forEach((v) {
        _aminities?.add(Aminities.fromJson(v));
      });
    }
    _userDetails = json['user_details'] != null ? UserDetails.fromJson(json['user_details']) : null;
  }
  String? _propertyId;
  String? _title;
  String? _price;
  String? _locationLatitude;
  String? _locationLongitude;
  String? _location;
  String? _beds;
  String? _bathrooms;
  String? _balcony;
  String? _lookingFor;
  String? _status;
  String? _rateings;
  String? _aboutProperty;
  String? _stateId;
  String? _propertyTypeId;
  String? _maxFlatmates;
  String? _internet;
  String? _parking;
  String? _availableFrom;
  String? _availableFromFormat;
  String? _propertyType;
  int? _isFavourite;
  String? _stateName;
  String? _cityId;
  String? _cityName;
  List<Images>? _images;
  List<Aminities>? _aminities;
  UserDetails? _userDetails;
Property copyWith({  String? propertyId,
  String? title,
  String? price,
  String? locationLatitude,
  String? locationLongitude,
  String? location,
  String? beds,
  String? bathrooms,
  String? balcony,
  String? lookingFor,
  String? status,
  String? rateings,
  String? aboutProperty,
  String? stateId,
  String? propertyTypeId,
  String? maxFlatmates,
  String? internet,
  String? parking,
  String? availableFrom,
  String? availableFromFormat,
  String? propertyType,
  int? isFavourite,
  String? stateName,
  String? cityId,
  String? cityName,
  List<Images>? images,
  List<Aminities>? aminities,
  UserDetails? userDetails,
}) => Property(  propertyId: propertyId ?? _propertyId,
  title: title ?? _title,
  price: price ?? _price,
  locationLatitude: locationLatitude ?? _locationLatitude,
  locationLongitude: locationLongitude ?? _locationLongitude,
  location: location ?? _location,
  beds: beds ?? _beds,
  bathrooms: bathrooms ?? _bathrooms,
  balcony: balcony ?? _balcony,
  lookingFor: lookingFor ?? _lookingFor,
  status: status ?? _status,
  rateings: rateings ?? _rateings,
  aboutProperty: aboutProperty ?? _aboutProperty,
  stateId: stateId ?? _stateId,
  propertyTypeId: propertyTypeId ?? _propertyTypeId,
  maxFlatmates: maxFlatmates ?? _maxFlatmates,
  internet: internet ?? _internet,
  parking: parking ?? _parking,
  availableFrom: availableFrom ?? _availableFrom,
  availableFromFormat: availableFromFormat ?? _availableFromFormat,
  propertyType: propertyType ?? _propertyType,
  isFavourite: isFavourite ?? _isFavourite,
  stateName: stateName ?? _stateName,
  cityId: cityId ?? _cityId,
  cityName: cityName ?? _cityName,
  images: images ?? _images,
  aminities: aminities ?? _aminities,
  userDetails: userDetails ?? _userDetails,
);
  String? get propertyId => _propertyId;
  String? get title => _title;
  String? get price => _price;
  String? get locationLatitude => _locationLatitude;
  String? get locationLongitude => _locationLongitude;
  String? get location => _location;
  String? get beds => _beds;
  String? get bathrooms => _bathrooms;
  String? get balcony => _balcony;
  String? get lookingFor => _lookingFor;
  String? get status => _status;
  String? get rateings => _rateings;
  String? get aboutProperty => _aboutProperty;
  String? get stateId => _stateId;
  String? get propertyTypeId => _propertyTypeId;
  String? get maxFlatmates => _maxFlatmates;
  String? get internet => _internet;
  String? get parking => _parking;
  String? get availableFrom => _availableFrom;
  String? get availableFromFormat => _availableFromFormat;
  String? get propertyType => _propertyType;
  int? get isFavourite => _isFavourite;
  String? get stateName => _stateName;
  String? get cityId => _cityId;
  String? get cityName => _cityName;
  List<Images>? get images => _images;
  List<Aminities>? get aminities => _aminities;
  UserDetails? get userDetails => _userDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_id'] = _propertyId;
    map['title'] = _title;
    map['price'] = _price;
    map['location_latitude'] = _locationLatitude;
    map['location_longitude'] = _locationLongitude;
    map['location'] = _location;
    map['beds'] = _beds;
    map['bathrooms'] = _bathrooms;
    map['balcony'] = _balcony;
    map['looking_for'] = _lookingFor;
    map['status'] = _status;
    map['rateings'] = _rateings;
    map['about_property'] = _aboutProperty;
    map['state_id'] = _stateId;
    map['property_type_id'] = _propertyTypeId;
    map['max_flatmates'] = _maxFlatmates;
    map['internet'] = _internet;
    map['parking'] = _parking;
    map['available_from'] = _availableFrom;
    map['available_from_format'] = _availableFromFormat;
    map['property_type'] = _propertyType;
    map['is_favourite'] = _isFavourite;
    map['state_name'] = _stateName;
    map['city_id'] = _cityId;
    map['city_name'] = _cityName;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    if (_aminities != null) {
      map['aminities'] = _aminities?.map((v) => v.toJson()).toList();
    }
    if (_userDetails != null) {
      map['user_details'] = _userDetails?.toJson();
    }
    return map;
  }

}

/// user_id : "2"
/// name : "Chhatbar mayur"
/// contact : 8401358881
/// email : "mayur@coronation.in"
/// notification : 0
/// is_active : 1
/// timestamp : "27/05/2022"
/// is_id_verified : "1"
/// is_superhero : "1"
/// about_user : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
/// dob : "681982462"
/// budget : "5000"
/// stay_length : "24"
/// is_ready_to_move : "1"
/// property_preferances : [{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"funrnished room","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"bathroom","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"max no of","value":"2"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"internet","value":"required"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"parking","value":"on street"}]
/// preffered_location : [{"location":"prahladnagar"},{"location":"makarba"},{"location":"bopal"}]
/// age : "30"
/// preferances : [{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"4","preferance":"students"},{"preferance_id":"5","preferance":"no pets"}]
/// profile_pic : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg"
/// rating : 3.5
/// total_review_count : 1
/// reviews : [{"review":"excellent","review_by":"3","review_by_name":"Maharshi","review_by_profile_pic":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/164880315461172.jpeg"}]

class UserDetails {
  UserDetails({
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
      List<PropertyPreferances>? propertyPreferances, 
      List<PrefferedLocation>? prefferedLocation, 
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

  UserDetails.fromJson(dynamic json) {
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
        _propertyPreferances?.add(PropertyPreferances.fromJson(v));
      });
    }
    if (json['preffered_location'] != null) {
      _prefferedLocation = [];
      json['preffered_location'].forEach((v) {
        _prefferedLocation?.add(PrefferedLocation.fromJson(v));
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
  List<PropertyPreferances>? _propertyPreferances;
  List<PrefferedLocation>? _prefferedLocation;
  String? _age;
  List<Preferances>? _preferances;
  String? _profilePic;
  double? _rating;
  int? _totalReviewCount;
  List<Reviews>? _reviews;
UserDetails copyWith({  String? userId,
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
  List<PropertyPreferances>? propertyPreferances,
  List<PrefferedLocation>? prefferedLocation,
  String? age,
  List<Preferances>? preferances,
  String? profilePic,
  double? rating,
  int? totalReviewCount,
  List<Reviews>? reviews,
}) => UserDetails(  userId: userId ?? _userId,
  name: name ?? _name,
  contact: contact ?? _contact,
  email: email ?? _email,
  notification: notification ?? _notification,
  isActive: isActive ?? _isActive,
  timestamp: timestamp ?? _timestamp,
  isIdVerified: isIdVerified ?? _isIdVerified,
  isSuperhero: isSuperhero ?? _isSuperhero,
  aboutUser: aboutUser ?? _aboutUser,
  dob: dob ?? _dob,
  budget: budget ?? _budget,
  stayLength: stayLength ?? _stayLength,
  isReadyToMove: isReadyToMove ?? _isReadyToMove,
  propertyPreferances: propertyPreferances ?? _propertyPreferances,
  prefferedLocation: prefferedLocation ?? _prefferedLocation,
  age: age ?? _age,
  preferances: preferances ?? _preferances,
  profilePic: profilePic ?? _profilePic,
  rating: rating ?? _rating,
  totalReviewCount: totalReviewCount ?? _totalReviewCount,
  reviews: reviews ?? _reviews,
);
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
  List<PropertyPreferances>? get propertyPreferances => _propertyPreferances;
  List<PrefferedLocation>? get prefferedLocation => _prefferedLocation;
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
/// review_by_name : "Maharshi"
/// review_by_profile_pic : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/164880315461172.jpeg"

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
Reviews copyWith({  String? review,
  String? reviewBy,
  String? reviewByName,
  String? reviewByProfilePic,
}) => Reviews(  review: review ?? _review,
  reviewBy: reviewBy ?? _reviewBy,
  reviewByName: reviewByName ?? _reviewByName,
  reviewByProfilePic: reviewByProfilePic ?? _reviewByProfilePic,
);
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
Preferances copyWith({  String? preferanceId,
  String? preferance,
}) => Preferances(  preferanceId: preferanceId ?? _preferanceId,
  preferance: preferance ?? _preferance,
);
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

class PrefferedLocation {
  PrefferedLocation({
      String? location,}){
    _location = location;
}

  PrefferedLocation.fromJson(dynamic json) {
    _location = json['location'];
  }
  String? _location;
PrefferedLocation copyWith({  String? location,
}) => PrefferedLocation(  location: location ?? _location,
);
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location'] = _location;
    return map;
  }

}

/// icon : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png"
/// type : "funrnished room"
/// value : "flexible"

class PropertyPreferances {
  PropertyPreferances({
      String? icon, 
      String? type, 
      String? value,}){
    _icon = icon;
    _type = type;
    _value = value;
}

  PropertyPreferances.fromJson(dynamic json) {
    _icon = json['icon'];
    _type = json['type'];
    _value = json['value'];
  }
  String? _icon;
  String? _type;
  String? _value;
PropertyPreferances copyWith({  String? icon,
  String? type,
  String? value,
}) => PropertyPreferances(  icon: icon ?? _icon,
  type: type ?? _type,
  value: value ?? _value,
);
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

/// name : "Home Theater"
/// icon : "https://sma.coronation.in/api/assets/aminities/hometheater.png"
/// background : "#D98880"

class Aminities {
  Aminities({
      String? name, 
      String? icon, 
      String? background,}){
    _name = name;
    _icon = icon;
    _background = background;
}

  Aminities.fromJson(dynamic json) {
    _name = json['name'];
    _icon = json['icon'];
    _background = json['background'];
  }
  String? _name;
  String? _icon;
  String? _background;
Aminities copyWith({  String? name,
  String? icon,
  String? background,
}) => Aminities(  name: name ?? _name,
  icon: icon ?? _icon,
  background: background ?? _background,
);
  String? get name => _name;
  String? get icon => _icon;
  String? get background => _background;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['icon'] = _icon;
    map['background'] = _background;
    return map;
  }

}

/// is_default : "1"
/// image : ""

class Images {
  Images({
      String? isDefault, 
      String? image,}){
    _isDefault = isDefault;
    _image = image;
}

  Images.fromJson(dynamic json) {
    _isDefault = json['is_default'];
    _image = json['image'];
  }
  String? _isDefault;
  String? _image;
Images copyWith({  String? isDefault,
  String? image,
}) => Images(  isDefault: isDefault ?? _isDefault,
  image: image ?? _image,
);
  String? get isDefault => _isDefault;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_default'] = _isDefault;
    map['image'] = _image;
    return map;
  }

}