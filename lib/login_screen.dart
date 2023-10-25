import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/model/common_response.dart';
import 'package:share_my_appartment/network/api_end_points.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  TextEditingController textEditingController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = PageController(viewportFraction: 1, keepPage: true);
    final pages = List.generate(
        4,
        (index) => Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              elevation: 2,
              color: light_gray,
              child: FadeInImage.assetNetwork(
                image:
                    'https://upload.wikimedia.org/wikipedia/commons/d/d6/George_L._Burlingame_House%2C_1238_Harvard_St%2C_Houston_%28HDR%29.jpg',
                placeholder: 'assets/images/placeholder.png',
                fit: BoxFit.cover,
                height: size.height * 0.3,
              ),
            ));

    return Scaffold(
        backgroundColor: bg_color,
        body: _isLoading ? const LoadingWidget() : Padding(
            padding: const EdgeInsets.all(20),
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
                        onPressed: () {},
                      ),
                    )),
                Container(
                    alignment: Alignment.topLeft,
                    margin:
                    const EdgeInsets.only(top: 20,left:8, bottom: 20),
                    child: const Text("Hi,\nWelcome Back!",
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.normal,
                            fontSize: 28))),
                SizedBox(
                    height: size.height * 0.4,
                    width: size.width,
                    child: PageView.builder(
                      controller: controller,
                      // itemCount: pages.length,
                      itemBuilder: (_, index) {
                        return pages[index % pages.length];
                      },
                    )),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 30),
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: pages.length,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 7,
                      dotWidth: 7,
                      activeDotColor: active_ind,
                      dotColor: de_active_ind,
                      // strokeWidth: 5,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            decoration: const BoxDecoration(
                                color: light_pink,
                                borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                            child: Row(
                              children: [
                                const Text("+91",
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: const VerticalDivider(
                                    thickness: 1,
                                    color: dark_gray,
                                    indent: 18,
                                    endIndent: 18,
                                  ),
                                ),
                                Flexible(
                                  child: TextField(
                                      controller: textEditingController,
                                      keyboardType: TextInputType.number,
                                      cursorColor: black,
                                      maxLength: 10,
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: const InputDecoration(
                                          counterText: "",
                                          border: InputBorder.none,
                                          hintText: 'Phone Number',
                                          hintStyle: TextStyle(
                                            color: black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ))),
                                )
                              ],
                            ),
                          ),
                          flex: 1,
                        ),
                        GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (textEditingController.text.isEmpty) {
                              showSnackBar('Please enter mobile number.',context);
                            } else if (textEditingController.text.length !=
                                10) {
                              showSnackBar('Please enter valid mobile number.',context);
                            } else {
                              if(isOnline){
                                setState(() {
                                  _isLoading = true;
                                });
                                String mobileNumber = textEditingController.text.toString();
                                _makeSendOtpRequest(mobileNumber);
                              }
                              else{
                                showSnackBar('You are not connected to internet', context);
                              }
                            }
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: light_pink,
                                borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: black,
                              size: 24,
                            ),
                          ),
                        )
                      ],
                    )),
                Container(
                    alignment: Alignment.center,
                    child: const Text(
                        "We will send you OTP via SMS, please enter OTP to continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14))),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 40),
                    child: const Text(
                        "Register yourself & explore features like share or search\nappartment, rent rooms or student accommodation.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14)))
              ],
            )));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  _makeSendOtpRequest(mobileNumber) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + requestOTP);

    Map<String, String> jsonBody = {
      'apiId': API_KEY,
      'contact': mobileNumber
    };

    final response = await http.post(
      url,
      body: jsonBody
    );

    final statusCode = response.statusCode;

    final body = response.body;
    Map<String, dynamic> user = jsonDecode(body);
    var loginResponse = CommonResponse.fromJson(user);

    if (statusCode == 200 && loginResponse.success == 1)
    {
      setState(() {
        _isLoading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OTPScreen(mobileNumber)));
    }
    else
    {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(loginResponse.message, context);
    }
  }

  @override
  void castStatefulWidget() {
    widget is LoginScreen;
  }
}
