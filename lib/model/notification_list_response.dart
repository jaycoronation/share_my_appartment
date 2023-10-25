/// notifications : [{"image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/thumb.jpg","is_read":"0","notification_id":"10","content_id":"2","contact_number":"","message":"Chhatbar mayur sent an inquiry for Express Astra","title":"New inquiry for Express Astra","timestamp":"27/05/2022 11:39:14","time":"24 Seconds ago"},{"image":"https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/thumb.jpg","is_read":"1","notification_id":"9","content_id":"2","contact_number":"","message":"chhatbar mayur sent an inquiry for property on rent in pose area","title":"New inquiry for property on rent in pose area","timestamp":"27/05/2022 11:11:26","time":"28 Minutes ago"}]
/// total_records : 2
/// message : ""
/// success : 1

class NotificationListResponse {
  NotificationListResponse({
      List<Notifications>? notifications, 
      int? totalRecords, 
      String? message, 
      int? success,}){
    _notifications = notifications;
    _totalRecords = totalRecords;
    _message = message;
    _success = success;
}

  NotificationListResponse.fromJson(dynamic json) {
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
    _totalRecords = json['total_records'];
    _message = json['message'];
    _success = json['success'];
  }
  List<Notifications>? _notifications;
  int? _totalRecords;
  String? _message;
  int? _success;
NotificationListResponse copyWith({  List<Notifications>? notifications,
  int? totalRecords,
  String? message,
  int? success,
}) => NotificationListResponse(  notifications: notifications ?? _notifications,
  totalRecords: totalRecords ?? _totalRecords,
  message: message ?? _message,
  success: success ?? _success,
);
  List<Notifications>? get notifications => _notifications;
  int? get totalRecords => _totalRecords;
  String? get message => _message;
  int? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    map['total_records'] = _totalRecords;
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// image : "https://sma.coronation.in/api/image-tool/index.php?src=https://sma.coronation.in/api/assets/thumb.jpg"
/// is_read : "0"
/// notification_id : "10"
/// content_id : "2"
/// contact_number : ""
/// message : "Chhatbar mayur sent an inquiry for Express Astra"
/// title : "New inquiry for Express Astra"
/// timestamp : "27/05/2022 11:39:14"
/// time : "24 Seconds ago"

class Notifications {
  Notifications({
      String? image, 
      String? isRead, 
      String? notificationId, 
      String? contentId, 
      String? contactNumber, 
      String? message, 
      String? title, 
      String? timestamp, 
      String? time,}){
    _image = image;
    _isRead = isRead;
    _notificationId = notificationId;
    _contentId = contentId;
    _contactNumber = contactNumber;
    _message = message;
    _title = title;
    _timestamp = timestamp;
    _time = time;
}

  Notifications.fromJson(dynamic json) {
    _image = json['image'];
    _isRead = json['is_read'];
    _notificationId = json['notification_id'];
    _contentId = json['content_id'];
    _contactNumber = json['contact_number'];
    _message = json['message'];
    _title = json['title'];
    _timestamp = json['timestamp'];
    _time = json['time'];
  }
  String? _image;
  String? _isRead;
  String? _notificationId;
  String? _contentId;
  String? _contactNumber;
  String? _message;
  String? _title;
  String? _timestamp;
  String? _time;
Notifications copyWith({  String? image,
  String? isRead,
  String? notificationId,
  String? contentId,
  String? contactNumber,
  String? message,
  String? title,
  String? timestamp,
  String? time,
}) => Notifications(  image: image ?? _image,
  isRead: isRead ?? _isRead,
  notificationId: notificationId ?? _notificationId,
  contentId: contentId ?? _contentId,
  contactNumber: contactNumber ?? _contactNumber,
  message: message ?? _message,
  title: title ?? _title,
  timestamp: timestamp ?? _timestamp,
  time: time ?? _time,
);
  String? get image => _image;
  String? get isRead => _isRead;
  String? get notificationId => _notificationId;
  String? get contentId => _contentId;
  String? get contactNumber => _contactNumber;
  String? get message => _message;
  String? get title => _title;
  String? get timestamp => _timestamp;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    map['is_read'] = _isRead;
    map['notification_id'] = _notificationId;
    map['content_id'] = _contentId;
    map['contact_number'] = _contactNumber;
    map['message'] = _message;
    map['title'] = _title;
    map['timestamp'] = _timestamp;
    map['time'] = _time;
    return map;
  }

}