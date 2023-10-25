import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/model/inquiry_list_response.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:share_my_appartment/widget/no_data.dart';

import '../constant/constants.dart';
import '../detail.dart';
import '../network/api_end_points.dart';
import '../utils/app_utils.dart';

class BookingPageListingPage extends StatefulWidget {
  const BookingPageListingPage({Key? key}) : super(key: key);

  @override
  _BookingListingPageState createState() => _BookingListingPageState();
}

class _BookingListingPageState extends BaseState<BookingPageListingPage> {

  SessionManager sessionManager = SessionManager();
  var inquiryListResponse = InquiryListResponse();
  bool _isMainLoading = false;

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XffEDEDEE),
      body: SafeArea(child: Column(
          mainAxisSize: MainAxisSize.max,
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
                        Text('Bookings',
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
            Expanded(child:_isMainLoading ? const LoadingWidget() : inquiryListResponse.success == 0 ? const MyNoDataWidget(msg: "No inquiry found.") : SingleChildScrollView(
              controller: _scrollViewController,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: inquiryListResponse.inquiries!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PropertyDetailPage(
                                      inquiryListResponse.inquiries![index].propertyId!)),
                            );
                          },
                          child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              elevation: 5,
                              child: Container(
                            margin: const EdgeInsets.all(10),
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
                                  child: inquiryListResponse.inquiries![index].image != null &&
                                      inquiryListResponse.inquiries![index].image!.isNotEmpty
                                      ? FadeInImage.assetNetwork(
                                    image: inquiryListResponse.inquiries![index].image!+"&w=720",
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
                                        toDisplayCase(inquiryListResponse.inquiries![index].title!.trim().toString()),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      Container(
                                        height: 3,
                                      ),
                                      Text(
                                        toDisplayCase(inquiryListResponse.inquiries![index].location.toString()),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 12,color: dark_gray),
                                      ),
                                      Container(
                                        height: 3,
                                      ),
                                      Text(
                                        toDisplayCase("Message : " + inquiryListResponse.inquiries![index].message.toString()),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 12,color: dark_orange,fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),flex: 1,),
                                const Divider(),
                              ],
                            ),
                          )),
                        );
                      }, separatorBuilder: (BuildContext context, int index) => const Divider(height: 0,color: Colors.transparent),),
                  )
                ],
              ),
            ))
          ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isMainLoading = true;
    });

    if(isOnline){
      _getInquiryList();
    }

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

  void refreshTheData(){
    _getInquiryList();
  }

  _getInquiryList() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + inquiryList);

      Map<String, String> jsonBody = {
        'apiId': API_KEY,
        'user_id': sessionManager.getUserId() ?? "0",
        'type': "sent",
        'token': sessionManager.getToken() ?? ""
      };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        // this API passes back the id of the new item added to the body
        final body = response.body;

        Map<String, dynamic> city = jsonDecode(body);
        inquiryListResponse = InquiryListResponse.fromJson(city);

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
    widget is BookingPageListingPage;
  }

}