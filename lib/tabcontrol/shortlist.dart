import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/detail.dart';
import 'package:share_my_appartment/model/common_response.dart';
import 'package:share_my_appartment/model/property_detail_response.dart';
import 'package:share_my_appartment/model/property_list_response.dart';
import 'package:share_my_appartment/network/api_end_points.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:share_my_appartment/widget/no_data.dart';
import 'package:share_my_appartment/widget/no_internet.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../addproperty/property_inquiry.dart';
import '../constant/constants.dart';

class ShortListingPage extends StatefulWidget {
  const ShortListingPage({Key? key}) : super(key: key);

  @override
  BaseState<ShortListingPage> createState() => _ShortListingPageState();
}

class _ShortListingPageState extends BaseState<ShortListingPage> {
  SessionManager sessionManager = SessionManager();
  var propertyBookmarkResponse = PropertyListResponse();
  bool _isMainLoading = false;
  bool _isListEmpty = false;

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
    if(isOnline && propertyBookmarkResponse.success == null){
      _getPropertiesByCity();
    }

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
                      Text('Favourites',
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
          Expanded(child: isOnline ? _isMainLoading ? const LoadingWidget() : (propertyBookmarkResponse.success == 0 || _isListEmpty) ? const MyNoDataWidget(msg: 'No property has been favourite.') : ListView(
            controller: _scrollViewController,
            children: [
              Padding(
                  padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 18),
                  child: Wrap(
                    children: [
                      _nearbypropertieslisting(propertyBookmarkResponse.properties!.length)
                    ],
                  ))
            ],
          ) : const NoInternetWidget())
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
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
  }

  ListView _nearbypropertieslisting(int n) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: n,
        itemBuilder: (ctx, index) => (GestureDetector(
          onTap: () async {
            PropertyDetailResponse propertyDetailResponse = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  PropertyDetailPage(propertyBookmarkResponse.properties![index].propertyId!)),
            );
            /*setState(() {
              propertyResponse.properties![index] = propertyResponse.properties!.firstWhere((item) => item.propertyId == propertyDetailResponse.property!.propertyId);
              propertyResponse.properties![index].setFavourite = propertyDetailResponse.property!.isFavourite!;
            });*/
          },
          child: IntrinsicHeight(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              padding: const EdgeInsets.all(6),
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
                children: [
                  SizedBox(
                    height: 230,
                    child: Row(
                      children: [
                        Flexible(
                          child: Stack(
                            children: [
                              Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                elevation: 5,
                                child: propertyBookmarkResponse.properties![index].images![0].image!.isNotEmpty ? FadeInImage.assetNetwork(
                                  image: propertyBookmarkResponse.properties![index].images![0].image!+"&w=720",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 230,
                                  placeholder:
                                  'assets/images/placeholder.png',
                                ) :
                                Image.asset('assets/images/placeholder.png',fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 230,),
                              ),
                              Container(
                                margin: const EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: const ShapeDecoration(
                                        color: Colors.orangeAccent,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(style: BorderStyle.none),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30.0)),
                                        ),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(left: 10,top: 2,right: 10,bottom: 2),
                                          child: Text(propertyBookmarkResponse.properties![index].status! == '1' ? 'Available' : 'Not Available',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500))),
                                    ),
                                    const Spacer(flex: 1),
                                    const Icon(Icons.star,color: Colors.white,size: 18,),
                                    Container(
                                      width: 2,
                                    ),
                                    Text(propertyBookmarkResponse.properties![index].rateings!,textAlign: TextAlign.center,style: const TextStyle(color: Colors.white,fontSize: 12),)
                                  ],
                                ),
                              )
                            ],
                          ),
                          flex: 1,
                        ),
                        Container(
                          decoration: const ShapeDecoration(
                              color: Color(0XFFFBC8B1),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Colors.white),
                                borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                              )),
                          margin: const EdgeInsets.only(top: 2, left: 6),
                          padding: const EdgeInsets.all(2),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              InkWell(
                              onTap: (){
                                _markPropertyAsFavorite(propertyBookmarkResponse.properties![index].propertyId!,propertyBookmarkResponse.properties,index);
                              },
                              child: Column(
                                children: [
                                  propertyBookmarkResponse.properties![index].isFavourite! == 1 ? const Icon(Icons.favorite_rounded, size: 20,color: Color(0XFF723B23),) : const Icon(Icons.favorite_border_rounded, size: 20,color: Color(0XFF723B23),),
                                  const Text(
                                    'Favourite',
                                    style: TextStyle(
                                        fontSize: 10, color: Color(0XFF723B23)),
                                  )
                                ],
                              )
                            ),
                              const Spacer(flex: 1),
                              InkWell(
                                onTap: () async {
                                  //share code here
                                  final uri = Uri.parse(propertyBookmarkResponse.properties![index].images![0].image.toString()+"&w=720");
                                  final response = await http.get(uri);
                                  final bytes = response.bodyBytes;
                                  final temp = await getTemporaryDirectory();
                                  final path = '${temp.path}/image.jpg';
                                  File(path).writeAsBytesSync(bytes);

                                  shareFileWithText("Hey! Please visit the below property on share my apartment.\n",
                                      toDisplayCase(propertyBookmarkResponse.properties![index].title.toString()) + "\n\n" + propertyBookmarkResponse.properties![index].location.toString(),
                                      path);
                                },
                                child: Column(
                                  children: const [
                                    Icon(Icons.share_outlined, size: 20,color: Color(0XFF723B23)),
                                    Text('Share',
                                        style: TextStyle(
                                            fontSize: 10, color: Color(0XFF723B23))),
                                  ],
                                ),
                              ),
                              const Spacer(flex: 1),
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PropertyInquiry(propertyBookmarkResponse.properties![index].title!,
                                            propertyBookmarkResponse.properties![index].propertyId!)),
                                  );
                                },
                                child: Column(
                                  children: const [
                                    Icon(Icons.bookmark_border_outlined, size: 20,color: Color(0XFF723B23)),
                                    Text('Book Now!',
                                        style: TextStyle(
                                            fontSize: 10, color: Color(0XFF723B23)))
                                  ],
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 6, top: 8, right: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '₹${propertyBookmarkResponse.properties![index].price!}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "/Month",
                              style:
                              TextStyle(color: dark_text, fontSize: 14),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.location_on_outlined, size: 18,color: Colors.orangeAccent),
                              Flexible(child: Text(
                                toDisplayCase(propertyBookmarkResponse.properties![index].location!),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: dark_text,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    propertyBookmarkResponse.properties![index].beds!.isNotEmpty && propertyBookmarkResponse.properties![index].beds! != "0" ? const Icon(Icons.bed_outlined, size: 18,color: Colors.orangeAccent) : Container(),
                                    propertyBookmarkResponse.properties![index].beds!.isNotEmpty && propertyBookmarkResponse.properties![index].beds! != "0" ? Container(
                                      width: 5,
                                    ) : Container(),
                                    propertyBookmarkResponse.properties![index].beds!.isNotEmpty && propertyBookmarkResponse.properties![index].beds! != "0" ? Text(
                                      propertyBookmarkResponse.properties![index].beds!,
                                      style: const TextStyle(
                                          color: dark_text,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ) : Container(),
                                    propertyBookmarkResponse.properties![index].bathrooms!.isNotEmpty && propertyBookmarkResponse.properties![index].bathrooms! != "0" ? Container(
                                      width: 3,
                                      height: 3,
                                      margin: const EdgeInsets.only(
                                          left: 4, right: 4),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black54,
                                      ),
                                    ) : Container(),
                                    propertyBookmarkResponse.properties![index].bathrooms!.isNotEmpty && propertyBookmarkResponse.properties![index].bathrooms! != "0" ? const Icon(Icons.bathtub_outlined,
                                        size: 18,color: Colors.orangeAccent) : Container(),
                                    propertyBookmarkResponse.properties![index].bathrooms!.isNotEmpty && propertyBookmarkResponse.properties![index].bathrooms! != "0" ? Container(
                                      width: 5,
                                    ) : Container(),
                                    propertyBookmarkResponse.properties![index].bathrooms!.isNotEmpty && propertyBookmarkResponse.properties![index].bathrooms! != "0" ? Text(
                                      propertyBookmarkResponse.properties![index].bathrooms!,
                                      style: const TextStyle(
                                          color: dark_text,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ) : Container(),
                                    propertyBookmarkResponse.properties![index].balcony!.isNotEmpty && propertyBookmarkResponse.properties![index].balcony! != "0" ? Container(
                                      width: 3,
                                      height: 3,
                                      margin: const EdgeInsets.only(
                                          left: 4, right: 4),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black54,
                                      ),
                                    ) : Container(),
                                    propertyBookmarkResponse.properties![index].balcony!.isNotEmpty && propertyBookmarkResponse.properties![index].balcony! != "0" ? const Icon(Icons.home_outlined, size: 18,color: Colors.orangeAccent) : Container(),
                                    propertyBookmarkResponse.properties![index].balcony!.isNotEmpty && propertyBookmarkResponse.properties![index].balcony! != "0" ? Container(
                                      width: 5,
                                    ) : Container(),
                                    propertyBookmarkResponse.properties![index].balcony!.isNotEmpty && propertyBookmarkResponse.properties![index].balcony! != "0" ? Text(
                                      propertyBookmarkResponse.properties![index].balcony!,
                                      style: const TextStyle(
                                          color: dark_text,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ) : Container(),
                                  ],
                                ),
                                flex: 1,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Looking for:',
                                    style: TextStyle(
                                        color: dark_text,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    toDisplayCase(propertyBookmarkResponse.properties![index].lookingFor!),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )));
  }

  _getPropertiesByCity() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
            HttpLogger(logLevel: LogLevel.BODY),
          ]);

      final url = Uri.parse(BASE_URL + getPropertiesByCity);

      Map<String, String> jsonBody = {
            'apiId': API_KEY,
            'user_id': sessionManager.getUserId() ?? "0",
            'token': sessionManager.getToken() ?? "",
            'is_favourite': '1'
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
            propertyBookmarkResponse = PropertyListResponse.fromJson(city);
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

  _markPropertyAsFavorite(String propertyId, List<Properties>? properties, int index) async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
            HttpLogger(logLevel: LogLevel.BODY),
          ]);

      final url = Uri.parse(BASE_URL + markPropertyAsFavourite);

      Map<String, String> jsonBody = {
            'apiId': API_KEY,
            'user_id': sessionManager.getUserId() ?? "0",
            'property_id': propertyId,
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
              setState(() {
                properties?.removeAt(index);
                if(properties!.isEmpty)
                  {
                    _isListEmpty = true;
                  }
              });
            }
          }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void castStatefulWidget() {
    widget is ShortListingPage;
  }
}
