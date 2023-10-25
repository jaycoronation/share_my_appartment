/// user : {"user_id":"2","name":"Chhatbar mayur","contact":8401358881,"email":"mayur@coronation.in","notification":1,"is_active":1,"timestamp":"25/01/2022","is_id_verified":"1","is_superhero":"1","about_user":"","profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg","rating":3.5,"total_review_count":1,"reviews":[{"review":"excellent","review_by":"3","review_by_name":"Maharshi saparia","review_by_profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/164319989020190328153826IMG9308.JPG"}],"token":"d98ee6182c6339c0974e08a6c18ecb40"}
/// message : "Welcome Chhatbar mayur"
/// success : 1

class LoginResponse {
  LoginResponse({
      User? user, 
      String? message, 
      int? success,}){
    _user = user;
    _message = message;
    _success = success;
}

  LoginResponse.fromJson(dynamic json) {
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
/// timestamp : "25/01/2022"
/// is_id_verified : "1"
/// is_superhero : "1"
/// about_user : ""
/// profile_pic : "http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/1643093559Mayur1.jpg"
/// rating : 3.5
/// total_review_count : 1
/// reviews : [{"review":"excellent","review_by":"3","review_by_name":"Maharshi saparia","review_by_profile_pic":"http://sma.coronation.in/api/image-tool/index.php?src=http://sma.coronation.in/api/assets/uploads/profile_pic/164319989020190328153826IMG9308.JPG"}]
/// token : "d98ee6182c6339c0974e08a6c18ecb40"

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
      String? profilePic, 
      double? rating, 
      int? totalReviewCount, 
      List<Reviews>? reviews, 
      String? token,}){
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
    _token = token;
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
    _profilePic = json['profile_pic'];
    _rating = json['rating'];
    _totalReviewCount = json['total_review_count'];
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
    _token = json['token'];
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
  String? _token;

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
  String? get token => _token;

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
    map['token'] = _token;
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