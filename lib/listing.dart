import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/detail.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/loading.dart';
import 'package:share_my_appartment/widget/no_data.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'addproperty/property_inquiry.dart';
import 'constant/constants.dart';
import 'model/city_response.dart';
import 'model/common_response.dart';
import 'model/property_detail_response.dart';
import 'model/property_list_response.dart';
import 'model/property_type_response.dart';
import 'network/api_end_points.dart';

class PropertyListingPage extends StatefulWidget {
  final String cityId;
  final String cityName;
  final List<Cities> listCities;

  const PropertyListingPage(this.cityId, this.cityName,this.listCities, {Key? key})
      : super(key: key);

  @override
  BaseState<PropertyListingPage> createState() => _PropertyListingPageState();
}

class _PropertyListingPageState extends BaseState<PropertyListingPage> {
  List<Types>? listPropertyTypes;
  bool visibileByCities = true;
  bool visibleByTypes = false;
  bool isViewOnMap = false;
  SessionManager sessionManager = SessionManager();
  var propertyResponse = PropertyListResponse();
  bool _isMainLoading = false;

  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  final Set<Polygon> _polyline = {};
  Set<Circle> _circles = {};

  //add your lat and lng where you wants to draw polyline
  List<LatLng> latlng = List<LatLng>.empty(growable: true);
  late LatLng _data1 ;
  late LatLng _center ;
  late Uint8List markerIcon;
  List<Uint8List> markerIcon1 = List<Uint8List>.empty(growable: true);

