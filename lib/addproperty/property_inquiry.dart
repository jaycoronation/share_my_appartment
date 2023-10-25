import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/model/common_response.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/widget/loading.dart';

import '../network/api_end_points.dart';
import '../utils/session_manager.dart';

class PropertyInquiry extends StatefulWidget {
  final String propertyTitle;
  final String propertyId;
  const PropertyInquiry(this.propertyTitle,this.propertyId,{Key? key}) : super(key: key);

  @override
  _PropertyInquiryState createState() => _PropertyInquiryState();
}

class _PropertyInquiryState extends State<PropertyInquiry> {
  SessionManager sessionManager = SessionManager();
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  String name = "", email = "", mobileNumber = "", message = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bg_color,
        body: _isLoading ? const LoadingWidget() : Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                        child:  const Text("PROPERTY INQUIRY FOR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.normal,
                                fontSize: 12)),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(toDisplayCase(widget.propertyTitle),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                      Container(
                        height: 20,
                      ),
                      const Text('Name',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                  keyboardType: TextInputType.text,
                                  cursorColor: black,
                                  controller: nameController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Name',
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
                      const Text('Email',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: black,
                                  controller: emailController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: const InputDecoration(
                                      counterText: "",
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
                                  keyboardType: TextInputType.number,
                                  cursorColor: black,
                                  controller: mobileController,
                                  maxLength: 10,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: const InputDecoration(
                                      counterText: "",
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
                      Container(
                        height: 26,
                      ),
                      const Text('Message',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
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
                                  keyboardType: TextInputType.multiline,
                                  cursorColor: black,
                                  controller: messageController,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Message',
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
                Align(alignment: Alignment.bottomCenter,
                  child:  Container(
                    height: 50.0,
                    width: 120.0,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 40,bottom: 20),
                    decoration: BoxDecoration(
                        color: light_orange,
                        border: Border.all(
                          color: dark_orange,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(30))
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _isLoading = true;
                        });

                        name = nameController.text.toString();
                        email = emailController.text.toString();
                        mobileNumber = mobileController.text.toString();
                        message = messageController.text.toString();

                        _makePropertyInquiryRequest();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Text("Submit",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: dark_orange,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18)),
                          Container(
                            width: 6,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: dark_orange,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    nameController.text = sessionManager.getName() ?? "";
    emailController.text = sessionManager.getEmail() ?? "";
    mobileController.text = sessionManager.getContact() ?? "";
  }

  _makePropertyInquiryRequest() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + propertyInquiry);

    Map<String, String> jsonBody = {
      'apiId': API_KEY,
      'user_id': sessionManager.getUserId() ?? "0",
      'name': name,
      'email': email,
      'contact': mobileNumber,
      'message': message,
      'property_id': widget.propertyId,
      'token': sessionManager.getToken() ?? ""
    };

    final response = await http.post(
        url,
        body: jsonBody
    );

    final statusCode = response.statusCode;

    setState(() {
      _isLoading = false;
    });

    if (statusCode == 200) {
      // this API passes back the id of the new item added to the body
      final body = response.body;

      Map<String, dynamic> user = jsonDecode(body);
      var commonResponse = CommonResponse.fromJson(user);
      if (commonResponse.success == 1) {
        Navigator.pop(context);
      }
      else{
        showSnackBar(commonResponse.message, context);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
