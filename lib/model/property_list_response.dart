/// properties : [{"property_id":"7","title":"Vishnudhara Gardens","price":"25000","location_latitude":"23.1021793","location_longitude":"72.5440941","location":"Shree Vishnudhara Homes Shayona Green, Devnagar Rd, Behind Vodafone tower, Gota, Ahmedabad, Gujarat 382481, India","beds":"3","bathrooms":"3","balcony":"1","looking_for":"Male","status":"0","rateings":"1","about_property":"This is for testing","property_type_id":"1","max_flatmates":"6","internet":"1","parking":"1","available_from":"1651343400","available_from_format":"01 May 2022","property_type":"room/bed in bungalow","is_favourite":1,"state_name":"","city_id":"706","city_name":"Delhi","images":[{"is_default":"1","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Orchid_Heaven_1648818161_0.JPG"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Orchid_Heaven_1648818161_1.JPG"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Orchid_Heaven_1648818161_2.JPG"},{"is_default":"1","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Vishnudhara_Gardens_1649063547_0.png"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Vishnudhara_Gardens_1649063547_1.png"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Vishnudhara_Gardens_1649063547_2.png"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Vishnudhara_Gardens_1649063547_3.png"}],"aminities":[{"name":"Home Theater","icon":"https://sma.coronation.in/api/assets/aminities/hometheater.png","background":"#D98880"},{"name":"Indoor Game Zone","icon":"https://sma.coronation.in/api/assets/aminities/hometheater.png","background":"#D98880"},{"name":"Garden","icon":"https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png","background":"#F2FF70"},{"name":"Gym With Steam Area","icon":"https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png","background":"#F2FF70"}],"user_details":{"user_id":"3","name":"Maharshi saparia","contact":9376976464,"email":"maharshi@coronation.in","notification":0,"is_active":1,"timestamp":"01/04/2022","is_id_verified":"1","is_superhero":"1","about_user":"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia","dob":"650446462","budget":"6000","stay_length":"12","is_ready_to_move":"1","property_preferances":[{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"funrnished room","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"bathroom","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"max no of","value":"2"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"internet","value":"required"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"parking","value":"on street"}],"preffered_location":[{"location":"shela"},{"location":"south bopal"},{"location":"bopal"}],"age":"31","preferances":[{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"5","preferance":"no pets"}],"profile_pic":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/164880315461172.jpeg","rating":3.5,"total_review_count":5},"user_property_preferance":[{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"5","preferance":"no pets"},{"preferance_id":"4","preferance":"students"}]}]
/// total_records : 6
/// message : ""
/// success : 1

class PropertyListResponse {
  PropertyListResponse({
      List<Properties>? properties, 
      int? totalRecords, 
      String? message, 
      int? success,}){
    _properties = properties;
    _totalRecords = totalRecords;
    _message = message;
    _success = success;
}

  PropertyListResponse.fromJson(dynamic json) {
    if (json['properties'] != null) {
      _properties = [];
      json['properties'].forEach((v) {
        _properties?.add(Properties.fromJson(v));
      });
    }
    _totalRecords = json['total_records'];
    _message = json['message'];
    _success = json['success'];
  }
  List<Properties>? _properties;
  int? _totalRecords;
  String? _message;
  int? _success;
PropertyListResponse copyWith({  List<Properties>? properties,
  int? totalRecords,
  String? message,
  int? success,
}) => PropertyListResponse(  properties: properties ?? _properties,
  totalRecords: totalRecords ?? _totalRecords,
  message: message ?? _message,
  success: success ?? _success,
);
  List<Properties>? get properties => _properties;
  int? get totalRecords => _totalRecords;
  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_properties != null) {
      map['properties'] = _properties?.map((v) => v.toJson()).toList();
    }
    map['total_records'] = _totalRecords;
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// property_id : "7"
/// title : "Vishnudhara Gardens"
/// price : "25000"
/// location_latitude : "23.1021793"
/// location_longitude : "72.5440941"
/// location : "Shree Vishnudhara Homes Shayona Green, Devnagar Rd, Behind Vodafone tower, Gota, Ahmedabad, Gujarat 382481, India"
/// beds : "3"
/// bathrooms : "3"
/// balcony : "1"
/// looking_for : "Male"
/// status : "0"
/// rateings : "1"
/// about_property : "This is for testing"
/// property_type_id : "1"
/// max_flatmates : "6"
/// internet : "1"
/// parking : "1"
/// available_from : "1651343400"
/// available_from_format : "01 May 2022"
/// property_type : "room/bed in bungalow"
/// is_favourite : 1
/// state_name : ""
/// city_id : "706"
/// city_name : "Delhi"
/// images : [{"is_default":"1","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Orchid_Heaven_1648818161_0.JPG"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Orchid_Heaven_1648818161_1.JPG"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Orchid_Heaven_1648818161_2.JPG"},{"is_default":"1","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Vishnudhara_Gardens_1649063547_0.png"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Vishnudhara_Gardens_1649063547_1.png"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Vishnudhara_Gardens_1649063547_2.png"},{"is_default":"0","image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Vishnudhara_Gardens_1649063547_3.png"}]
/// aminities : [{"name":"Home Theater","icon":"https://sma.coronation.in/api/assets/aminities/hometheater.png","background":"#D98880"},{"name":"Indoor Game Zone","icon":"https://sma.coronation.in/api/assets/aminities/hometheater.png","background":"#D98880"},{"name":"Garden","icon":"https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png","background":"#F2FF70"},{"name":"Gym With Steam Area","icon":"https://sma.coronation.in/api/assets/aminities/gym_with_steam_area.png","background":"#F2FF70"}]
/// user_details : {"user_id":"3","name":"Maharshi saparia","contact":9376976464,"email":"maharshi@coronation.in","notification":0,"is_active":1,"timestamp":"01/04/2022","is_id_verified":"1","is_superhero":"1","about_user":"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia","dob":"650446462","budget":"6000","stay_length":"12","is_ready_to_move":"1","property_preferances":[{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"funrnished room","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"bathroom","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"max no of","value":"2"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"internet","value":"required"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"parking","value":"on street"}],"preffered_location":[{"location":"shela"},{"location":"south bopal"},{"location":"bopal"}],"age":"31","preferances":[{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"5","preferance":"no pets"}],"profile_pic":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/164880315461172.jpeg","rating":3.5,"total_review_count":5}
/// user_property_preferance : [{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"5","preferance":"no pets"},{"preferance_id":"4","preferance":"students"}]

