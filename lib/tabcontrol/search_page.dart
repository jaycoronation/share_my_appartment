import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/model/property_list_response.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/widget/no_data.dart';

import '../detail.dart';
import '../network/api_end_points.dart';
import '../utils/app_utils.dart';

class SearchPage extends StatefulWidget {
  final List<Properties>? listProperties;
  const SearchPage(this.listProperties,{Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double? _width;
  String? _btnText;
  TextEditingController searchController = TextEditingController();
  List<Properties> filteredList = List.empty(growable: true);
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    _width = 100;
    _btnText = "Search";
    super.initState();
  }

  Future<void> _filterList(value) async {
    _getPropertiesBySearchText(value);
  }

  Future _pretendSearch(String searchText) async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _btnText = "";
      _width = 36;
    });
    _filterList(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              ],
            ),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: const Color(0XffEDEDEE),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 12,top: 28,right: 12,bottom: 28),
          height: double.infinity,
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                _searchBox(),
                Container(
                  height: 28,
                ),
                Flexible(
                  child: filteredList.isNotEmpty ? ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: filteredList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PropertyDetailPage(
                                    filteredList[index].propertyId!)),
                          );
                        },
                        child: Container(
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
                                child: filteredList[index].images!.isNotEmpty &&
                                    filteredList[index].images![0].image!.isNotEmpty
                                    ? FadeInImage.assetNetwork(
                                  image: filteredList[index].images![0].image!+"&w=720",
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                  placeholder:
                                  'assets/images/placeholder.png',
                                )
                                    : Image.asset('assets/images/placeholder.png',fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,),
                              ),
                              Flexible(child: Container(
                                margin: const EdgeInsets.only(left: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      toDisplayCase(filteredList[index].title!.trim().toString()),
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
                                      toDisplayCase(filteredList[index].location.toString()),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12,color: dark_gray),
                                    )
                                  ],
                                ),
                              ),flex: 1,),
                              const Divider(),
                            ],
                          ),
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),) : const MyNoDataWidget(msg: 'No search result found.'),
                  flex: 1,)
              ]
          ),
        )
    );
  }

  Widget _searchBox(){
    return Container(
        width: kIsWeb ? 450 : double.infinity,
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ active_ind,
                de_active_ind]
          ),
          /*boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],*/
        ),
        child: Row(
          children: [
            _searchField(),
            _searchBtn(),
          ],
        )
    );
  }

  Widget _searchField(){
    return Expanded(
        child: TextField(
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          textAlign: TextAlign.start,
          controller: searchController,
          cursorColor: black,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16,
            color: black,
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            hintText: "Search...",
            hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              color: black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(80.0)),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 26,
              color: black,
            ),
          ),
          enabled: true,
          onChanged: (text) {
            /*_filterList(text);*/
            if(text.isEmpty){
              setState(() {
                filteredList.clear();
              });
            }
          },
        )
    );
  }

  Widget _searchBtn(){
    return AnimatedContainer(
        width: _width,
        height: 36,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
              primary: Colors.black.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              )
          ),
          child: _btnText == "" ? _loadingBox() : _btnTextWidget(),
          onPressed: () async {
            if(searchController.text.isNotEmpty){
              await _pretendSearch(searchController.text.toString());
            }
            else{
              showSnackBar('Please enter the search keyword', context);
            }
          },
        )
    );
  }

  Widget _btnTextWidget(){
    return Text(
      _btnText.toString(),
      style: const TextStyle(
        color: Colors.white54,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _loadingBox(){
    return Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.all(0),
        child: const SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              backgroundColor: active_ind,
              valueColor: AlwaysStoppedAnimation<Color>(de_active_ind),
            )
        )
    );
  }

  _getPropertiesBySearchText(String value) async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + getPropertiesByCity);

      Map<String, String> jsonBody = {
        'apiId': API_KEY,
        'user_id': sessionManager.getUserId() ?? "0",
        'search': value,
        'token': sessionManager.getToken() ?? ""
      };

      final response = await http.post(url, body: jsonBody);

      final statusCode = response.statusCode;

      if (statusCode == 200) {
        // this API passes back the id of the new item added to the body
        final body = response.body;

        Map<String, dynamic> city = jsonDecode(body);
        PropertyListResponse propertyResponse = PropertyListResponse();
        propertyResponse = PropertyListResponse.fromJson(city);

        setState(() {
          _btnText = "Search";
          _width = 100;
        });

        if(propertyResponse.success == 1){
          setState(() {
            filteredList = propertyResponse.properties!;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}