import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/model/login_response.dart';
import 'package:share_my_appartment/tabcontrol/tabnavigation.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';

import 'model/common_response.dart';
import 'network/api_end_points.dart';

class OTPScreen extends StatefulWidget {
  final String mobileNumber;
  const OTPScreen(this.mobileNumber,{Key? key}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends BaseState<OTPScreen> {
  //for resent button
  SessionManager sessionManager = SessionManager();
  String? fcmToken ;
  bool visibilityResend = false;

  bool hasError = false;
  String currentText = "",mob = "";
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isOTPComplete = false ;

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            visibilityResend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bg_color,
        body: _isLoading ? const LoadingWidget() : Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: ListView(
                    children: <Widget>[
                      Container(
                          width: 52,
                          height: 52,
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: light_gray,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: black,
                                size: 24,
                              ),
                              onPressed: () {
                                SystemChannels.textInput.invokeMethod('TextInput.hide');
                                Navigator.pop(context);
                              },
                            ),
                          )),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 30, left: 8),
                          child: const Text("Verify with OTP", style: TextStyle(color: dark_gray, fontWeight: FontWeight.bold, fontSize: 28))),
                      Row(
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5, left: 8),
                              child: const Text("sent to",
                                  textAlign: TextAlign.center, style: TextStyle(color: dark_gray, fontWeight: FontWeight.normal, fontSize: 18))),
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 5, left: 8),
                              child: Text((widget as OTPScreen).mobileNumber,
                                  textAlign: TextAlign.center, style: const TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 22)))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                color: light_pink,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 4,
                              obscureText: false,
                              obscuringCharacter: '*',
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(22.0),
                                borderWidth: 0,
                                fieldHeight: 60,
                                fieldWidth: 60,
                                activeColor: light_pink,
                                selectedColor: light_pink,
                                disabledColor: light_pink,
                                inactiveColor: light_pink,
                                activeFillColor: light_pink,
                                selectedFillColor: light_pink,
                                inactiveFillColor: light_pink,
                              ),
                              cursorColor: Colors.black,
                              animationDuration: const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              keyboardType: TextInputType.number,
                              onCompleted: (v) {
                                isOTPComplete = true;
                              },
                              // onTap: () {
                              //   print("Pressed");
                              // },
                              onChanged: (value) {
                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top:28),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
                            padding: const EdgeInsets.only(left: 28,top: 16,right: 28,bottom: 16),
                            primary: black,
                            backgroundColor: light_pink,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            if(isOTPComplete)
                            {
                              if(isOnline){
                                setState(() {
                                  _isLoading = true;
                                });
                                FocusScope.of(context).requestFocus(FocusNode());
                                _makeVerifyOtpRequest(currentText, (widget as OTPScreen).mobileNumber);
                              }
                              else{
                                showSnackBar('You are not connected to internet', context);
                              }
                            }
                            else
                            {
                              showSnackBar('Please enter OTP.', context);
                            }
                          },
                          child: const Text('VERIFY OTP',style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                  flex: 1),
              Column(
                children: [
                  !visibilityResend
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 6),
                          child: const Text("Resend OTP in ",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: dark_gray, fontWeight: FontWeight.normal, fontSize: 18))),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 6, left: 4),
                          child: Text("00:$_start",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: dark_orange, fontWeight: FontWeight.bold, fontSize: 18))),
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(bottom: 6, left: 4),
                          child: const Text("Seconds",
                              textAlign: TextAlign.center, style: TextStyle(color: dark_gray, fontWeight: FontWeight.normal, fontSize: 18)))
                    ],
                  )
                      : Container(),
                  visibilityResend
                      ? Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 6),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              _start = 60;
                              visibilityResend = false;
                              startTimer();
                            });
                          },
                          child: const Text("Resend OTP",
                              textAlign: TextAlign.center, style: TextStyle(color: dark_orange, fontWeight: FontWeight.bold, fontSize: 18,decoration: TextDecoration.underline)),
                        ),
                  )
                      : Container(),

                ],
              )
            ],
          ),
        ));
  }

  _makeVerifyOtpRequest(otp,mobileNumber) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + verifyOTP);

    Map<String, String> jsonBody = {
      'apiId': API_KEY,
      'otp': otp,
      'contact': mobileNumber
    };

    final response = await http.post(
        url,
        body: jsonBody
    );

    final statusCode = response.statusCode;
    final body = response.body;

    Map<String, dynamic> user = jsonDecode(body);
    var loginResponse = LoginResponse.fromJson(user);

    if (statusCode == 200 && loginResponse.success == 1) {
      // this API passes back the id of the new item added to the body
      await sessionManager.createLoginSession(loginResponse.user!.userId.toString(),
          loginResponse.user!.name!.trim().toString(),loginResponse.user!.email.toString(), loginResponse.user!.contact.toString(),
          loginResponse.user!.profilePic.toString(), loginResponse.user!.token.toString(),
          loginResponse.user!.notification!.toInt());
    }
    else{
      showSnackBar(loginResponse.message, context);
    }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const TabNavigation()), (Route<dynamic> route) => false);
    /*fcmToken = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print("***************"+fcmToken.toString());
    }
    _updateDeviceToken();*/

  }

  _updateDeviceToken() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + updateDeviceToken);

      Map<String, String> jsonBody = {
        'apiId': API_KEY,
        'user_id': sessionManager.getUserId() ?? "0",
        'device_type': Platform.isIOS ? "iOS" : "Android",
        'token': sessionManager.getToken() ?? "",
        'notification_token' : fcmToken.toString()
      };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        // this API passes back the id of the new item added to the body
        final body = response.body;

        Map<String, dynamic> city = jsonDecode(body);
        var commonResponse = CommonResponse.fromJson(city);

        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        const TabNavigation()), (Route<dynamic> route) => false);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void castStatefulWidget() {
    widget is OTPScreen;
  }
}
