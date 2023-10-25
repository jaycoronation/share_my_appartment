const BASE_URL = "https://sma.coronation.in/api/services/";
const API_KEY = "Yjg1ZGExMTc4ZWQyNzRlZWExMDAxZTYzN2VjNTkyZDg=";

/*LOGIN*/
const requestOTP = "user/request_otp";
const verifyOTP = "user/verify_otp";

/*USER PROFILE*/
const getUserProfile = "user/profile";
const getOtherUserProfileInformation = "user/user_details_by_id";
const updateProfilePic = "user/update_profile_pic";
const updateProfileInformation = "user/update_profile";
const getAllCity = "list_city";
const getUserList = "user/list";
const setNotificationPreference = "user/allow_notification";

/*PROPERTY*/
const getPropertiesByCity = "properties/list";
const getPropertyDetails = "properties/details";
const markPropertyAsFavourite = "properties/mark_favourite";
const getPropertyTypes = "properties/type";
const saveProperty = "properties/save";
const getAmenitiesList = "aminities/list";
const getUserPreferences = "user_preferances_types/list";
const propertyInquiry = "properties/inquiry";
const deleteProperty = "properties/delete";
const inquiryList = "properties/inquiry_list";

/*NOTIFICATION*/
const updateDeviceToken = "user/update_token";
const notificationList = "user/notifications_list";
