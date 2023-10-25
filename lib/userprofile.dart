
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/model/user_profile_response.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/full_screen_image.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:share_my_appartment/widget/no_data.dart';
import 'package:share_my_appartment/widget/no_internet.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'network/api_end_points.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;
  const UserProfilePage(this.userId,{Key? key}) : super(key: key);

  @override
  BaseState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends BaseState<UserProfilePage> {
  SessionManager sessionManager = SessionManager();
  bool _isLoading = false;
  var userProfileResponse = UserProfileResponse();

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
    if(isOnline && userProfileResponse.user == null){
      _getUserProfileInformation((widget as UserProfilePage).userId);
    }

    return WillPopScope(child: Scaffold(
      backgroundColor: const Color(0XffEDEDEE),
      body: isOnline ? _isLoading ? const LoadingWidget() : userProfileResponse.success == 0 ? const MyNoDataWidget(msg: 'No user information found.') : SafeArea(child: Column(
        children: [
          AnimatedContainer(
              height: _showAppbar ? 64.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: AppBar(
                toolbarHeight: 64,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.only(top: 15,bottom: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 52,
                          height: 52,
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0XffD7D7D7),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 24,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )),
                      const Spacer(flex: 1),
                      Container(
                          width: 52,
                          height: 52,
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0XffD7D7D7),
                            child: IconButton(
                              icon: const Icon(
                                Icons.share_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                              onPressed: () async {

                                final uri = Uri.parse(userProfileResponse.user!.profilePic.toString()+"&w=720");
                                final response = await http.get(uri);
                                final bytes = response.bodyBytes;
                                final temp = await getTemporaryDirectory();
                                final path = '${temp.path}/image.jpg';
                                File(path).writeAsBytesSync(bytes);

                                shareFileWithText("Share Profile\n",
                                    toDisplayCase(userProfileResponse.user!.name.toString()) + "\n\n" + userProfileResponse.user!.aboutUser.toString(),
                                    path);
                              },
                            ),
                          )),
                      Container(
                        width: 8,
                      ),
                      Container(
                          width: 52,
                          height: 52,
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0XffD7D7D7),
                            child: IconButton(
                              icon: const Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                              onPressed: () {
                                showSnackBar("Development under process.", context);
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                centerTitle: false,
                elevation: 0,
                backgroundColor: const Color(0XffEDEDEE),
              )),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            controller: _scrollViewController,
            child: Column(
              children: [
                Container(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return FullScreenImage(userProfileResponse.user!.profilePic!+"&w=720",const <String>[],0);
                          }));
                        },
                        child: SizedBox(
                          height: 250,
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 0,
                            child: userProfileResponse.user!.profilePic!.isNotEmpty ? FadeInImage.assetNetwork(
                              image: userProfileResponse.user!.profilePic!+"&w=720",
                              fit: BoxFit.cover,
                              placeholder:
                              'assets/images/placeholder.png',
                            ) :
                            Image.asset('assets/images/placeholder.png',fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12, top: 20, right: 12,bottom: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: const ShapeDecoration(
                                      color: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(style: BorderStyle.none),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                      ),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 10,top: 2,right: 10,bottom: 2),
                                        child: Text(userProfileResponse.user!.isReadyToMove! == '1' ? 'Ready to Move' : 'Not Available',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500))),
                                  ),
                                ),
                                const Spacer(flex: 1),
                                userProfileResponse.user!.age!.isNotEmpty ? Text(userProfileResponse.user!.age! + ' year old male',style: const TextStyle(color: dark_text,fontWeight: FontWeight.w500,fontSize: 15),) : Container()
                              ],
                            ),
                            Container(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  toDisplayCase(userProfileResponse.user!.name!),
                                  style: const TextStyle(
                                      color: black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width: 8,
                                ),
                                const Icon(Icons.star,color: Colors.orange,)
                              ],
                            ),
                            Container(
                              height: 8,
                            ),
                            Row(
                              children: [
                                userProfileResponse.user!.budget!.isNotEmpty ? Row(
                                  children: [
                                    const Text(
                                      'Budget: ',
                                      style: TextStyle(
                                          color: dark_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      userProfileResponse.user!.budget!,
                                      style: const TextStyle(
                                          color: Colors.orange,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "/Month",
                                      style:
                                      TextStyle(color: dark_text, fontSize: 14,fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ) : Container(),
                                Container(
                                  width: 12,
                                ),
                                userProfileResponse.user!.stayLength!.isNotEmpty ? Row(
                                  children: [
                                    const Text(
                                      'Stay Length: ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: dark_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      userProfileResponse.user!.stayLength! + ' Months',
                                      style: const TextStyle(
                                          color: Colors.orange,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ) : Container()
                              ],
                            ),
                            Container(
                              height: 8,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 12,top: 8,right: 12,bottom: 8),
                                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0XFFFEF3E3),
                                          border:
                                          Border.all(color: Colors.orange),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: Row(
                                          children: const [
                                            Text('Send Message',
                                                style: TextStyle(
                                                    color: Colors.orange,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 16,
                ),
                userProfileResponse.user!.aboutUser!.isEmpty && userProfileResponse.user!.preferances!.isEmpty ? Container() :Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      )),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About ${toDisplayCase(userProfileResponse.user!.name!)}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 16  ,
                        ),
                        userProfileResponse.user!.aboutUser!.isNotEmpty ? Center(child: Text(userProfileResponse.user!.aboutUser!,
                          style: const TextStyle(color: black,fontSize: 13,fontWeight: FontWeight.w600),
                          softWrap: true,)) : Container(),
                        Container(
                          height: 14,
                        ),
                        userProfileResponse.user!.preferances!.isNotEmpty ? Wrap(
                          spacing: 8,
                          runSpacing: 8,// gap between adjacent chips
                          children: userProfileResponse.user!.preferances!.map((Preferances e) => Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: const Color(0XffD9D9D9)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 10,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                  },
                                  child: const ImageIcon(AssetImage('assets/images/ic_tick.png'),color: Colors.orange,size: 20,),
                                ),
                                Container(
                                  width: 4,
                                ),
                                Text(
                                  e.preferance!,
                                  style: const TextStyle(color: black),
                                ),
                              ],
                            ),
                          )).toList(),
                        ) : Container(),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 16,
                ),
                userProfileResponse.user!.propertyPreferances!.isNotEmpty ?Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      )),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Property Preferences',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 14,
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,// gap between adjacent chips
                          children: userProfileResponse.user!.propertyPreferances!.map((Property_preferances e) => Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: const Color(0XffD9D9D9)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 10,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FadeInImage.assetNetwork(
                                      image: e.icon!,
                                      width: 20,
                                      height: 20,
                                      placeholder:
                                      'assets/images/placeholder.png',
                                    ),
                                    Container(
                                      width: 4,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          toDisplayCase(e.type!) + ': ',
                                          style: const TextStyle(
                                              color: dark_text,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          toDisplayCase(e.value!),
                                          style: const TextStyle(
                                              color: Colors.orange,
                                              fontSize: 12  ,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                ) : Container(),
                Container(
                  height: 16,
                ),
                userProfileResponse.user!.prefferedLocation!.isNotEmpty ? Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.0,
                            style: BorderStyle.solid,
                            color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      )),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Preferred Location',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 14,
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,// gap between adjacent chips
                          children: userProfileResponse.user!.prefferedLocation!.map((Preffered_location e) => Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: const Color(0XffD9D9D9)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 10,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                  },
                                  child: const ImageIcon(AssetImage('assets/images/ic_tick.png'),color: Colors.orange,size: 20,),
                                ),
                                Container(
                                  width: 4,
                                ),
                                Text(
                                  toDisplayCase(e.location!),
                                  style: const TextStyle(color: black),
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                ) : Container()
              ],
            ),
          ))
        ],
      )) : const NoInternetWidget(),
    ), onWillPop: (){
      Navigator.pop(context);
      return Future.value(true);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });

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

  _getUserProfileInformation(userId) async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
            HttpLogger(logLevel: LogLevel.BODY),
          ]);

      final url = Uri.parse(BASE_URL + getOtherUserProfileInformation);

      Map<String, String> jsonBody = {
            'apiId': API_KEY,
            'user_id': sessionManager.getUserId() ?? "0",
            'get_user_details_id': userId,
            'token': sessionManager.getToken() ?? ""
          };

      final response = await http.post(
              url,
              body: jsonBody
          );

      final statusCode = response.statusCode;

      if (statusCode == 200) {
            // this API passes back the id of the new item added to the body
            setState(() {
              _isLoading = false;
            });

            final body = response.body;

            Map<String, dynamic> user = jsonDecode(body);
            userProfileResponse = UserProfileResponse.fromJson(user);
          }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void castStatefulWidget() {
    widget is UserProfilePage;
  }

}

