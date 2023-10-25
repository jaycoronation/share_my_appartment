/// property : {"property_id":"6","title":"Express Astra","price":"45.5 Lac","location_latitude":"23.009530","location_longitude":"72.510960","location":"Bopal","beds":"4","bathrooms":"5","balcony":"3","looking_for":"Family","status":"1","rateings":"5","about_property":"Only four flats on each floor in every tower\r\nRain water harvesting\r\nLand allotted by Greater NOIDA Authority\r\nExclusive tower of 3 BHK - 2 Flats on each floor\r\n75% Open area\r\nVehicular movement free landscape podium\r\nCorner plot","state_id":"12","property_type_id":"8","max_flatmates":"5","internet":"1","parking":"1","property_type":"villas","is_favourite":0,"state_name":"Gujarat","city_id":"783","city_name":"Ahmedabad","images":[{"is_default":"1","image":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/property/6/6.jpg"}],"aminities":[{"name":"Home Theater","icon":"http://sma.coronation.in/api/assets/aminities/hometheater.svg","background":"#D98880"},{"name":"Gym With Steam Area","icon":"http://sma.coronation.in/api/assets/aminities/gym_with_steam_area.svg","background":"#F2FF70"},{"name":"Gazebo","icon":"http://sma.coronation.in/api/assets/aminities/gazebo.svg","background":"#70FF7D"},{"name":"Indoor Game Zone","icon":"http://sma.coronation.in/api/assets/aminities/hometheater.svg","background":"#D98880"}],"user_details":{"user_id":"2","name":"Chhatbar mayur","contact":8401358881,"email":"mayur@coronation.in","notification":1,"is_active":1,"timestamp":"25/01/2022","is_id_verified":"1","is_superhero":"1","about_user":"","profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg","rating":3.5,"total_review_count":1,"reviews":[{"review":"excellent","review_by":"3","review_by_name":"Maharshi saparia","review_by_profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643116307IMG0001.jpeg"}]},"user_property_preferance":[{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"}]}
/// message : ""
/// success : 1

class PropertyDetailResponse {
  PropertyDetailResponse({
      Property? property, 
      String? message, 
      int? success,}){
    _property = property;
    _message = message;
    _success = success;
}

  PropertyDetailResponse.fromJson(dynamic json) {
    _property = json['property'] != null ? Property.fromJson(json['property']) : null;
    _message = json['message'];
    _success = json['success'];
  }
  Property? _property;
  String? _message;
  int? _success;

