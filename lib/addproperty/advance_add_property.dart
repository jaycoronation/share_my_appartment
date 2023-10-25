import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/model/amenities_type_response.dart';
import 'package:share_my_appartment/model/property_save_response.dart';
import 'package:share_my_appartment/model/property_type_response.dart';
import 'package:share_my_appartment/model/user_preference_response.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/widget/loading.dart';

import '../model/amenities_type_response.dart' as amen;
import '../model/property_list_response.dart';
import '../network/api_end_points.dart';
import '../utils/session_manager.dart';

class AdvanceAddProperty extends StatefulWidget {
  final String propertyTypeId , propertyTitle, propertyLocation, propertyRent, lookingFor,
      propertyLat, propertyLng, propertyAvailableFrom;
  final Properties propertyData;
  final bool isFromEdit;
  const AdvanceAddProperty(this.propertyTypeId, this.propertyTitle, this.propertyLocation,
                          this.propertyRent, this.lookingFor, this.propertyLat, this.propertyLng,
                          this.propertyAvailableFrom, this.propertyData,this.isFromEdit,{Key? key}) : super(key: key);

  @override
  _AdvanceAddPropertyState createState() => _AdvanceAddPropertyState();
}

class _AdvanceAddPropertyState extends BaseState<AdvanceAddProperty> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  List<amen.Aminities> listAmenities = List<amen.Aminities>.empty(growable: true);
  List<UserPreferancesTypes> listUserPreferences = List<UserPreferancesTypes>.empty(growable: true);
  SessionManager sessionManager = SessionManager();
  Types? dropdownValue = Types();
  bool _isMainLoading = false;
  var strBedRoom = "", strBathroom = "", strBalcony = "" , strFlatMates = "" , strAbout = "",
  strFurnishing = "Semi Furnished", strInternet = "" , strParking = "",strRemovedImagesId = "";

  TextEditingController bedController = TextEditingController();
  TextEditingController bathController = TextEditingController();
  TextEditingController balconyController = TextEditingController();
  TextEditingController flatmateController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  int defaultChoiceIndex = 0;
  final List<String> _choicesList = ['Semi Furnished', 'Furnished'];

  bool isInternetChecked = false, isParkingChecked = false;
  List<String> selectedChoices = List<String>.empty(growable: true);

  List<String> propertyImages = List<String>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: bg_color,
        body: _isMainLoading
            ? const LoadingWidget()
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          width: 52,
                          height: 52,
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: light_gray,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: black,
                                size: 24,
                              ),
                              onPressed: () {
                                SystemChannels.textInput.invokeMethod('TextInput.hide');
                                Navigator.of(context).pop(false);
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(top: 32),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text((widget as AdvanceAddProperty).isFromEdit ? "UPDATE PROPERTY" :"ADD PROPERTY",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12)),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: const Text("Advance Details",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ),
                              Container(
                                height: 20,
                              ),
                              const Text(
                                'Bedroom',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: dark_text),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(28))),
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    cursorColor: black,
                                    controller: bedController,
                                    textInputAction: TextInputAction.next,
                                    maxLength: 2,
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: 'No. of Bedroom(s)',
                                        hintStyle: TextStyle(
                                          color: dark_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ))),
                              ),
                              Container(
                                height: 26,
                              ),
                              const Text(
                                'Bathroom',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: dark_text),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(28))),
                                child: TextField(
                                    enabled: true,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    cursorColor: black,
                                    controller: bathController,
                                    textInputAction: TextInputAction.next,
                                    maxLength: 2,
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: 'No. of Bathroom(s)',
                                        hintStyle: TextStyle(
                                          color: dark_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ))),
                              ),
                              Container(
                                height: 26,
                              ),
                              const Text(
                                'Balcony',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: dark_text),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(28))),
                                child: TextField(
                                    enabled: true,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    cursorColor: black,
                                    controller: balconyController,
                                    textInputAction: TextInputAction.next,
                                    maxLength: 2,
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: 'No. of Balcony',
                                        hintStyle: TextStyle(
                                          color: dark_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ))),
                              ),
                              Container(
                                height: 26,
                              ),
                              const Text(
                                'Flatmates',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: dark_text),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(28))),
                                child: TextField(
                                    enabled: true,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    cursorColor: black,
                                    controller: flatmateController,
                                    textInputAction: TextInputAction.next,
                                    maxLength: 2,
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: 'No. of Flatmates',
                                        hintStyle: TextStyle(
                                          color: dark_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ))),
                              ),
                              Container(
                                height: 26,
                              ),
                              const Text(
                                'About Property',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: dark_text),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(28))),
                                child: TextField(
                                    enabled: true,
                                    keyboardType: TextInputType.multiline,
                                    cursorColor: black,
                                    controller: aboutController,
                                    textInputAction: TextInputAction.done,
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: 'Description about property',
                                        hintStyle: TextStyle(
                                          color: dark_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        ))),
                              ),
                              Container(
                                height: 12,
                              ),
                              CheckboxListTile(
                                title: Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child:const Text("Internet")),
                                subtitle: Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child:const Text("Do you provide internet connection?")),
                                checkColor: white,
                                contentPadding: EdgeInsets.zero,
                                value: isInternetChecked,
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isInternetChecked = value!;
                                  });
                                },
                              ),
                              Container(
                                height: 0,
                              ),
                              CheckboxListTile(
                                title: Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child:const Text("Parking")),
                                subtitle: Transform.translate(
                                    offset: const Offset(-10, 0),
                                    child:const Text("Do you have parking?")),
                                checkColor: white,
                                contentPadding: EdgeInsets.zero,
                                value: isParkingChecked,
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isParkingChecked = value!;
                                  });
                                },
                              ),
                              Container(
                                height: 20,
                              ),
                              const Text(
                                'Furnishing',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Wrap(
                                  spacing: 8,
                                  children:
                                  List.generate(_choicesList.length, (index) {
                                    return ChoiceChip(
                                      labelPadding: const EdgeInsets.only(
                                          left: 12, right: 12, top: 4, bottom: 4),
                                      label: Text(
                                        _choicesList[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                            color: defaultChoiceIndex == index
                                                ? Colors.white
                                                : black,
                                            fontSize: 14),
                                      ),
                                      selected: defaultChoiceIndex == index,
                                      selectedColor: dark_orange,
                                      onSelected: (value) {
                                        setState(() {
                                          defaultChoiceIndex =
                                          value ? index : defaultChoiceIndex;
                                          strFurnishing = _choicesList[index];
                                        });
                                      },
                                      backgroundColor: light_orange,
                                      elevation: 4,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    );
                                  }),
                                ),
                              ),
                              Container(
                                height: 26,
                              ),
                              const Text(
                                'Amenities',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Wrap(
                                  spacing: 8,
                                  children:
                                  List.generate(listAmenities.length, (index) {
                                    return ChoiceChip(
                                      labelPadding: const EdgeInsets.only(
                                          left: 12, right: 12, top: 4, bottom: 4),
                                      label: Text(
                                        toDisplayCase(listAmenities[index].name!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                            color: listAmenities[index].selected == true
                                                ? Colors.white
                                                : black,
                                            fontSize: 14),
                                      ),
                                      selected: listAmenities[index].selected == true,
                                      selectedColor: dark_orange,
                                      onSelected: (value) {
                                        setState(() {
                                          listAmenities[index].setSelected = value;
                                        });
                                      },
                                      backgroundColor: light_orange,
                                      elevation: 4,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                    );
                                  }),
                                ),
                              ),
                              Container(
                                height: 26,
                              ),
                              const Text(
                                'Preferences',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Wrap(
                                  spacing: 8,
                                  children:
                                  List.generate(listUserPreferences.length, (index) {
                                    return ChoiceChip(
                                      labelPadding: const EdgeInsets.only(
                                          left: 12, right: 12, top: 4, bottom: 4),
                                      label: Text(
                                        toDisplayCase(listUserPreferences[index].preferance!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                            color: listUserPreferences[index].selected == true
                                                ? Colors.white
                                                : black,
                                            fontSize: 14),
                                      ),
                                      selected: listUserPreferences[index].selected == true,
                                      selectedColor: dark_orange,
                                      onSelected: (value) {
                                        setState(() {
                                          listUserPreferences[index].setSelected = value;
                                        });
                                      },
                                      backgroundColor: light_orange,
                                      elevation: 4,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    );
                                  }),
                                ),
                              ),
                              Container(
                                height: 26,
                              ),
                              const Text(
                                'Property Photo(s)',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              propertyImages.isNotEmpty ? _propertyPhotos(propertyImages.length) : Container(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 50.0,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 14, bottom: 14),
                                  decoration: BoxDecoration(
                                      color: light_orange,
                                      border: Border.all(
                                        color: dark_orange,
                                      ),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(30))),
                                  child: InkWell(
                                    onTap: () {
                                      pickImages();
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text("Select Photo(s)",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: dark_orange,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 50.0,
                            width: 120.0,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 40, bottom: 10),
                            decoration: BoxDecoration(
                                color: light_orange,
                                border: Border.all(
                                  color: dark_orange,
                                ),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                            child: InkWell(
                              onTap: () {

                                setState(() {
                                  _isMainLoading = true;
                                });

                                strBedRoom = bedController.text.toString();
                                strBathroom = bathController.text.toString();
                                strBalcony = balconyController.text.toString();
                                strFlatMates = flatmateController.text.toString();
                                strAbout = aboutController.text.toString();

                                _saveProperty();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Submit",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: dark_orange,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ,
                ),
              ));
  }

  Future<void> pickImages() async {
    List<String> listPath = List<String>.empty(growable: true);

    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage(imageQuality: 70);

      /*resultList = await MultipleImagesPicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: const MaterialOptions(
          actionBarTitle: "Property Photo(s)",
        ),
      );*/

      for(int i=0;i<images.length;i++){
        File tempFile = File(images[i].path.toString());
        listPath.add(tempFile.path);
      }

    } on Exception catch (e) {
      print(e);
    }

    setState((){
      if((widget as AdvanceAddProperty).isFromEdit){
        propertyImages = List<String>.empty(growable: true);
        for(int i=0;i<(widget as AdvanceAddProperty).propertyData.images!.length;i++){
          propertyImages.add((widget as AdvanceAddProperty).propertyData.images![i].image.toString());
        }
        propertyImages.addAll(listPath);
      }
      else{
        propertyImages = listPath;
      }
    });

    print(propertyImages.length);
  }

  GridView _propertyPhotos(int n) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: n,
      itemBuilder: (ctx, i) => (
          Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.zero,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      elevation: 5,
                      child: propertyImages[i].startsWith("http")
                          ? FadeInImage.assetNetwork(
                        image: propertyImages[i]+"&w=720",
                        width: 200,
                        height: 180,
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/placeholder.png',
                      )
                          : Image.file(File(propertyImages[i]), width: 200, height: 180,fit:BoxFit.cover),
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: (){
                    if(propertyImages[i].startsWith("https") || propertyImages[i].startsWith("http")){
                      List<String> mediafile = propertyImages[i].split("/");
                      if(strRemovedImagesId.isEmpty){
                          strRemovedImagesId = mediafile[mediafile.length - 1];
                        }
                        else{
                          strRemovedImagesId = strRemovedImagesId + "," + mediafile[mediafile.length - 1];
                        }
                        print(strRemovedImagesId);
                    }

                    setState(() {
                      propertyImages.removeAt(i);
                    });
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.remove_circle_rounded,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                  ),
                ),
              )
            ],
          )
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _isMainLoading = true;
    });

    if (isOnline) {
      _getAmenitiesList();
    }

    if((widget as AdvanceAddProperty).isFromEdit){
      bedController.text = (widget as AdvanceAddProperty).propertyData.beds.toString();
      bathController.text = (widget as AdvanceAddProperty).propertyData.bathrooms.toString();
      balconyController.text = (widget as AdvanceAddProperty).propertyData.balcony.toString();
      flatmateController.text = (widget as AdvanceAddProperty).propertyData.maxFlatmates.toString();
      aboutController.text = (widget as AdvanceAddProperty).propertyData.aboutProperty.toString();

      if((widget as AdvanceAddProperty).propertyData.internet == "1"){
        setState(() {
          isInternetChecked = true;
        });
      }

      if((widget as AdvanceAddProperty).propertyData.parking == "1"){
        setState(() {
          isParkingChecked = true;
        });
      }

      for(int i=0;i<(widget as AdvanceAddProperty).propertyData.images!.length;i++){
          propertyImages.add((widget as AdvanceAddProperty).propertyData.images![i].image.toString());
      }
    }
  }

  String getSelectedAmenities(){
    String ids = "";
    for(int i = 0;i < listAmenities.length;i++){
      if(listAmenities[i].selected == true){
        if(ids.isEmpty){
          ids = listAmenities[i].aminityId.toString();
        }
        else{
          ids = ids + "," + listAmenities[i].aminityId.toString();
        }
      }
    }
    return ids;
  }

  String getSelectedUserPreferences(){
    String ids = "";
    for(int i = 0;i < listUserPreferences.length;i++){
      if(listUserPreferences[i].selected == true){
        if(ids.isEmpty){
          ids = listUserPreferences[i].preferanceId.toString();
        }
        else{
          ids = ids + "," + listUserPreferences[i].preferanceId.toString();
        }
      }
    }
    return ids;
  }

  _getAmenitiesList() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + getAmenitiesList);

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

        Map<String, dynamic> amenityType = jsonDecode(body);
        var amenitiesResponse = AmenitiesTypeResponse.fromJson(amenityType);
        if (amenitiesResponse.success == 1) {
          listAmenities = amenitiesResponse.aminities!;
        }
      }

      _getUserPreferenceList();

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _getUserPreferenceList() async {
    try {
      HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
        HttpLogger(logLevel: LogLevel.BODY),
      ]);

      final url = Uri.parse(BASE_URL + getUserPreferences);

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

        Map<String, dynamic> preferenceType = jsonDecode(body);
        var preferenceResponse = UserPreferenceResponse.fromJson(preferenceType);
        if (preferenceResponse.success == 1) {
          listUserPreferences = preferenceResponse.userPreferancesTypes!;
          setState(() {
            _isMainLoading = false;
          });
        }

        if((widget as AdvanceAddProperty).isFromEdit){
          for(int i=0;i<listAmenities.length;i++){
            for(int j=0;j<(widget as AdvanceAddProperty).propertyData.aminities!.length;j++){
              if(listAmenities[i].name == (widget as AdvanceAddProperty).propertyData.aminities![j].name){
                listAmenities[i].setSelected = true;
              }
            }
          }

          for(int i=0;i<listUserPreferences.length;i++){
            for(int j=0;j<(widget as AdvanceAddProperty).propertyData.userPropertyPreferance!.length;j++){
              if(listUserPreferences[i].preferanceId == (widget as AdvanceAddProperty).propertyData.userPropertyPreferance![j].preferanceId){
                listUserPreferences[i].setSelected = true;
              }
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _saveProperty() async {
    final url = Uri.parse(BASE_URL + saveProperty);

    var request = MultipartRequest("POST", url);
    request.fields['apiId'] = API_KEY;
    request.fields['user_id'] = sessionManager.getUserId() ?? "0";
    request.fields['token'] = sessionManager.getToken() ?? "";
    request.fields['email'] = sessionManager.getEmail() ?? "";
    request.fields['property_type_id'] = (widget as AdvanceAddProperty).propertyTypeId;
    request.fields['city_id'] = sessionManager.getCityId() ?? "";
    request.fields['title'] = (widget as AdvanceAddProperty).propertyTitle;
    request.fields['price'] = (widget as AdvanceAddProperty).propertyRent;
    request.fields['location_latitude'] = (widget as AdvanceAddProperty).propertyLat;
    request.fields['location_longitude'] = (widget as AdvanceAddProperty).propertyLng;
    request.fields['location'] = (widget as AdvanceAddProperty).propertyLocation;
    request.fields['beds'] = strBedRoom;
    request.fields['bathrooms'] = strBathroom;
    request.fields['balcony'] = strBalcony;
    request.fields['furnished'] = strFurnishing == "Semi Furnished" ? "0" : "1";
    request.fields['max_flatmates'] = strFlatMates;
    request.fields['internet'] = isInternetChecked ? "1" : "0";
    request.fields['parking'] = isParkingChecked ? "1" : "0";
    request.fields['looking_for'] = (widget as AdvanceAddProperty).lookingFor;
    request.fields['about_property'] = strAbout;
    request.fields['aminities'] = getSelectedAmenities();
    request.fields['property_id'] = (widget as AdvanceAddProperty).isFromEdit ? (widget as AdvanceAddProperty).propertyData.propertyId.toString() : "";
    request.fields['property_user_preferance'] = getSelectedUserPreferences();
    request.fields['removeImages'] = strRemovedImagesId;
    request.fields['from_app'] = "true";
    request.fields['available_from'] = (widget as AdvanceAddProperty).propertyAvailableFrom;

    for(int i=0;i<propertyImages.length;i++){
      if(!propertyImages[i].startsWith("https") || !propertyImages[i].startsWith("http")){
        var multipartFile = await MultipartFile.fromPath("images["+i.toString()+"]", propertyImages[i]);
        request.files.add(multipartFile);
      }
    }

    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    Map<String, dynamic> user = jsonDecode(responseString);
    var propertySaveResponse = PropertySaveResponse.fromJson(user);

    setState(() {
      _isMainLoading = false;
    });

    showSnackBar(propertySaveResponse.message, context);
    if (propertySaveResponse.success == 1) {
      Navigator.of(context).pop(propertySaveResponse);
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void castStatefulWidget() {
    widget is AdvanceAddProperty;
  }
}
