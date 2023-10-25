import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/login_screen.dart';
import 'package:share_my_appartment/model/common_response.dart';
import 'package:share_my_appartment/model/login_response.dart';
import 'package:share_my_appartment/my_inquiry.dart';
import 'package:share_my_appartment/my_listing.dart';
import 'package:share_my_appartment/network/api_end_points.dart';
import 'package:share_my_appartment/update_profile.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/utils/session_manager_new.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends BaseState<MyAccount> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  dynamic fileNew ;
  dynamic fileBytes;
  SessionManager sessionManager = SessionManager();
  bool status = false;

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  void _filePath(LoginResponse loginResponse)
  {
      setState(() {
        sessionManager.setProfilePic(loginResponse.user!.profilePic!);
      });
  }

  @override
  Widget build(BuildContext context)  {
    status = sessionManager.getNotificationStatus() == 1 ? true : false;
    return Scaffold(
        backgroundColor: bg_color,
        body: SafeArea(child: Column(
          children: [
            AnimatedContainer(
                height: _showAppbar ? 64.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: AppBar(
                  toolbarHeight: 60,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('Account',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  centerTitle: false,
                  elevation: 0,
                  backgroundColor: const Color(0XffEDEDEE),
                )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                controller: _scrollViewController,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: circleRadius / 2.0),
                          child: Container(
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(22.0)),
                              color: Color(0xffF7F8F8),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(top: 90,left: 20,right: 20,bottom: 20),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 15),
                                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF7F8F8),
                                            border:
                                            Border.all(color: light_gray),
                                            borderRadius: const BorderRadius.all(Radius.circular(22))),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(toDisplayCase(sessionManager.getName().toString()), textAlign: TextAlign.center, style: const TextStyle(color: text_color, fontWeight: FontWeight.w600, fontSize: 16)),
                                              Container(
                                                height: 2,
                                              ),
                                              Text(sessionManager.getEmail().toString(), textAlign: TextAlign.center, style: const TextStyle(color: text_color, fontWeight: FontWeight.w600, fontSize: 16)),
                                              Container(
                                                height: 2,
                                              ),
                                              Text("+91 ${sessionManager.getContact().toString()}", textAlign: TextAlign.center, style: const TextStyle(color: text_color, fontWeight: FontWeight.w600, fontSize: 16))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: 36,
                                          height: 36,
                                          margin: const EdgeInsets.only(top: 10,right: 15),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: const Color(0xffF7F8F8),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.edit_outlined,
                                                color: text_color,
                                                size: 22,
                                              ),
                                              onPressed: () async {
                                                await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const UpdateProfile()),
                                                );
                                                setState(() {
                                                });
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                                  Container(height: 12),
                                  Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    elevation: 5,
                                child: Padding(padding: const EdgeInsets.all(14),child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const MyListing()),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset('assets/images/listing.png',fit: BoxFit.contain,width: 20,height: 20),
                                            Container(
                                              width: 15,
                                            ),
                                            const Text("My Properties",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(height: 1, color: const Color(0xff9D9D9C),margin: const EdgeInsets.only(top: 20)),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20,left: 5),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const MyInquiryListingPage()),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset('assets/images/inquiry.png',fit: BoxFit.contain,width: 20,height: 20),
                                            Container(
                                              width: 15,
                                            ),
                                            const Text("My Inquiry",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(height: 1, color: const Color(0xff9D9D9C),margin: const EdgeInsets.only(top: 20)),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20,left: 5),
                                      child: Row(
                                        children: [
                                          Image.asset('assets/images/notification.png',fit: BoxFit.contain,width: 20,height: 20),
                                          Container(
                                            width: 15,
                                          ),
                                          const Text("Notification",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16)),
                                          const Spacer(),
                                          FlutterSwitch(
                                            width: 40.0,
                                            height: 20.0,
                                            valueFontSize: 12.0,
                                            toggleSize: 20.0,
                                            value: status,
                                            borderRadius: 30.0,
                                            padding: 0.0,
                                            activeColor: const Color(0xffD1D9E0),
                                            inactiveToggleColor: const Color(0xffD1D9E0),
                                            activeToggleColor: const Color(0xff5F6977),
                                            onToggle: (val) {
                                              _setNotificationPreference(val);
                                            },
                                          ),
                                          Container(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ))),
                                  Container(height: 12),
                                  Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14.0),
                                      ),
                                      elevation: 5,
                                      child: Padding(padding: const EdgeInsets.all(14),child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(left: 5),
                                            child: Row(
                                              children: [
                                                Image.asset('assets/images/help.png',fit: BoxFit.contain,width: 20,height: 20),
                                                Container(
                                                  width: 15,
                                                ),
                                                const Text("Help & Support",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: black,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16))
                                              ],
                                            ),
                                          ),
                                          Container(height: 1, color: const Color(0xff9D9D9C),margin: const EdgeInsets.only(top: 20)),
                                          InkWell(
                                            onTap: (){
                                              FocusScope.of(context).requestFocus(FocusNode());
                                              showModalBottomSheet<void>(
                                                context: context,
                                                backgroundColor: white,
                                                isScrollControlled: true,
                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                                elevation: 5,
                                                isDismissible: true,
                                                builder: (BuildContext context) {
                                                  // we set up a container inside which
                                                  // we create center column and display text
                                                  return Wrap(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                          ),
                                                          const Text("Logout", style: TextStyle(color: dark_orange, fontWeight: FontWeight.w500, fontSize: 28)),
                                                          Container(
                                                            height: 20,
                                                          ),
                                                          const Text("Are you sure want to logout from app?",
                                                              style: TextStyle(color: black, fontWeight: FontWeight.normal, fontSize: 20), textAlign: TextAlign.center),
                                                          Container(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Container(
                                                                  height: 50.0,
                                                                  width: 120.0,
                                                                  alignment: Alignment.center,
                                                                  margin: const EdgeInsets.only(right: 10),
                                                                  decoration: BoxDecoration(
                                                                      color: light_orange,
                                                                      border: Border.all(
                                                                        color: dark_orange,
                                                                      ),
                                                                      borderRadius: const BorderRadius.all(Radius.circular(30))),
                                                                  child: const Text("Cancel",
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(color: dark_orange, fontWeight: FontWeight.normal, fontSize: 18)),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                  onTap: () async {
                                                                    Navigator.pop(context);
                                                                    SessionManagerNew.clear();
                                                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                                                    const LoginScreen()), (Route<dynamic> route) => false);
                                                                  },
                                                                  child : Container(
                                                                    height: 50.0,
                                                                    width: 120.0,
                                                                    margin: const EdgeInsets.only(left: 10),
                                                                    alignment: Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                        color: light_orange,
                                                                        border: Border.all(
                                                                          color: dark_orange,
                                                                        ),
                                                                        borderRadius: const BorderRadius.all(Radius.circular(30))),
                                                                    child: const Text("Logout",
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(color: dark_orange, fontWeight: FontWeight.normal, fontSize: 18)),
                                                                  ))
                                                            ],
                                                          ),
                                                          Container(
                                                            height: 30,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(top: 17,left: 5),
                                              child: Row(
                                                children: [
                                                  Image.asset('assets/images/logout.png',fit: BoxFit.contain,width: 20,height: 20),
                                                  Container(
                                                    width: 15,
                                                  ),
                                                  const Text("Log Out",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: black,
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16))
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ))),
                                ],
                              ),
                            ),
                          )),
                      InkWell(
                        onTap: ()  {
                          pickFile();
                        },
                        child: Container(
                          width: circleRadius,
                          height: circleRadius,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.white,
                          ),
                          child: Card(
                            margin: EdgeInsets.zero,
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            elevation: 5,
                            color: light_gray,
                            child:  sessionManager.getProfilePic()!.isNotEmpty && isOnline ? FadeInImage.assetNetwork(
                                image: sessionManager.getProfilePic()!+'&w=500',
                                fit: BoxFit.cover,
                                placeholder: 'assets/images/placeholder.png') : FadeInImage.assetNetwork(
                              image: 'https://i.ytimg.com/vi/3Itgbz_uNXg/sddefault_live.jpg',
                              fit: BoxFit.cover,
                              placeholder: 'assets/images/placeholder.png',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ))
          ],
        )));
  }

  void pickFile() async
  {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    if(kIsWeb){
      fileBytes = result.files.first.bytes;
    }
    else{
      fileNew = File(result.files.single.path!);
    }
    /*print('File Name: ${result.files.single.name}');
    print('File Size: ${result.files.single.size}');
    print('File Extension: ${result.files.single.extension}');
    print('File Path: $fileNew');*/
    _makeUpdateProfilePicRequest(fileNew);
  }

  convertFileToCast(data){
    List<int> list = data.cast();
    return list;
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
  }

  _makeUpdateProfilePicRequest(image) async {
    final url = Uri.parse(BASE_URL + updateProfilePic);
    var request = MultipartRequest("POST", url);
    request.fields['apiId'] = API_KEY;
    request.fields['user_id'] = sessionManager.getUserId() ?? "0";
    request.fields['token'] = sessionManager.getToken() ?? "";


    if(kIsWeb){
       var multipartFile = MultipartFile.fromBytes("profile_pic", await convertFileToCast(fileBytes));
       request.files.add(multipartFile);
    }
    else{
      var multipartFile = await MultipartFile.fromPath("profile_pic", image.path);
      request.files.add(multipartFile);
    }
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Map<String, dynamic> user = jsonDecode(responseString);
    var loginResponse = LoginResponse.fromJson(user);
    print(loginResponse.toJson());
    if (loginResponse.success == 1) {
      showSnackBar(loginResponse.message, context);
      _filePath(loginResponse);
    }

  }

  _setNotificationPreference(bool val) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + setNotificationPreference);

    Map<String, String> jsonBody = {
      'apiId': API_KEY,
      'user_id': sessionManager.getUserId() ?? "0",
      'token': sessionManager.getToken() ?? ""
    };

    final response = await http.post(
        url,
        body: jsonBody
    );

    final statusCode = response.statusCode;

    if (statusCode == 200) {
      // this API passes back the id of the new item added to the body
      final body = response.body;

      Map<String, dynamic> city = jsonDecode(body);
      var commonResponse = CommonResponse.fromJson(city);
      if (commonResponse.success == 1) {
        showSnackBar(commonResponse.message, context);
        setState(() {
          sessionManager.setNotificationStatus(sessionManager.getNotificationStatus() == 1 ? 0 : 1);
          status = sessionManager.getNotificationStatus() == 1 ? true : false;
        });
      }
    }
  }

  @override
  void castStatefulWidget() {
    widget is MyAccount;
  }
}