  Property? get property => _property;
  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_property != null) {
      map['property'] = _property?.toJson();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// property_id : "6"
/// title : "Express Astra"
/// price : "45.5 Lac"
/// location_latitude : "23.009530"
/// location_longitude : "72.510960"
/// location : "Bopal"
/// beds : "4"
/// bathrooms : "5"
/// balcony : "3"
/// looking_for : "Family"
/// status : "1"
/// rateings : "5"
/// about_property : "Only four flats on each floor in every tower\r\nRain water harvesting\r\nLand allotted by Greater NOIDA Authority\r\nExclusive tower of 3 BHK - 2 Flats on each floor\r\n75% Open area\r\nVehicular movement free landscape podium\r\nCorner plot"
/// state_id : "12"
/// property_type_id : "8"
/// max_flatmates : "5"
/// internet : "1"
/// parking : "1"
/// property_type : "villas"
/// is_favourite : 0
/// state_name : "Gujarat"
/// city_id : "783"
/// city_name : "Ahmedabad"
/// images : [{"is_default":"1","image":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/property/6/6.jpg"}]
/// aminities : [{"name":"Home Theater","icon":"http://sma.coronation.in/api/assets/aminities/hometheater.svg","background":"#D98880"},{"name":"Gym With Steam Area","icon":"http://sma.coronation.in/api/assets/aminities/gym_with_steam_area.svg","background":"#F2FF70"},{"name":"Gazebo","icon":"http://sma.coronation.in/api/assets/aminities/gazebo.svg","background":"#70FF7D"},{"name":"Indoor Game Zone","icon":"http://sma.coronation.in/api/assets/aminities/hometheater.svg","background":"#D98880"}]
/// user_details : {"user_id":"2","name":"Chhatbar mayur","contact":8401358881,"email":"mayur@coronation.in","notification":1,"is_active":1,"timestamp":"25/01/2022","is_id_verified":"1","is_superhero":"1","about_user":"","profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg","rating":3.5,"total_review_count":1,"reviews":[{"review":"excellent","review_by":"3","review_by_name":"Maharshi saparia","review_by_profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643116307IMG0001.jpeg"}]}
/// user_property_preferance : [{"preferance_id":"1","preferance":"working full time"},{"preferance_id":"2","preferance":"non-smoker"},{"preferance_id":"3","preferance":"no childrens"}]

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
      String? propertyType, 
      int? isFavourite, 
      String? stateName, 
      String? cityId, 
      String? cityName, 
      List<Images>? images, 
      List<Aminities>? aminities, 
      User_details? userDetails, 
      List<User_property_preferance>? userPropertyPreferance,}){
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
    _userDetails = json['user_details'] != null ? User_details.fromJson(json['user_details']) : null;
    if (json['user_property_preferance'] != null) {
      _userPropertyPreferance = [];
      json['user_property_preferance'].forEach((v) {
        _userPropertyPreferance?.add(User_property_preferance.fromJson(v));
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
  String? _stateId;
  String? _propertyTypeId;
  String? _maxFlatmates;
  String? _internet;
  String? _parking;
  String? _propertyType;
  int? _isFavourite;
  String? _stateName;
  String? _cityId;
  String? _cityName;
  List<Images>? _images;
  List<Aminities>? _aminities;
  User_details? _userDetails;
  List<User_property_preferance>? _userPropertyPreferance;

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
  String? get propertyType => _propertyType;
  int? get isFavourite => _isFavourite;
  String? get stateName => _stateName;
  String? get cityId => _cityId;
  String? get cityName => _cityName;
  List<Images>? get images => _images;
  List<Aminities>? get aminities => _aminities;
  User_details? get userDetails => _userDetails;
  List<User_property_preferance>? get userPropertyPreferance => _userPropertyPreferance;


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
    map['state_id'] = _stateId;
    map['property_type_id'] = _propertyTypeId;
    map['max_flatmates'] = _maxFlatmates;
    map['internet'] = _internet;
    map['parking'] = _parking;
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

class User_property_preferance {
  User_property_preferance({
      String? preferanceId, 
      String? preferance,}){
    _preferanceId = preferanceId;
    _preferance = preferance;
}

  User_property_preferance.fromJson(dynamic json) {
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

/// user_id : "2"
/// name : "Chhatbar mayur"
/// contact : 8401358881
/// email : "mayur@coronation.in"
/// notification : 1
/// is_active : 1
/// timestamp : "25/01/2022"
/// is_id_verified : "1"
/// is_superhero : "1"
/// about_user : ""
/// profile_pic : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg"
/// rating : 3.5
/// total_review_count : 1
/// reviews : [{"review":"excellent","review_by":"3","review_by_name":"Maharshi saparia","review_by_profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643116307IMG0001.jpeg"}]

class User_details {
  User_details({
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
    _profilePic = profilePic;
    _rating = rating;
    _totalReviewCount = totalReviewCount;
    _reviews = reviews;
}

  User_details.fromJson(dynamic json) {
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
/// review_by_profile_pic : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643116307IMG0001.jpeg"

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

/// name : "Home Theater"
/// icon : "http://sma.coronation.in/api/assets/aminities/hometheater.svg"
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
/// image : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/property/6/6.jpg"

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

  String? get isDefault => _isDefault;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_default'] = _isDefault;
    map['image'] = _image;
    return map;
  }

}