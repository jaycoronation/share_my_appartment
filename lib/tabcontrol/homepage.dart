import 'dart:convert';
import "dart:io";
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/addproperty/property_inquiry.dart';
import 'package:share_my_appartment/listing.dart';
import 'package:share_my_appartment/model/city_response.dart';
import 'package:share_my_appartment/model/common_response.dart';
import 'package:share_my_appartment/model/property_detail_response.dart';
import 'package:share_my_appartment/model/property_list_response.dart';
import 'package:share_my_appartment/model/user_list_response.dart';
import 'package:share_my_appartment/network/api_end_points.dart';
import 'package:share_my_appartment/tabcontrol/search_page.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/view_all_cities.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:share_my_appartment/widget/no_internet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant/constants.dart';
import '../detail.dart';
import '../userprofile.dart';
import '../view_all_users.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  BaseState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
  Cities? dropdownValue = Cities();
  var propertyResponse = PropertyListResponse();
  var userListResponse = UserListResponse();
  SessionManager sessionManager = SessionManager();
  List<Cities> listCities = List<Cities>.empty(growable: true);
  bool _isToolbarLoading = false;
  bool _isMainLoading = false;
  late List nearByPages;
  PageController nearByController = PageController();

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  Widget build(BuildContext context) {
    if (!_isMainLoading && propertyResponse.properties != null) {
      nearByController = PageController(
          viewportFraction: propertyResponse.properties!.length > 1 ? 0.9 : 1,
          keepPage: false);
      nearByPages = List.generate(
          propertyResponse.properties!.length,
          (index) => InkWell(
                onTap: () async {
                  PropertyDetailResponse propertyDetailResponse =
                      await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PropertyDetailPage(
                            propertyResponse.properties![index].propertyId!)),
                  );

                  /*PropertyDetailResponse propertyDetailResponse = await Navigator.push(context,
                  WhitePageRoute(PropertyDetailPage(propertyResponse.properties![index].propertyId!)));*/

                  setState(() {
                    propertyResponse.properties![index] =
                        propertyResponse.properties!.firstWhere((item) =>
                            item.propertyId ==
                            propertyDetailResponse.property!.propertyId);
                    propertyResponse.properties![index].setFavourite =
                        propertyDetailResponse.property!.isFavourite!;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
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
                        height: 168,
                        child: Row(
                          children: [
                            Flexible(
                              child: Stack(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    elevation: 5,
                                    child: propertyResponse.properties![index]
                                            .images![0].image!.isNotEmpty
                                        ? FadeInImage.assetNetwork(
                                            image: propertyResponse
                                                    .properties![index]
                                                    .images![0]
                                                    .image! +
                                                "&w=720",
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 180,
                                            placeholder:
                                                'assets/images/placeholder.png',
                                          )
                                        : Image.asset(
                                            'assets/images/placeholder.png',
                                            fit: BoxFit.cover,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 180,
                                          ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: const ShapeDecoration(
                                            color: Colors.orangeAccent,
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
                                                  propertyResponse
                                                              .properties![
                                                                  index]
                                                              .status! ==
                                                          '1'
                                                      ? 'Available'
                                                      : 'Not Available',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                        ),
                                        const Spacer(flex: 1),
                                        const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        Container(
                                          width: 2,
                                        ),
                                        Text(
                                          propertyResponse
                                              .properties![index].rateings!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              flex: 1,
                            ),
                            Container(
                              decoration: const ShapeDecoration(
                                  color: Color(0XFFB1E2F9),
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
                                      onTap: () {
                                        _markPropertyAsFavorite(
                                            propertyResponse
                                                .properties![index].propertyId!,
                                            propertyResponse.properties,
                                            index);
                                      },
                                      child: Column(
                                        children: [
                                          propertyResponse.properties![index]
                                                      .isFavourite! ==
                                                  1
                                              ? const Icon(
                                                  Icons.favorite_rounded,
                                                  size: 20)
                                              : const Icon(
                                                  Icons.favorite_border_rounded,
                                                  size: 20),
                                          const Text(
                                            'Favourite',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )),
                                  const Spacer(flex: 1),
                                  InkWell(
                                    onTap: () async {
                                      //share code here
                                      final uri = Uri.parse(propertyResponse
                                              .properties![index]
                                              .images![0]
                                              .image
                                              .toString() +
                                          "&w=720");
                                      final response = await http.get(uri);
                                      final bytes = response.bodyBytes;
                                      final temp =
                                          await getTemporaryDirectory();
                                      final path = '${temp.path}/image.jpg';
                                      File(path).writeAsBytesSync(bytes);

                                      shareFileWithText(
                                          "Hey! Please visit the below property on share my apartment.\n",
                                          toDisplayCase(propertyResponse
                                                  .properties![index].title
                                                  .toString()) +
                                              "\n\n" +
                                              propertyResponse
                                                  .properties![index].location
                                                  .toString(),
                                          path);
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(Icons.share_outlined, size: 20),
                                        Text('Share',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black))
                                      ],
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PropertyInquiry(
                                                    propertyResponse
                                                        .properties![index]
                                                        .title!,
                                                    propertyResponse
                                                        .properties![index]
                                                        .propertyId!)),
                                      );
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(Icons.bookmark_border_outlined,
                                            size: 20),
                                        Text('Book Now!',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black))
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
                        padding:
                            const EdgeInsets.only(left: 6, top: 8, right: 8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '₹${propertyResponse.properties![index].price!}',
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
                              height: 4,
                            ),
                            Center(
                              child: Center(
                                child: Row(
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
                                        toDisplayCase(propertyResponse
                                                .properties![index].location! +
                                            '\n'),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: dark_text,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                        softWrap: true,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        propertyResponse.properties![index]
                                                    .beds!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .beds! !=
                                                    "0"
                                            ? const Icon(Icons.bed_outlined,
                                                size: 18,
                                                color: Colors.orangeAccent)
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .beds!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .beds! !=
                                                    "0"
                                            ? Container(
                                                width: 5,
                                              )
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .beds!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .beds! !=
                                                    "0"
                                            ? Text(
                                                propertyResponse
                                                    .properties![index].beds!,
                                                style: const TextStyle(
                                                    color: dark_text,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .bathrooms!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .bathrooms! !=
                                                    "0"
                                            ? Container(
                                                width: 3,
                                                height: 3,
                                                margin: const EdgeInsets.only(
                                                    left: 4, right: 4),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black54,
                                                ),
                                              )
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .bathrooms!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .bathrooms! !=
                                                    "0"
                                            ? const Icon(Icons.bathtub_outlined,
                                                size: 18,
                                                color: Colors.orangeAccent)
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .bathrooms!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .bathrooms! !=
                                                    "0"
                                            ? Container(
                                                width: 5,
                                              )
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .bathrooms!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .bathrooms! !=
                                                    "0"
                                            ? Text(
                                                propertyResponse
                                                    .properties![index]
                                                    .bathrooms!,
                                                style: const TextStyle(
                                                    color: dark_text,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .balcony!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .balcony! !=
                                                    "0"
                                            ? Container(
                                                width: 3,
                                                height: 3,
                                                margin: const EdgeInsets.only(
                                                    left: 4, right: 4),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black54,
                                                ),
                                              )
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .balcony!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .balcony! !=
                                                    "0"
                                            ? const Icon(Icons.home_outlined,
                                                size: 18,
                                                color: Colors.orangeAccent)
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .balcony!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .balcony! !=
                                                    "0"
                                            ? Container(
                                                width: 5,
                                              )
                                            : Container(),
                                        propertyResponse.properties![index]
                                                    .balcony!.isNotEmpty &&
                                                propertyResponse
                                                        .properties![index]
                                                        .balcony! !=
                                                    "0"
                                            ? Text(
                                                propertyResponse
                                                    .properties![index]
                                                    .balcony!,
                                                style: const TextStyle(
                                                    color: dark_text,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    flex: 1,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Looking for: ',
                                        style: TextStyle(
                                            color: dark_text,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        toDisplayCase(propertyResponse
                                            .properties![index].lookingFor!),
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
              ));
    }
    return Scaffold(
        backgroundColor: const Color(0XffEDEDEE),
        body: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedContainer(
                height: _showAppbar ? 64.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: AppBar(
                  toolbarHeight: 70,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 38,
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                          child: isOnline
                              ? _isToolbarLoading
                                  ? SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Lottie.asset(
                                          'assets/images/loading_animation.json',
                                          repeat: true,
                                          animate: true,
                                          frameRate: FrameRate.max),
                                    )
                                  : DropdownButton<Cities>(
                                      value: dropdownValue,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      isDense: true,
                                      isExpanded: true,
                                      style: GoogleFonts.nunito(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: black),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      underline: const SizedBox.shrink(),
                                      onChanged: (Cities? newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                          sessionManager.setCityId(
                                              dropdownValue!.cityId!);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PropertyListingPage(
                                                        dropdownValue!.cityId!,
                                                        dropdownValue!.name!,
                                                        listCities)),
                                          );
                                        });
                                      },
                                      items: listCities
                                          .map<DropdownMenuItem<Cities>>(
                                              (Cities value) {
                                        return DropdownMenuItem<Cities>(
                                          value: value,
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: Text(value.name!),
                                        );
                                      }).toList(),
                                    )
                              : Container(),
                        )
                      ],
                    ),
                  ),
                  centerTitle: false,
                  elevation: 0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        child: Container(
                          width: 70,
                          height: 70,
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100,
                            child: Stack(children: const [
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white70,
                                  child: Icon(
                                    Icons.search_rounded,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(propertyResponse.properties)),
                          );
                        },
                      ),
                    ),
                  ],
                  backgroundColor: const Color(0XffEDEDEE),
                )),
            Expanded(
                child: isOnline
                    ? _isMainLoading
                        ? const LoadingWidget()
                        : SingleChildScrollView(
                            controller: _scrollViewController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 18, top: 0, right: 18),
                                      child: Text("Share\nAccommodation",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 18, top: 18, right: 18),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Explore cities',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(flex: 1),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewAllCities(listCities)),
                                          );
                                        },
                                        child: Row(
                                          children: const [
                                            Text('View all',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: dark_text,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 12,
                                              color: dark_text,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            left: 16,
                                            right: 8,
                                            bottom: 18),
                                        child: SizedBox(
                                            height: 130,
                                            child: _explorecities(
                                                listCities.length)))
                                  ],
                                ),
                                propertyResponse.properties != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 18, top: 0, right: 18),
                                            child: Text("Near by properties",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          propertyResponse.properties != null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 18,
                                                          left: 8,
                                                          right: 8,
                                                          bottom: 18),
                                                  child: SizedBox(
                                                      height: 295,
                                                      child: PageView.builder(
                                                        controller:
                                                            nearByController,
                                                        padEnds: false,
                                                        itemCount:
                                                            propertyResponse
                                                                .properties!
                                                                .length,
                                                        itemBuilder:
                                                            (_, index) {
                                                          return nearByPages[
                                                              index %
                                                                  nearByPages
                                                                      .length];
                                                        },
                                                      )))
                                              : Container(),
                                          propertyResponse.properties != null &&
                                                  propertyResponse
                                                          .properties!.length >
                                                      1
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets.only(
                                                      top: 15, bottom: 15),
                                                  child: SmoothPageIndicator(
                                                    controller:
                                                        nearByController,
                                                    count: nearByPages.length,
                                                    effect: const WormEffect(
                                                      dotHeight: 7,
                                                      dotWidth: 7,
                                                      type: WormType.thin,
                                                      activeDotColor:
                                                          active_ind,
                                                      dotColor: de_active_ind,
                                                      // strokeWidth: 5,
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      )
                                    : Container(),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 18, top: 18, right: 18),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Looking for houses/appartments',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(flex: 1),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewAllUsers(
                                                        userListResponse
                                                            .users)),
                                          );
                                        },
                                        child: Row(
                                          children: const [
                                            Text('View all',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black38,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 12)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            left: 8,
                                            right: 8,
                                            bottom: 18),
                                        child: SizedBox(
                                            height: 220,
                                            child: _lookingforhouse(
                                                userListResponse
                                                    .users!.length)))
                                  ],
                                ),
                              ],
                            ),
                          )
                    : const NoInternetWidget())
          ],
        )));
  }

  _callInitApiCall() async {
    await _getAllCities();
    await _getPropertiesByCity();
    await _getUserList();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isToolbarLoading = true;
      _isMainLoading = true;
    });

    if (isOnline && propertyResponse.success == null) {
      _callInitApiCall();
    }

    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  ListView _explorecities(int n) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: n,
        itemBuilder: (ctx, i) => (InkWell(
              onTap: () async {
                PropertyListResponse propertyListResponse =
                    await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PropertyListingPage(
                          listCities[i].cityId!,
                          listCities[i].name!,
                          listCities)),
                );
                setState(() {
                  if (propertyListResponse.success != 0) {
                    for (var i = 0;
                        i < propertyResponse.properties!.length;
                        i++) {
                      for (var j = 0;
                          j < propertyListResponse.properties!.length;
                          j++) {
                        if (propertyResponse.properties![i].propertyId! ==
                            propertyListResponse.properties![j].propertyId!) {
                          propertyResponse.properties![i].setFavourite =
                              propertyListResponse.properties![j].isFavourite!;
                        }
                      }
                    }
                  }
                });
              },
              child: Column(
                children: [
                  SizedBox(
                      width: 110,
                      height: 100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: ShapeDecoration(
                            color: createMaterialColor(Color(int.parse(
                                    listCities[i]
                                        .background!
                                        .replaceAll('#', '0xff'))))
                                .withOpacity(0.3),
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(style: BorderStyle.none),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            )),
                        child: Center(
                            child: listCities[i].icon!.isNotEmpty
                                ? Image.network(listCities[i].icon! + '&w=198',
                                    fit: BoxFit.contain, width: 60, height: 60)
                                : Image.asset(
                                    'assets/images/building.png',
                                    fit: BoxFit.cover,
                                    width: 50,
                                    color: Colors.transparent,
                                    height: 50,
                                  )),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(toDisplayCase(listCities[i].name!),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)))
                ],
              ),
            )));
  }

  ListView _lookingforhouse(int n) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: n,
        itemBuilder: (ctx, i) => (Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
              decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  )),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfilePage(
                            userListResponse.users![i].userId!)),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 5,
                        child: userListResponse.users![i].profilePic!.isNotEmpty
                            ? FadeInImage.assetNetwork(
                                image: userListResponse.users![i].profilePic! +
                                    "&w=720",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                                placeholder: 'assets/images/placeholder.png',
                              )
                            : Image.asset(
                                'assets/images/placeholder.png',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 150,
                              ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8, left: 8),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  toDisplayCase(
                                      userListResponse.users![i].name!),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                ),
                                Container(
                                  height: 3,
                                ),
                                Text(
                                  toDisplayCase(
                                      userListResponse.users![i].distance! +
                                          ' away'),
                                  style: const TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.favorite_border,
                              size: 20,
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

  GridView _liveAnywhere(int n) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (ctx, i) => (Column(
        children: [
          SizedBox(
              width: 270,
              height: 95,
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                decoration: ShapeDecoration(
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.3),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    )),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 0,
                        child: FadeInImage.assetNetwork(
                          image:
                              'https://upload.wikimedia.org/wikipedia/commons/d/d6/George_L._Burlingame_House%2C_1238_Harvard_St%2C_Houston_%28HDR%29.jpg',
                          fit: BoxFit.cover,
                          height: 70,
                          width: 70,
                          placeholder: 'assets/images/placeholder.png',
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Entire Home',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                          Container(
                            height: 3,
                          ),
                          const Text(
                            '300+ stays',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      )),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.4),
    );
  }

  ListView _createListing(int n) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: n,
        itemBuilder: (ctx, i) => (Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: const EdgeInsets.symmetric(horizontal: 6.0),
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
                  Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.zero,
                      semanticContainer: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)),
                      ),
                      child: FadeInImage.assetNetwork(
                        image:
                            'https://www.hnsafal.com/wp-content/uploads/2019/04/iview2-3.jpg',
                        fit: BoxFit.cover,
                        height: 150,
                        placeholder: 'assets/images/placeholder.png',
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 8, left: 8),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Want to',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11),
                            ),
                            const Text(
                              'Share My Apartment',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 3,
                            ),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  _getAllCities() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + getAllCity);

      Map<String, String> jsonBody = {
        'apiId': API_KEY,
        'user_id': sessionManager.getUserId() ?? "0",
        'is_mega_city': '1',
        'token': sessionManager.getToken() ?? ""
      };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        // this API passes back the id of the new item added to the body
        final body = response.body;

        Map<String, dynamic> city = jsonDecode(body);
        var cityResponse = CityResponse.fromJson(city);
        if (cityResponse.success == 1) {
          listCities = cityResponse.cities!;
          dropdownValue = listCities[0];
          sessionManager.setCityId(dropdownValue!.cityId!);
          setState(() {
            _isToolbarLoading = false;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _getPropertiesByCity() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + getPropertiesByCity);

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
      propertyResponse = PropertyListResponse();
      propertyResponse = PropertyListResponse.fromJson(city);
    }
  }

  _getUserList() async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + getUserList);

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
      userListResponse = UserListResponse.fromJson(city);
      if (userListResponse.success == 1) {
        setState(() {
          _isMainLoading = false;
        });
      }
    }
  }

  _markPropertyAsFavorite(
      String propertyId, List<Properties>? properties, int index) async {
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

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        // this API passes back the id of the new item added to the body
        final body = response.body;

        Map<String, dynamic> city = jsonDecode(body);
        var commonResponse = CommonResponse.fromJson(city);
        if (commonResponse.success == 1) {
          showSnackBar(commonResponse.message, context);
          setState(() {
            properties![index].setFavourite =
                properties[index].isFavourite == 1 ? 0 : 1;
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
    widget is MyHomePage;
  }
}