class Properties {
  Properties({
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
      List<UserPropertyPreferance>? userPropertyPreferance,}){
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
    _userPropertyPreferance = userPropertyPreferance;
}

  Properties.fromJson(dynamic json) {
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
    if (json['user_property_preferance'] != null) {
      _userPropertyPreferance = [];
      json['user_property_preferance'].forEach((v) {
        _userPropertyPreferance?.add(UserPropertyPreferance.fromJson(v));
      });
    }
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
  List<UserPropertyPreferance>? _userPropertyPreferance;
Properties copyWith({  String? propertyId,
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
  List<UserPropertyPreferance>? userPropertyPreferance,
}) => Properties(  propertyId: propertyId ?? _propertyId,
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
  userPropertyPreferance: userPropertyPreferance ?? _userPropertyPreferance,
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
  List<UserPropertyPreferance>? get userPropertyPreferance => _userPropertyPreferance;

  set setFavourite(int value) {
    _isFavourite = value;
  }

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
    if (_userPropertyPreferance != null) {
      map['user_property_preferance'] = _userPropertyPreferance?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// preferance_id : "1"
/// preferance : "working full time"

class UserPropertyPreferance {
  UserPropertyPreferance({
      String? preferanceId, 
      String? preferance,}){
    _preferanceId = preferanceId;
    _preferance = preferance;
}

  UserPropertyPreferance.fromJson(dynamic json) {
    _preferanceId = json['preferance_id'];
    _preferance = json['preferance'];
  }
  String? _preferanceId;
  String? _preferance;
UserPropertyPreferance copyWith({  String? preferanceId,
  String? preferance,
}) => UserPropertyPreferance(  preferanceId: preferanceId ?? _preferanceId,
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

/// user_id : "3"
/// name : "Maharshi saparia"
/// contact : 9376976464
/// email : "maharshi@coronation.in"
/// notification : 0
/// is_active : 1
/// timestamp : "01/04/2022"
/// is_id_verified : "1"
/// is_superhero : "1"
/// about_user : "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia"
/// dob : "650446462"
/// budget : "6000"
/// stay_length : "12"
/// is_ready_to_move : "1"
/// property_preferances : [{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"funrnished room","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"bathroom","value":"flexible"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"max no of","value":"2"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"internet","value":"required"},{"icon":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/circle.png","type":"parking","value":"on street"}]
/// preffered_location : [{"location":"shela"},{"location":"south bopal"},{"location":"bopal"}]
/// age : "31"
/// preferances : [{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"},{"preferance_id":"5","preferance":"no pets"}]
/// profile_pic : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/profile_pic/164880315461172.jpeg"
/// rating : 3.5
/// total_review_count : 5

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
      int? totalReviewCount,}){
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

/// location : "shela"

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
/// image : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/uploads/property/7/Orchid_Heaven_1648818161_0.JPG"

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