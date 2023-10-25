import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/model/property_detail_response.dart';
import 'package:share_my_appartment/userprofile.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:share_my_appartment/widget/no_data.dart';
import 'package:share_my_appartment/widget/no_internet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'addproperty/property_inquiry.dart';
import 'model/common_response.dart';
import 'network/api_end_points.dart';
import 'utils/full_screen_image.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PropertyDetailPage extends StatefulWidget {
  final String propertyId;

  const PropertyDetailPage(this.propertyId, {Key? key}) : super(key: key);

  @override
  BaseState<PropertyDetailPage> createState() => _PropertyDetailPageState();
}

class _PropertyDetailPageState extends BaseState<PropertyDetailPage> {
  SessionManager sessionManager = SessionManager();
  var propertyDetailResponse = PropertyDetailResponse();
  bool _isMainLoading = false;
  late List pages;
  late PageController controller;
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  late LatLng _center;
  List<String> images = List<String>.empty(growable: true);

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
    if(!_isMainLoading)
      {
        controller = PageController(viewportFraction: 1, keepPage: true);
        pages = List.generate(
            propertyDetailResponse.property!.images!.length,
                (index) => InkWell(
              onTap: (){
                images.clear();
                for(var i = 0;i<propertyDetailResponse.property!.images!.length;i++){
                  images.addAll([propertyDetailResponse.property!.images![i].image!]);
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return FullScreenImage("",images,index);
                    }));
              },
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 0,
                child: propertyDetailResponse.property!.images![index].image!.isNotEmpty
                    ? FadeInImage.assetNetwork(
                  image: propertyDetailResponse.property!.images![index].image! + "&w=720",
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/placeholder.png',)
                    : Image.asset('assets/images/placeholder.png',
                    fit: BoxFit.cover),
              ),
            ));
      }

    return WillPopScope(onWillPop: (){
      Navigator.pop(context, propertyDetailResponse);
      return Future.value(true);
    },child: Scaffold(
      backgroundColor: const Color(0XffEDEDEE),
      body: isOnline ? _isMainLoading
          ? const LoadingWidget()
          : propertyDetailResponse.success == 0
          ? const MyNoDataWidget(msg: 'Property detail not found.')
          : SafeArea(child: Column(
                  mainAxisSize: MainAxisSize.max,
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
                                          Navigator.pop(context, propertyDetailResponse);
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
                                          final uri = Uri.parse(propertyDetailResponse.property!.images![0].image.toString()+"&w=720");
                                          final response = await http.get(uri);
                                          final bytes = response.bodyBytes;
                                          final temp = await getTemporaryDirectory();
                                          final path = '${temp.path}/image.jpg';
                                          File(path).writeAsBytesSync(bytes);

                                          shareFileWithText("Hey! Please visit the below property on share my apartment.\n",
                                              toDisplayCase(propertyDetailResponse.property!.title.toString()) + "\n\n" + propertyDetailResponse.property!.location.toString(),
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
                                        icon: !_isMainLoading && propertyDetailResponse.property!.isFavourite == 1 ? const Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.black,
                                          size: 24,
                                        )
                                            : const Icon(
                                          Icons.favorite_border_rounded,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                        onPressed: () {
                                          _markPropertyAsFavorite(propertyDetailResponse);
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 250,
                                  child: PageView.builder(
                                    controller: controller,
                                    // itemCount: pages.length,
                                    itemBuilder: (_, index) {
                                      return pages[index % pages.length];
                                    },
                                  ),
                                ),
                                pages.length > 1 ? Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 12),
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
                                ) : Container(),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 12, right: 12, bottom: 12),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Center(
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              decoration: const ShapeDecoration(
                                                color: Colors.orange,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      style: BorderStyle.none),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(30.0)),
                                                ),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10,
                                                      top: 2,
                                                      right: 10,
                                                      bottom: 2),
                                                  child: Text(
                                                      propertyDetailResponse.property!.status! == '1'
                                                          ? 'Available'
                                                          : 'Not Available',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight:
                                                          FontWeight.w500))),
                                            ),
                                          ),
                                          const Spacer(flex: 1),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 25,
                                          ),
                                          Container(
                                            width: 2,
                                          ),
                                          Text(
                                            propertyDetailResponse
                                                .property!.rateings!,
                                            style: const TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '₹${propertyDetailResponse.property!.price!}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            " /Month",
                                            style: TextStyle(
                                                color: dark_text, fontSize: 14),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Property Type: ',
                                            style: TextStyle(
                                                color: dark_text,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            toDisplayCase(propertyDetailResponse
                                                .property!.propertyType!),
                                            style: const TextStyle(
                                                color: Colors.orange,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Looking For: ',
                                            style: TextStyle(
                                                color: dark_text,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            toDisplayCase(propertyDetailResponse
                                                .property!.lookingFor!),
                                            style: const TextStyle(
                                                color: Colors.orange,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Container(
                                        height: 8,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Row(
                                          children: [
                                            propertyDetailResponse.property!.userDetails!.userId == sessionManager.getUserId() ? Container() : Center(
                                              child: InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => PropertyInquiry(propertyDetailResponse.property!.title!,
                                                            propertyDetailResponse.property!.propertyId!)),
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.only(
                                                      left: 12,
                                                      top: 4,
                                                      right: 12,
                                                      bottom: 4),
                                                  margin: const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                                  decoration: BoxDecoration(
                                                      color: const Color(0XFFFEF3E3),
                                                      border: Border.all(
                                                          color: Colors.orange),
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20))),
                                                  child: Center(
                                                    child: Row(
                                                      children: const [
                                                        Icon(
                                                          Icons.bookmark_add_rounded,
                                                          color: Colors.orange,
                                                        ),
                                                        Text('Book Now!',
                                                            style: TextStyle(
                                                                color: Colors.orange,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight.bold))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                            Row(
                                              children: [
                                                propertyDetailResponse.property!.beds!.isNotEmpty && propertyDetailResponse.property!.beds! != "0" ? const Icon(Icons.bed_outlined,
                                                    color: Colors.orangeAccent,
                                                    size: 18) : Container(),
                                                propertyDetailResponse.property!.beds!.isNotEmpty && propertyDetailResponse.property!.beds! != "0" ? Container(
                                                  width: 5,
                                                ) : Container(),
                                                propertyDetailResponse.property!.beds!.isNotEmpty && propertyDetailResponse.property!.beds! != "0" ? Text(
                                                  propertyDetailResponse
                                                      .property!.beds!,
                                                  style: const TextStyle(
                                                      color: dark_text,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ) : Container(),
                                                propertyDetailResponse.property!.bathrooms!.isNotEmpty && propertyDetailResponse.property!.beds! != "0" ? Container(
                                                  width: 3,
                                                  height: 3,
                                                  margin: const EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black54,
                                                  ),
                                                ) : Container(),
                                                propertyDetailResponse.property!.bathrooms!.isNotEmpty && propertyDetailResponse.property!.bathrooms! != "0" ? const Icon(Icons.bathtub_outlined,
                                                    color: Colors.orangeAccent,
                                                    size: 18) : Container(),
                                                propertyDetailResponse.property!.bathrooms!.isNotEmpty && propertyDetailResponse.property!.bathrooms! != "0" ? Container(
                                                  width: 5,
                                                ) : Container(),
                                                propertyDetailResponse.property!.bathrooms!.isNotEmpty && propertyDetailResponse.property!.bathrooms! != "0" ? Text(
                                                  propertyDetailResponse
                                                      .property!.bathrooms!,
                                                  style: const TextStyle(
                                                      color: dark_text,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ) : Container(),
                                                propertyDetailResponse.property!.balcony!.isNotEmpty && propertyDetailResponse.property!.bathrooms! != "0" ? Container(
                                                  width: 3,
                                                  height: 3,
                                                  margin: const EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black54,
                                                  ),
                                                ) : Container(),
                                                propertyDetailResponse.property!.balcony!.isNotEmpty && propertyDetailResponse.property!.balcony! != "0" ? const Icon(Icons.home_outlined,
                                                    color: Colors.orangeAccent,
                                                    size: 18) : Container(),
                                                propertyDetailResponse.property!.balcony!.isNotEmpty && propertyDetailResponse.property!.balcony! != "0" ? Container(
                                                  width: 5,
                                                ) : Container(),
                                                propertyDetailResponse.property!.balcony!.isNotEmpty && propertyDetailResponse.property!.balcony! != "0" ? Text(
                                                  propertyDetailResponse
                                                      .property!.balcony!,
                                                  style: const TextStyle(
                                                      color: dark_text,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ) : Container(),
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
                          Container(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.white),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                                )),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'About Property',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 8,
                                  ),
                                  Text(
                                    propertyDetailResponse.property!.aboutProperty!,
                                    style: const TextStyle(
                                        color: dark_text,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    height: 12,
                                  ),
                                  const Text(
                                    'About your host',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: dark_text,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 12,
                                  ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      margin:
                                      const EdgeInsets.symmetric(horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          color: const Color(0XFFFEF3E3),
                                          border: Border.all(color: Colors.orange),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Icons.thumb_up_alt_rounded,
                                                  color: Colors.orange,
                                                ),
                                                Container(
                                                  width: 6,
                                                ),
                                                Text(
                                                    propertyDetailResponse
                                                        .property!
                                                        .userDetails!
                                                        .totalReviewCount!
                                                        .toString() +
                                                        ' Reviews',
                                                    style: const TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w300))
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfilePage(
                                                              propertyDetailResponse
                                                                  .property!
                                                                  .userDetails!
                                                                  .userId!)),
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  Card(
                                                    semanticContainer: true,
                                                    margin: const EdgeInsets.only(
                                                        right: 8),
                                                    clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(35.0),
                                                    ),
                                                    elevation: 5,
                                                    child: propertyDetailResponse.property!.userDetails!.profilePic!.isNotEmpty ? FadeInImage.assetNetwork(
                                                      image: propertyDetailResponse.property!.userDetails!.profilePic!+"&w=720",
                                                      fit: BoxFit.cover,
                                                      height: 50,
                                                      width: 50,
                                                      placeholder:
                                                      'assets/images/placeholder.png',
                                                    ) :
                                                    Image.asset('assets/images/placeholder.png',fit: BoxFit.cover,height: 50,
                                                        width: 50),
                                                  ),
                                                  Text(
                                                    propertyDetailResponse
                                                        .property!.userDetails!.name!,
                                                    style: const TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 12,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.bed_outlined,
                                                    color: Color(0XFFFAB027),
                                                    size: 18),
                                                Container(
                                                  width: 5,
                                                ),
                                                Text(
                                                  propertyDetailResponse
                                                      .property!
                                                      .userDetails!
                                                      .isIdVerified ==
                                                      '1'
                                                      ? 'Identity Verified'
                                                      : 'Not Verified',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                Container(width: 12),
                                                const Icon(Icons.bathtub_outlined,
                                                    color: Color(0XFFFAB027),
                                                    size: 18),
                                                Container(
                                                  width: 5,
                                                ),
                                                Text(
                                                  propertyDetailResponse
                                                      .property!
                                                      .userDetails!
                                                      .isSuperhero ==
                                                      '1'
                                                      ? 'Superhero'
                                                      : 'NA',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 12,
                                            ),
                                            Text(
                                              propertyDetailResponse
                                                  .property!.userDetails!.aboutUser!,
                                              style: const TextStyle(
                                                  color: black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          propertyDetailResponse.property!.aminities!.isNotEmpty
                              ? Container(
                            height: 16,
                          )
                              : Container(),
                          propertyDetailResponse.property!.aminities!.isNotEmpty
                              ? Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.white),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                                )),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Amenities',
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
                                    children: propertyDetailResponse.property!.aminities!.map((Aminities e) => Container(
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
                                            child: ImageIcon(NetworkImage(e.icon.toString()),color: Colors.orange,size: 20,),
                                          ),
                                          Container(
                                            width: 4,
                                          ),
                                          Text(
                                            e.name!,
                                            style: const TextStyle(color: black),
                                          ),
                                        ],
                                      ),
                                    )).toList(),
                                  ),
                                ],
                              ),
                            ),
                          )
                              : Container(),
                          Container(
                            height: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: const ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                        color: Colors.white),
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)))),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Location',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 14,
                                  ),
                                  Center(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.location_on_outlined,
                                                  color: Color(0XFFFAB027), size: 18),
                                              Container(
                                                width: 8,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  toDisplayCase(propertyDetailResponse.property!.location!),
                                                  style: const TextStyle(
                                                      color: dark_text,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600),
                                                  softWrap: true,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 14,
                                          ),
                                          Center(
                                            child: Container(
                                                padding: const EdgeInsets.all(0),
                                                margin: const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(color: Colors.orange),
                                                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                                                child: SizedBox(
                                                  height: 210,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      topRight: Radius.circular(20),
                                                      bottomRight:
                                                      Radius.circular(20),
                                                      bottomLeft: Radius.circular(20),
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                      Alignment.bottomRight,
                                                      heightFactor: 0.3,
                                                      widthFactor: 2.5,
                                                      child: GoogleMap(
                                                        onMapCreated: _onMapCreated,
                                                        myLocationButtonEnabled: false,
                                                        zoomControlsEnabled: false,
                                                        mapToolbarEnabled: false,
                                                        initialCameraPosition:
                                                        CameraPosition(
                                                          target: _center,
                                                          zoom: 12.0,
                                                        ),
                                                        markers: markers.values.toSet(),
                                                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>> {
                                                            Factory <OneSequenceGestureRecognizer> (
                                                                  () => EagerGestureRecognizer(),
                                                            ),
                                                          }
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ))
          : const NoInternetWidget(),
    ));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isMainLoading = true;
    });


    if(isOnline){
      _getPropertyDetail();
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    final marker = Marker(
      markerId: MarkerId(propertyDetailResponse.property!.title!.toString()),
      position: _center,
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: propertyDetailResponse.property!.title!.toString(),
        snippet: propertyDetailResponse.property!.location!.toString(),
        onTap: (){
          openMap(double.parse(propertyDetailResponse.property!.locationLatitude.toString()), double.parse(propertyDetailResponse.property!.locationLongitude.toString()));
        }
      ),
    );

    setState(() {
      markers[MarkerId(propertyDetailResponse.property!.title!.toString())] = marker;
    });
  }

  GridView _listamenities(int n) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (ctx, i) => (Column(
        children: [
          Container(
            width: 70,
            height: 50,
            margin: const EdgeInsets.only(right: 8),
            decoration: ShapeDecoration(
                color: createMaterialColor(Color(int.parse(propertyDetailResponse.property!.aminities![i].background!.replaceAll('#', '0xff')))).withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                )),
            child: Center(
                child: propertyDetailResponse
                        .property!.aminities![i].icon!.isNotEmpty
                    ? FadeInImage.assetNetwork(image: propertyDetailResponse.property!.aminities![i].icon!,
                        fit: BoxFit.contain,
                        width: 24,
                        height: 24,
                        placeholder: 'assets/images/building.png',
                      )
                    : Image.asset(
                        'assets/images/building.png',
                        fit: BoxFit.cover,
                        width: 24,
                        color: Colors.transparent,
                        height: 24,
                      )),
          ),
        ],
      )),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
      ),
    );
  }

  _getPropertyDetail() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
            HttpLogger(logLevel: LogLevel.BODY),
          ]);

      final url = Uri.parse(BASE_URL + getPropertyDetails);

      Map<String, String> jsonBody = {
            'apiId': API_KEY,
            'user_id': sessionManager.getUserId() ?? "0",
            'property_id': (widget as PropertyDetailPage).propertyId,
            'token': sessionManager.getToken() ?? ""
          };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
            // this API passes back the id of the new item added to the body
            final body = response.body;
            Map<String, dynamic> city = jsonDecode(body);
            propertyDetailResponse = PropertyDetailResponse.fromJson(city);
            _center = LatLng(double.parse(propertyDetailResponse.property!.locationLatitude.toString()), 
                              double.parse(propertyDetailResponse.property!.locationLongitude.toString()));
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

  _markPropertyAsFavorite(PropertyDetailResponse propertyDetailResponse) async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
            HttpLogger(logLevel: LogLevel.BODY),
          ]);

      final url = Uri.parse(BASE_URL + markPropertyAsFavourite);

      Map<String, String> jsonBody = {
            'apiId': API_KEY,
            'user_id': sessionManager.getUserId() ?? "0",
            'property_id': propertyDetailResponse.property!.propertyId!,
            'token': sessionManager.getToken() ?? ""
          };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
            final body = response.body;

            Map<String, dynamic> city = jsonDecode(body);
            var commonResponse = CommonResponse.fromJson(city);
            if (commonResponse.success == 1) {
              showSnackBar(commonResponse.message, context);
              setState(() {
                propertyDetailResponse.property!.setFavourite = propertyDetailResponse.property!.isFavourite == 1 ? 0 : 1;
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
    widget is PropertyDetailPage;
  }
}
