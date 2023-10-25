import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/global_context.dart';
import 'package:share_my_appartment/model/inquiry_list_response.dart';
import 'package:share_my_appartment/tabcontrol/tabnavigation.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:share_my_appartment/widget/no_data.dart';

import '../constant/constants.dart';
import '../network/api_end_points.dart';
import '../utils/app_utils.dart';

class MyInquiryListingPage extends StatefulWidget {
  const MyInquiryListingPage({Key? key}) : super(key: key);

  @override
  _MyInquiryListingPageState createState() => _MyInquiryListingPageState();
}

class _MyInquiryListingPageState extends BaseState<MyInquiryListingPage> {
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
      body : SafeArea(child: Column(
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
                                if (NavigationService.notif_type.isNotEmpty) {
                                  NavigationService.notif_type = "";
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => const TabNavigation()),
                                          (Route<dynamic> route) => false);
                                } else {
                                  Navigator.pop(context);
                                }
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
          Expanded(child: _isMainLoading
              ? const LoadingWidget()
              : inquiryListResponse.success == 0
              ? const MyNoDataWidget(msg: "No inquiry found.")
              : Container(
            padding: const EdgeInsets.all(12),
            child: ListView.separated(
              controller: _scrollViewController,
              shrinkWrap: true,
              primary: false,
              itemCount: inquiryListResponse.inquiries!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    elevation: 5,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          var inputFormat = DateFormat('dd/MM/yyyy');
                          var date1 = inputFormat.parse(
                              inquiryListResponse
                                  .inquiries![index].date!);
                          var outputFormat = DateFormat('dd MMM, yyyy');
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: white,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            elevation: 5,
                            isDismissible: true,
                            builder: (BuildContext context) {
                              // we set up a container inside which
                              // we create center column and display text
                              return Wrap(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        const Text("Inquiry Details",
                                            style: TextStyle(
                                                color: dark_orange,
                                                fontWeight:
                                                FontWeight.w500,
                                                fontSize: 24)),
                                        Container(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Card(
                                                  margin: EdgeInsets.zero,
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  shape:
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        12.0),
                                                  ),
                                                  elevation: 5,
                                                  child: inquiryListResponse
                                                      .inquiries![
                                                  index]
                                                      .image != null &&
                                                      inquiryListResponse
                                                          .inquiries![
                                                      index]
                                                          .image!
                                                          .isNotEmpty
                                                      ? FadeInImage
                                                      .assetNetwork(
                                                    image: inquiryListResponse
                                                        .inquiries![
                                                    index]
                                                        .image! +
                                                        "&w=720",
                                                    fit: BoxFit
                                                        .cover,
                                                    width: 90,
                                                    height: 80,
                                                    placeholder:
                                                    'assets/images/placeholder.png',
                                                  )
                                                      : Image.asset(
                                                    'assets/images/placeholder.png',
                                                    fit: BoxFit
                                                        .cover,
                                                    width: 90,
                                                    height: 80,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 14),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Text(
                                                          toDisplayCase(inquiryListResponse
                                                              .inquiries![
                                                          index]
                                                              .title!
                                                              .trim()
                                                              .toString()),
                                                          textAlign:
                                                          TextAlign
                                                              .center,
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontSize:
                                                              14),
                                                        ),
                                                        Container(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          toDisplayCase(inquiryListResponse
                                                              .inquiries![
                                                          index]
                                                              .location
                                                              .toString()),
                                                          maxLines: 2,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize:
                                                              12,
                                                              color:
                                                              dark_gray),
                                                        ),
                                                        Container(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          toDisplayCase("Inquired On : " +
                                                              outputFormat
                                                                  .format(
                                                                  date1)),
                                                          maxLines: 2,
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize:
                                                              12,
                                                              color:
                                                              dark_orange,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  flex: 1,
                                                ),
                                              ],
                                            ),
                                            Container(height: 14),
                                            const Divider(
                                                height: 1,
                                                color: light_gray,
                                                thickness: 0.5),
                                            Container(height: 14),
                                            Text(
                                              toDisplayCase("Name : " +
                                                  inquiryListResponse
                                                      .inquiries![index]
                                                      .name
                                                      .toString()),
                                              maxLines: 1,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: dark_gray,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            Container(
                                              height: 6,
                                            ),
                                            Text(
                                              "Email : " +
                                                  inquiryListResponse
                                                      .inquiries![index]
                                                      .email
                                                      .toString(),
                                              maxLines: 1,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: dark_gray,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            Container(
                                              height: 6,
                                            ),
                                            Text(
                                              toDisplayCase(
                                                  "Contact No : " +
                                                      inquiryListResponse
                                                          .inquiries![
                                                      index]
                                                          .contact
                                                          .toString()),
                                              maxLines: 1,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: dark_gray,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            Container(
                                              height: 6,
                                            ),
                                            inquiryListResponse
                                                .inquiries![index]
                                                .message == null || inquiryListResponse
                                                .inquiries![index]
                                                .message!.toString().trim().isEmpty ? Container() : Text(
                                              toDisplayCase("Message : " +
                                                  inquiryListResponse
                                                      .inquiries![index]
                                                      .message
                                                      .toString()),
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: dark_gray,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                            Container(
                                              height: 30,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
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
                              child: inquiryListResponse
                                  .inquiries![index].image !=
                                  null &&
                                  inquiryListResponse
                                      .inquiries![index]
                                      .image!
                                      .isNotEmpty
                                  ? FadeInImage.assetNetwork(
                                image: inquiryListResponse
                                    .inquiries![index].image! +
                                    "&w=720",
                                fit: BoxFit.cover,
                                width: 90,
                                height: 80,
                                placeholder:
                                'assets/images/placeholder.png',
                              )
                                  : Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                                width: 90,
                                height: 80,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.only(left: 14),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      toDisplayCase(inquiryListResponse
                                          .inquiries![index].title!
                                          .trim()
                                          .toString()),
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
                                      toDisplayCase(inquiryListResponse
                                          .inquiries![index].location
                                          .toString()),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12, color: dark_gray),
                                    ),
                                    Container(
                                      height: 3,
                                    ),
                                    inquiryListResponse
                                        .inquiries![index]
                                        .message == null || inquiryListResponse
                                        .inquiries![index]
                                        .message!.toString().trim().isEmpty ? Container() : Text(
                                      toDisplayCase("Message : " +
                                          inquiryListResponse
                                              .inquiries![index].message
                                              .toString()),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: dark_orange,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              flex: 1,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(
                height: 0,
                color: Colors.transparent,
              ),
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

    if (isOnline) {
      _getInquiryList();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
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
        'type': "received",
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
    widget is MyInquiryListingPage;
  }
}