  String strCityName = "";

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "city") {
        visibileByCities = visibility;
        visibleByTypes = false;
      }
      if (field == "type") {
        visibleByTypes = visibility;
        visibileByCities = false;
      }
    });
  }

  void _isViewOnMap(bool viewonMap) {
    setState(() {
      isViewOnMap = viewonMap;
    });
  }

  Future<void> generateCustomMarker()  async {
    markerIcon1.clear();
    for(int i=0;i<propertyResponse.properties!.length;i++){
      getBytesFromCanvas(propertyResponse.properties![i].price.toString(), 250, 100).then((value) {
        setState(() {
          markerIcon1.add(value);
        });
      });
    }
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    latlng.clear();
    markers.clear();
    for(int i = 0;i<propertyResponse.properties!.length;i++){
      if(propertyResponse.properties![i].locationLatitude.toString().isNotEmpty &&
          propertyResponse.properties![i].locationLongitude.toString().isNotEmpty)
        {
          _data1 = LatLng(double.parse(propertyResponse.properties![i].locationLatitude.toString()),
              double.parse(propertyResponse.properties![i].locationLongitude.toString()));
          latlng.add(_data1);
        }
    }
    setState(() {
      for(int i = 0;i<propertyResponse.properties!.length;i++){
        markers.add(Marker(
          //add first marker
          markerId: MarkerId(propertyResponse.properties![i].propertyId.toString()),
          position: LatLng(double.parse(propertyResponse.properties![i].locationLatitude.toString()),
              double.parse(propertyResponse.properties![i].locationLongitude.toString())),
          infoWindow: InfoWindow(
            //popup info
              title: propertyResponse.properties![i].title.toString(),
              snippet: propertyResponse.properties![i].location.toString(),
              onTap: () {
                openMap(double.parse(propertyResponse.properties![i].locationLatitude.toString()),
                        double.parse(propertyResponse.properties![i].locationLongitude.toString()));
              }),
          icon: BitmapDescriptor.fromBytes(markerIcon1[i]), //Icon for Marker
        ));
      }

      _polyline.add(Polygon(
        polygonId: const PolygonId("Property"),
        visible: true,
        fillColor: Colors.transparent,
        strokeColor: Colors.redAccent,
        strokeWidth: 2,
        geodesic: true,
        points: latlng,
      ));
      _circles = {
        Circle(
          circleId: const CircleId("Property"),
          visible: true,
          fillColor: dark_orange.withOpacity(0.4),
          strokeColor: dark_orange,
          strokeWidth: 2,
          radius: 800,
        )
      };
      //add more markers here
    });

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: const Color(0XffEDEDEE),
          body: isOnline
              ? _isMainLoading
                  ? const LoadingWidget()
                  : SafeArea(child: Column(
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                          Navigator.pop(context, propertyResponse);
                                        },
                                      ),
                                    )),
                                Container(
                                  width: 8,
                                ),
                                Text(toDisplayCase(strCityName),
                                    style: const TextStyle(
                                        color: Color(0Xff5E6877),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    _isViewOnMap(isViewOnMap ? false : true);
                                  },
                                  child: Text(isViewOnMap ? 'View List' : 'View on Map',
                                      style: const TextStyle(
                                          color: Color(0Xff5E6877),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                IconButton(
                                    icon: const Icon(Icons.filter_list_rounded,
                                        size: 25, color: Color(0Xff5E6877)),
                                    onPressed: () {
                                      visibileByCities == true
                                          ? _changed(true, 'type')
                                          : _changed(true, 'city');
                                    }),
                              ],
                            ),
                          ),
                          centerTitle: false,
                          elevation: 0,
                          backgroundColor: const Color(0XffEDEDEE),
                        )),
                    Expanded(child: SingleChildScrollView(
                      controller: _scrollViewController,
                      child: Column(
                        children: [
                          visibileByCities
                              ? Padding(padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                              child: SizedBox(height: 52, child: _filterbycities((widget as PropertyListingPage).listCities.length)))
                              : Container(),
                          visibleByTypes
                              ? Padding(padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                              child: SizedBox(height: 80, child: _filterByTypes(listPropertyTypes!.length)))
                              : Container(),
                          isViewOnMap
                              ? propertyResponse.success == 0 ? const MyNoDataWidget(msg: 'No property found.') : Container(
                            margin: const EdgeInsets.only(top: 12),
                            height: MediaQuery.of(context).size.height,
                            child: GoogleMap(
                              //Map widget from google_maps_flutter package
                              myLocationButtonEnabled: false,
                              mapToolbarEnabled: false,
                              zoomControlsEnabled: false,
                              //enable Zoom in, out on map
                              initialCameraPosition: CameraPosition(
                                //innital position in map
                                target: _center, //initial position
                                zoom: 15.0, //initial zoom level
                              ),
                              circles: _circles,
                              markers: getmarkers(),
                              //markers to show on map
                              mapType: MapType.normal,
                              //map type
                              onMapCreated: (controller) {
                                //method called when map is created
                                setState(() {
                                  mapController = controller;
                                });
                              },
                              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>> {
                                Factory <OneSequenceGestureRecognizer> (
                                        () => EagerGestureRecognizer(),
                                  ),
                                }
                            ),
                          )
                              : propertyResponse.success == 0 ? const MyNoDataWidget(msg: 'No property found.') : Wrap(
                            children: [
                              _nearbypropertieslisting(propertyResponse.properties!.length)
                            ],
                          )
                        ],
                      ),
                    ))
                  ],
          ))
              : SafeArea(child: Column(
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    Navigator.pop(context, propertyResponse);
                                  },
                                ),
                              )),
                          Container(
                            width: 8,
                          ),
                          Text(toDisplayCase(strCityName),
                              style: const TextStyle(
                                  color: Color(0Xff5E6877),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              _isViewOnMap(isViewOnMap ? false : true);
                            },
                            child: Text(isViewOnMap ? 'View List' : 'View on Map',
                                style: const TextStyle(
                                    color: Color(0Xff5E6877),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                          IconButton(
                              icon: const Icon(Icons.filter_list_rounded,
                                  size: 25, color: Color(0Xff5E6877)),
                              onPressed: () {
                                visibileByCities == true
                                    ? _changed(true, 'type')
                                    : _changed(true, 'city');
                              }),
                        ],
                      ),
                    ),
                    centerTitle: false,
                    elevation: 0,
                    backgroundColor: const Color(0XffEDEDEE),
                  )),
              Expanded(child: SingleChildScrollView(
                controller: _scrollViewController,
                child: Column(
                  children: [
                    visibileByCities
                        ? Padding(padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                        child: SizedBox(height: 52, child: _filterbycities((widget as PropertyListingPage).listCities.length)))
                        : Container(),
                    visibleByTypes
                        ? Padding(padding: const EdgeInsets.only(top: 18, left: 8, right: 8),
                        child: SizedBox(height: 80, child: _filterByTypes(listPropertyTypes!.length)))
                        : Container(),
                    isViewOnMap
                        ? propertyResponse.success == 0 ? const MyNoDataWidget(msg: 'No property found.') : Container(
                      margin: const EdgeInsets.only(top: 12),
                      height: MediaQuery.of(context).size.height,
                      child: GoogleMap(
                        //Map widget from google_maps_flutter package
                        myLocationButtonEnabled: false,
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        //enable Zoom in, out on map
                        initialCameraPosition: CameraPosition(
                          //innital position in map
                          target: _center, //initial position
                          zoom: 15.0, //initial zoom level
                        ),
                        circles: _circles,
                        markers: getmarkers(),
                        //markers to show on map
                        mapType: MapType.normal,
                        //map type
                        onMapCreated: (controller) {
                          //method called when map is created
                          setState(() {
                            mapController = controller;
                          });
                        },
                        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>> {
                            Factory <OneSequenceGestureRecognizer> (
                                  () => EagerGestureRecognizer(),
                            ),
                          }
                      ),
                    )
                        : propertyResponse.success == 0 ? const MyNoDataWidget(msg: 'No property found.') : Wrap(
                      children: [
                        _nearbypropertieslisting(propertyResponse.properties!.length)
                      ],
                    )
                  ],
                ),
              ))
            ],
          )) ,
        ),
        onWillPop: () {
          Navigator.pop(context, propertyResponse);
          return Future.value(true);
        });
  }

  @override
  void initState() {
    super.initState();
    strCityName = (widget as PropertyListingPage).cityName;
    setState(() {
      _isMainLoading = true;
    });

    for(int i=0;i<(widget as PropertyListingPage).listCities.length;i++){
      if((widget as PropertyListingPage).cityId == (widget as PropertyListingPage).listCities[i].cityId){
        _selectedCityIndex = i;
        break;
      }
    }

    _getAllPropertyTypes();

    if (isOnline && propertyResponse.success == null) {
      _getPropertiesByCity((widget as PropertyListingPage).cityId);
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

  int _selectedCityIndex = 0;
  _onSelected(int index) {
    setState(() {
      _selectedCityIndex = index;
      strCityName = (widget as PropertyListingPage).listCities[index].name.toString();
    });

    setState(() {
      _isMainLoading = true;
    });

    _isViewOnMap(false);

    _getPropertiesByCity((widget as PropertyListingPage).listCities[index].cityId.toString());
  }

  int _selectedPropertyTypeIndex = 0;
  _onSelectedPropertyType(int index){
    setState(() {
      _selectedPropertyTypeIndex = index;
    });

    setState(() {
      _isMainLoading = true;
    });

    _isViewOnMap(false);

    _getPropertiesByPropertyType(listPropertyTypes![index].propertyTypeId.toString());

  }

  ListView _filterbycities(int n) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: n,
        itemBuilder: (ctx, i) => (Column(
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      _onSelected(i);
                    },
                    child: _selectedCityIndex == i
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: const ShapeDecoration(
                              color: Color(0Xff5E6877),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(style: BorderStyle.none),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Text((widget as PropertyListingPage).listCities[i].name.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Text((widget as PropertyListingPage).listCities[i].name.toString(),
                                    style: const TextStyle(
                                        color: Color(0Xff5E6877),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                          ),
                  ),
                ),
              ],
            )));
  }

  ListView _filterByTypes(int n) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: n,
        itemBuilder: (ctx, i) => (Column(
              children: [
                Center(
                  child: InkWell(onTap: () {
                      _onSelectedPropertyType(i);
                    },
                    child: _selectedPropertyTypeIndex == i
                        ? Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Center(
                              child: Column(
                                children: [
                                  ColorFiltered(colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),child: FadeInImage.assetNetwork(
                                    image: listPropertyTypes![i].icon!,
                                    width: 24,
                                    height: 24,
                                    placeholder: 'assets/images/placeholder.png',
                                  ),),
                                  Container(
                                    height: 3,
                                  ),
                                  Text(toDisplayCase(listPropertyTypes![i].type.toString()),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300))
                                ],
                              ),
                            ),
                            decoration: const ShapeDecoration(
                              color: Color(0Xff5E6877),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(style: BorderStyle.none),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: const Color(0Xff5E6877)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: Center(
                              child: Column(
                                children: [
                                  ColorFiltered(colorFilter: const ColorFilter.mode(Color(0Xff5E6877), BlendMode.srcATop),child: FadeInImage.assetNetwork(
                                    image: listPropertyTypes![i].icon!,
                                    width: 24,
                                    height: 24,
                                    placeholder: 'assets/images/placeholder.png',
                                  ),),
                                  Container(
                                    height: 3,
                                  ),
                                  Text(toDisplayCase(listPropertyTypes![i].type.toString()),
                                      style: const TextStyle(
                                          color: Color(0Xff5E6877),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300))
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            )));
  }

  ListView _nearbypropertieslisting(int n) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: n,
        itemBuilder: (ctx, index) => (InkWell(
              onTap: () async {
                PropertyDetailResponse propertyDetailResponse =
                    await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PropertyDetailPage(
                          propertyResponse.properties![index].propertyId!)),
                );

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
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
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
                                  child: propertyResponse.properties![index]
                                          .images![0].image!.isNotEmpty
                                      ? FadeInImage.assetNetwork(
                                          image: propertyResponse
                                                  .properties![index]
                                                  .images![0]
                                                  .image! +
                                              "&w=720",
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 230,
                                          placeholder:
                                              'assets/images/placeholder.png',
                                        )
                                      : Image.asset(
                                          'assets/images/placeholder.png',
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context).size.width,
                                          height: 230,
                                        ),
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
                                                            .properties![index]
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
                                            color: Colors.white, fontSize: 12),
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
                                  onTap: () {
                                    _markPropertyAsFavorite(
                                        propertyResponse
                                            .properties![index].propertyId!,
                                        propertyResponse.properties,
                                        index);
                                  },
                                  child: Column(
                                    children: [
                                      propertyResponse.properties![index].isFavourite! == 1
                                          ? const Icon(
                                        Icons.favorite_rounded,
                                        size: 20,
                                        color: Color(0XFF723B23),
                                      )
                                          : const Icon(
                                        Icons.favorite_border_rounded,
                                        size: 20,
                                        color: Color(0XFF723B23),
                                      ),
                                      const Text(
                                        'Favourite',
                                        style: TextStyle(
                                            fontSize: 10, color: Color(0XFF723B23)),
                                      ),
                                    ],
                                  )
                                ),
                                const Spacer(flex: 1),
                                InkWell(
                                  onTap: () async {
                                    //share code here
                                    final uri = Uri.parse(propertyResponse.properties![index].images![0].image.toString()+"&w=720");
                                    final response = await http.get(uri);
                                    final bytes = response.bodyBytes;
                                    final temp = await getTemporaryDirectory();
                                    final path = '${temp.path}/image.jpg';
                                    File(path).writeAsBytesSync(bytes);

                                    shareFileWithText("Hey! Please visit the below property on share my apartment.\n",
                                        toDisplayCase(propertyResponse.properties![index].title.toString()) + "\n\n" + propertyResponse.properties![index].location.toString(),
                                        path);
                                  },
                                  child: Column(
                                    children: const [
                                      Icon(Icons.share_outlined,
                                          size: 20, color: Color(0XFF723B23)),
                                      Text('Share',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0XFF723B23)))
                                    ],
                                  ),
                                ),
                                const Spacer(flex: 1),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PropertyInquiry(propertyResponse.properties![index].title!,
                                              propertyResponse.properties![index].propertyId!)),
                                    );
                                  },
                                  child: Column(
                                    children: const [
                                      Icon(Icons.bookmark_border_outlined,
                                          size: 20, color: Color(0XFF723B23)),
                                      Text('Book Now!',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Color(0XFF723B23)))
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
                            margin: const EdgeInsets.only(top: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 18, color: Colors.orangeAccent),
                                Flexible(child: Text(
                                  toDisplayCase(propertyResponse
                                      .properties![index].location!),
                                  softWrap: true,
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
                                      const Icon(Icons.bed_outlined,
                                          size: 18, color: Colors.orangeAccent),
                                      Container(
                                        width: 5,
                                      ),
                                      Text(
                                        propertyResponse
                                            .properties![index].beds!,
                                        style: const TextStyle(
                                            color: dark_text,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        width: 3,
                                        height: 3,
                                        margin: const EdgeInsets.only(
                                            left: 4, right: 4),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const Icon(Icons.bathtub_outlined,
                                          size: 18, color: Colors.orangeAccent),
                                      Container(
                                        width: 5,
                                      ),
                                      Text(
                                        propertyResponse
                                            .properties![index].bathrooms!,
                                        style: const TextStyle(
                                            color: dark_text,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        width: 3,
                                        height: 3,
                                        margin: const EdgeInsets.only(
                                            left: 4, right: 4),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      const Icon(Icons.home_outlined,
                                          size: 18, color: Colors.orangeAccent),
                                      Container(
                                        width: 5,
                                      ),
                                      Text(
                                        propertyResponse
                                            .properties![index].balcony!,
                                        style: const TextStyle(
                                            color: dark_text,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
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
            )));
  }

  _getAllPropertyTypes() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + getPropertyTypes);

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

        Map<String, dynamic> propertyType = jsonDecode(body);
        var propertyTypeResponse = PropertyTypeResponse.fromJson(propertyType);
        if (propertyTypeResponse.success == 1) {
          listPropertyTypes = propertyTypeResponse.types;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _getPropertiesByCity(String cityId) async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + getPropertiesByCity);

      Map<String, String> jsonBody = {
        'apiId': API_KEY,
        'user_id': sessionManager.getUserId() ?? "0",
        'city_id': cityId,
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

        if(propertyResponse.success == 1){
          _center = LatLng(double.parse(propertyResponse.properties![0].locationLatitude.toString()),
              double.parse(propertyResponse.properties![0].locationLongitude.toString()));
          generateCustomMarker();
        }

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

  _getPropertiesByPropertyType(String propertyTypeId) async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + getPropertiesByCity);

      Map<String, String> jsonBody = {
        'apiId': API_KEY,
        'user_id': sessionManager.getUserId() ?? "0",
        'property_type_id': propertyTypeId,
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

        if(propertyResponse.success == 1){
          _center = LatLng(double.parse(propertyResponse.properties![0].locationLatitude.toString()),
              double.parse(propertyResponse.properties![0].locationLongitude.toString()));
          generateCustomMarker();
        }

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
    widget is PropertyListingPage;
  }
}
