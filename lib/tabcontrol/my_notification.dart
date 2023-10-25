import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/model/notification_list_response.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:share_my_appartment/widget/no_data.dart';

import '../constant/constants.dart';
import '../network/api_end_points.dart';
import '../utils/app_utils.dart';

class MyNotificationListingPage extends StatefulWidget {
  const MyNotificationListingPage({Key? key}) : super(key: key);

  @override
  _MyNotificationListingPageState createState() => _MyNotificationListingPageState();
}

class _MyNotificationListingPageState extends BaseState<MyNotificationListingPage> {

  SessionManager sessionManager = SessionManager();
  var notificationListResponse = NotificationListResponse();
  bool _isMainLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffEDEDEE),
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
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
            ],
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0XffEDEDEE),
      ),
      body: _isMainLoading ? const LoadingWidget() : notificationListResponse.success == 0 ? const MyNoDataWidget(msg: "No inquiry found.") : Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: notificationListResponse.notifications!.length,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              margin: const EdgeInsets.all(6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    margin: EdgeInsets.zero,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 5,
                    child: notificationListResponse.notifications![index].image!.isNotEmpty &&
                        notificationListResponse.notifications![index].image!.isNotEmpty
                        ? FadeInImage.assetNetwork(
                      image: notificationListResponse.notifications![index].image!+"&w=720",
                      fit: BoxFit.cover,
                      width: 90,
                      height: 80,
                      placeholder:
                      'assets/images/placeholder.png',
                    )
                        : Image.asset('assets/images/placeholder.png',fit: BoxFit.cover,
                      width: 90,
                      height: 80,),
                  ),
                  Flexible(child: Container(
                    margin: const EdgeInsets.only(left: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          toDisplayCase(notificationListResponse.notifications![index].title!.trim().toString()),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        Container(
                          height: 3,
                        ),
                        Text(
                          toDisplayCase(notificationListResponse.notifications![index].message.toString()),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12,color: dark_gray),
                        ),
                        Container(
                          height: 3,
                        ),
                        Text(
                          toDisplayCase("Inquired on : " + DateFormat('dd MMMM yyyy, HH:mm a').format(DateTime.parse(notificationListResponse.notifications![index].timestamp.toString()))),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12,color: dark_orange, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),flex: 1,),
                  const Divider(),
                ],
              ),
            );
          }, separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isMainLoading = true;
    });

    if(isOnline){
      _getNotificationList();
    }
  }

  _getNotificationList() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + notificationList);

      Map<String, String> jsonBody = {
        'apiId': API_KEY,
        'user_id': sessionManager.getUserId() ?? "0",
        'token': sessionManager.getToken() ?? ""
      };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        // this API passes back the id of the new item added to the body
        final body = response.body;

        Map<String, dynamic> city = jsonDecode(body);
        notificationListResponse = NotificationListResponse.fromJson(city);
        setState(() {
          _isMainLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void castStatefulWidget() {
    widget is MyNotificationListingPage;
  }

}