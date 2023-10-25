import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/addproperty/add_property.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/property_type.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';

import 'detail.dart';
import 'model/common_response.dart';
import 'model/property_list_response.dart';
import 'network/api_end_points.dart';

class MyListing extends StatefulWidget {
  const MyListing({Key? key}) : super(key: key);

  @override
  _MyListingState createState() => _MyListingState();
}

class _MyListingState extends State<MyListing> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  bool status = true;
  var propertyResponse = PropertyListResponse();
  SessionManager sessionManager = SessionManager();
  bool _isMainLoading = false;

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
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
                        propertyResponse.success == 1 &&
                            propertyResponse.properties!.isNotEmpty
                            ? Container(
                            width: 52,
                            height: 52,
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0XffD7D7D7),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.post_add,
                                  color: Colors.black,
                                  size: 24,
                                ),
                                onPressed: () async {
                                  final bool shouldRefresh = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddProperty(Properties(), false)),
                                  );

                                  if (shouldRefresh) {
                                    getDataFromServer();
                                  }
                                },
                              ),
                            ))
                            : Container(),
                      ],
                    ),
                  ),
                  centerTitle: false,
                  elevation: 0,
                  backgroundColor: const Color(0XffEDEDEE),
                )),
            Expanded(child: _isMainLoading
                ? const LoadingWidget()
                : Container(
              padding: const EdgeInsets.all(12),
              child: propertyResponse.success == 1 &&
                  propertyResponse.properties!.isNotEmpty
                  ? ListView.separated(
                controller: _scrollViewController,
                shrinkWrap: true,
                primary: false,
                itemCount: propertyResponse.properties!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertyDetailPage(
                                propertyResponse
                                    .properties![index].propertyId!)),
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
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Card(
                                margin: EdgeInsets.zero,
                                semanticContainer: true,
                                clipBehavior:
                                Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12.0),
                                ),
                                elevation: 5,
                                child: propertyResponse
                                    .properties![index]
                                    .images!
                                    .isNotEmpty &&
                                    propertyResponse
                                        .properties![index]
                                        .images![0]
                                        .image!
                                        .isNotEmpty
                                    ? FadeInImage.assetNetwork(
                                  image: propertyResponse
                                      .properties![index]
                                      .images![0]
                                      .image! +
                                      "&w=720",
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                  placeholder:
                                  'assets/images/placeholder.png',
                                )
                                    : Image.asset(
                                  'assets/images/placeholder.png',
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin:
                                  const EdgeInsets.only(left: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        toDisplayCase(propertyResponse
                                            .properties![index]
                                            .title!
                                            .trim()
                                            .toString()) +
                                            " - " +
                                            propertyResponse
                                                .properties![index]
                                                .beds +
                                            " Bhk",
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
                                        toDisplayCase(propertyResponse
                                            .properties![index].location
                                            .toString()),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: dark_gray),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 1,
                              ),
                              const Divider(),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    backgroundColor: white,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                            Radius.circular(20),
                                            topRight:
                                            Radius.circular(20))),
                                    elevation: 5,
                                    isDismissible: true,
                                    builder: (BuildContext context) {
                                      // we set up a container inside which
                                      // we create center column and display text
                                      return Wrap(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Container(
                                                padding:
                                                const EdgeInsets
                                                    .all(20),
                                                child: Text(
                                                  toDisplayCase(
                                                      propertyResponse
                                                          .properties![
                                                      index]
                                                          .title
                                                          .toString()),
                                                  style: const TextStyle(
                                                      color: black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                              Container(
                                                  height: 1,
                                                  width: MediaQuery.of(
                                                      context)
                                                      .size
                                                      .width,
                                                  color: light_gray),
                                              Container(
                                                padding:
                                                const EdgeInsets
                                                    .all(20),
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        Navigator.pop(
                                                            context);
                                                        final bool
                                                        shouldRefresh =
                                                        await Navigator
                                                            .push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => AddProperty(
                                                                  propertyResponse
                                                                      .properties![index],
                                                                  true)),
                                                        );

                                                        if (shouldRefresh) {
                                                          getDataFromServer();
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .edit_outlined,
                                                            color:
                                                            dark_gray,
                                                            size: 24,
                                                          ),
                                                          Container(
                                                              width:
                                                              14),
                                                          const Text(
                                                            'Edit Property',
                                                            style: TextStyle(
                                                                color:
                                                                dark_text,
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 24,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(
                                                            context);
                                                        //delete property work
                                                        showDeletePropertyDialog(
                                                            propertyResponse
                                                                .properties![
                                                            index]);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .delete_outline_rounded,
                                                            color:
                                                            dark_gray,
                                                            size: 24,
                                                          ),
                                                          Container(
                                                              width:
                                                              14),
                                                          const Text(
                                                            'Delete Property',
                                                            style: TextStyle(
                                                                color:
                                                                dark_text,
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.menu_open_rounded,
                                  color: dark_gray,
                                  size: 22,
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  height: 0,
                  color: Colors.transparent,
                ),
              )
                  : Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: const BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(22.0)),
                        color: white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(12),
                              child: Image.asset(
                                  'assets/images/vector.jpg',
                                  height: 140,
                                  fit: BoxFit.cover),
                            ),
                            Container(
                              height: 8,
                            ),
                            const Text(
                              'No Listing Found!',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: black),
                            ),
                            Container(
                              height: 8,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Wrap(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        backgroundColor: white,
                                        isScrollControlled: true,
                                        shape:
                                        const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.only(
                                                topLeft: Radius
                                                    .circular(
                                                    20),
                                                topRight: Radius
                                                    .circular(
                                                    20))),
                                        elevation: 5,
                                        isDismissible: true,
                                        builder:
                                            (BuildContext context) {
                                          // we set up a container inside which
                                          // we create center column and display text
                                          return Wrap(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Container(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(20),
                                                    child: const Text(
                                                      'Create A Listing',
                                                      style: TextStyle(
                                                          color: black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold),
                                                    ),
                                                  ),
                                                  Container(
                                                      height: 1,
                                                      width:
                                                      MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width,
                                                      color:
                                                      light_gray),
                                                  Container(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(20),
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                  const PropertyType()),
                                                            );
                                                          },
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .add_rounded,
                                                                color:
                                                                black,
                                                                size:
                                                                28,
                                                              ),
                                                              Container(
                                                                  width:
                                                                  14),
                                                              const Text(
                                                                'Set User Preferences',
                                                                style: TextStyle(
                                                                    color:
                                                                    dark_text,
                                                                    fontSize:
                                                                    16,
                                                                    fontWeight:
                                                                    FontWeight.w600),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 24,
                                                        ),
                                                        InkWell(
                                                          onTap:
                                                              () async {
                                                            Navigator.pop(
                                                                context);
                                                            final bool
                                                            shouldRefresh =
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => AddProperty(
                                                                      Properties(),
                                                                      false)),
                                                            );

                                                            if (shouldRefresh) {
                                                              getDataFromServer();
                                                            }
                                                          },
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .add_rounded,
                                                                color:
                                                                black,
                                                                size:
                                                                28,
                                                              ),
                                                              Container(
                                                                  width:
                                                                  14),
                                                              const Text(
                                                                'Add a Property Listing',
                                                                style: TextStyle(
                                                                    color:
                                                                    dark_text,
                                                                    fontSize:
                                                                    16,
                                                                    fontWeight:
                                                                    FontWeight.w600),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 30,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 18,
                                          top: 12,
                                          right: 18,
                                          bottom: 12),
                                      margin:
                                      const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          color: dark_orange,
                                          border: Border.all(
                                              color: Colors.orange),
                                          borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(24))),
                                      child: const Text(
                                          'Create a listing',
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.bold)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        )));
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
    getDataFromServer();
  }

  void getDataFromServer() {
    setState(() {
      _isMainLoading = true;
    });
    _getMyProperty();
  }

  _getMyProperty() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + getPropertiesByCity);

    Map<String, String> jsonBody = {
      'apiId': API_KEY,
      'user_id': sessionManager.getUserId() ?? "0",
      'token': sessionManager.getToken() ?? "",
      'my_property': "1"
    };

    final response = await http.post(url, body: jsonBody);

    final statusCode = response.statusCode;
    setState(() {
      _isMainLoading = false;
    });
    if (statusCode == 200) {
      // this API passes back the id of the new item added to the body
      final body = response.body;

      Map<String, dynamic> city = jsonDecode(body);
      setState(() {
        propertyResponse = PropertyListResponse.fromJson(city);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
  }

  void showDeletePropertyDialog(Properties properties) {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                const Text("Delete Property",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                Container(
                  height: 20,
                ),
                Text(
                    "Are you sure want to delete the property\n" +
                        properties.title.toString() +
                        "?",
                    style: const TextStyle(
                        color: dark_text,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                    textAlign: TextAlign.center),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: const Text("Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: dark_orange,
                                fontWeight: FontWeight.normal,
                                fontSize: 18)),
                      ),
                    ),
                    InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          setState(() {
                            _isMainLoading = true;
                          });
                          _deleteProperty(properties);
                        },
                        child: Container(
                          height: 50.0,
                          width: 120.0,
                          margin: const EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: light_orange,
                              border: Border.all(
                                color: dark_orange,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: const Text("Delete",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: dark_orange,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18)),
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
  }

  _deleteProperty(Properties properties) async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + deleteProperty);

      Map<String, String> jsonBody = {
        'apiId': API_KEY,
        'user_id': sessionManager.getUserId() ?? "0",
        'property_id': properties.propertyId.toString(),
        'token': sessionManager.getToken() ?? ""
      };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      setState(() {
        _isMainLoading = false;
      });

      if (statusCode == 200) {
        // this API passes back the id of the new item added to the body
        final body = response.body;

        Map<String, dynamic> city = jsonDecode(body);
        var commonResponse = CommonResponse.fromJson(city);
        showSnackBar(commonResponse.message, context);
        setState(() {
          propertyResponse.properties!.remove (properties);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
