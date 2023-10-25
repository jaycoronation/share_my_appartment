import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';

import 'model/login_response.dart';
import 'network/api_end_points.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends BaseState<UpdateProfile> {
  SessionManager sessionManager = SessionManager();
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  bool status = true;
  String dropdownValue = '12 Month+';
  TextEditingController profileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool _isLoading = false;

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
              Container(
                margin: const EdgeInsets.only(top: 30),
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
                      SystemChannels.textInput
                          .invokeMethod('TextInput.hide');
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 32),
                decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child:  const Text("INTRODUCE YOUR SELF",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child:  const Text("Profile Information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Container(
                      height: 20,
                    ),
                    const Text('Display Name',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 12,right: 12),
                          decoration: BoxDecoration(
                              color: white,
                              border:
                              Border.all(color: dark_text),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(28))),
                          child: Center(
                            child: TextField(
                                controller: profileController,
                                keyboardType: TextInputType.name,
                                cursorColor: black,
                                style: const TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Profile Name',
                                    hintStyle: TextStyle(
                                      color: dark_text,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ))),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 26,
                    ),
                    const Text('Email Address',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 12,right: 12),
                          decoration: BoxDecoration(
                              color: white,
                              border:
                              Border.all(color: dark_text),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(28))),
                          child: Center(
                            child: TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: black,
                                style: const TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      color: dark_text,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ))),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 26,
                    ),
                    const Text('Mobile Number',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 12,right: 12),
                          decoration: BoxDecoration(
                              color: white,
                              border:
                              Border.all(color: dark_text),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(28))),
                          child: Center(
                            child: TextField(
                                controller: mobileController,
                                keyboardType: TextInputType.number,
                                cursorColor: black,
                                readOnly: true,
                                style: const TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Mobile Number',
                                    hintStyle: TextStyle(
                                      color: dark_text,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
              ),
              InkWell(
                onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                  String name = profileController.text.toString();
                  String email = emailController.text.toString();
                  String mobileNumber = mobileController.text.toString();
                  if(name.trim().isEmpty)
                  {
                    showSnackBar('Please enter name.', context);
                  }
                  else if(email.trim().isEmpty)
                  {
                    showSnackBar('Please enter email.', context);
                  }
                  else if(!isValidEmail(email))
                  {
                    showSnackBar('Please enter valid email.', context);
                  }
                  else if(mobileNumber.trim().isNotEmpty && mobileNumber.trim().length < 10)
                  {
                    showSnackBar('Please enter valid mobile number.', context);
                  }
                  else
                  {
                    setState(() {
                      _isLoading = true;
                    });
                    if(isOnline){
                      _makeUpdateProfileInfoRequest(name, email);
                    }
                    else{
                      showSnackBar('You are not connected to internet', context);
                    }
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        color: const Color(0XFFFEF3E3),
                        border:
                        Border.all(color: Colors.orange),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(24))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        const Text('Update Profile',
                            style: TextStyle(
                                color: dark_orange,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                        Container(
                          width: 6,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.orange,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    profileController.text = sessionManager.getName() ?? "";
    emailController.text = sessionManager.getEmail() ?? "";
    mobileController.text = sessionManager.getContact() ?? "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  _makeUpdateProfileInfoRequest(name,email) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + updateProfileInformation);

    Map<String, String> jsonBody = {
      'apiId': API_KEY,
      'user_id': sessionManager.getUserId() ?? "0",
      'name': name,
      'email': email,
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

      Map<String, dynamic> user = jsonDecode(body);
      var loginResponse = LoginResponse.fromJson(user);
      if (loginResponse.success == 1) {
        setState(() {
          sessionManager.setName(loginResponse.user!.name!);
          sessionManager.setEmail(loginResponse.user!.email!);
        });

        Navigator.pop(context);
      }
    }
  }

  @override
  void castStatefulWidget() {
    widget is UpdateProfile;
  }
}
