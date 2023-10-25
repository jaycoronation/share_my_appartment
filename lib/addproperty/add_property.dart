import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:share_my_appartment/addproperty/advance_add_property.dart';
import 'package:share_my_appartment/addproperty/places_autocomplete.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/model/property_save_response.dart';
import 'package:share_my_appartment/model/property_type_response.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/base_class.dart';
import 'package:share_my_appartment/widget/loading.dart';

import '../detail.dart';
import '../model/property_list_response.dart';
import '../network/api_end_points.dart';
import '../utils/session_manager.dart';
import 'location_search.dart';

class AddProperty extends StatefulWidget {
  final Properties propertyData;
  final bool isFromEdit;
  const AddProperty(this.propertyData,this.isFromEdit,{Key? key}) : super(key: key);

  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends BaseState<AddProperty> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  List<Types>? listPropertyTypes;
  SessionManager sessionManager = SessionManager();
  Types? dropdownValue = Types();
  TextEditingController dateinput = TextEditingController();
  bool _isMainLoading = false;
  var propertyTypeId = "", propertyTitle = "", propertyLocation = "" , propertyRent = "" , lookingFor = "Male" ,
      propertyLat = "" , propertyLng = "", propertyAvailableFrom = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController rentController = TextEditingController();

  int defaultChoiceIndex = 0;
  final List<String> _choicesList = ['Male', 'Female', 'Family'];

  //New code
  //We will pass the sink to the places auto complete widget to get the selected address by user
  TextEditingController locationController = TextEditingController();
  final _pickUpLocationSC = StreamController<PlaceDetail>.broadcast();
  StreamSink<PlaceDetail> get pickUpLocationSink => _pickUpLocationSC.sink;
  Stream<PlaceDetail> get pickUpLocationStream => _pickUpLocationSC.stream;
  String address = "";

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
                              Navigator.pop(context);
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
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            )),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text((widget as AddProperty).isFromEdit ? "UPDATE PROPERTY" :"ADD PROPERTY",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Text("Basic Details",
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
                              'Choose Property Type',
                              style: TextStyle(
                                  color: black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, top: 12, right: 12, bottom: 12),
                                  decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(color: dark_text),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(28))),
                                  child: DropdownButton<Types>(
                                    value: dropdownValue,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: dark_text,
                                    ),
                                    iconSize: 24,
                                    isDense: true,
                                    isExpanded: true,
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ),
                                    underline: const SizedBox.shrink(),
                                    onChanged: (Types? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                        propertyTypeId = dropdownValue!
                                            .propertyTypeId!
                                            .toString();
                                      });
                                    },
                                    items: listPropertyTypes!
                                        .map<DropdownMenuItem<Types>>(
                                            (Types value) {
                                      return DropdownMenuItem<Types>(
                                        value: value,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        child: Text(toDisplayCase(value.type!)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 26,
                            ),
                            const Text(
                              'Property Title',
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
                                  keyboardType: TextInputType.text,
                                  cursorColor: black,
                                  controller: titleController,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Property Title',
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
                              'Property Location',
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
                              child: StreamBuilder<PlaceDetail>(
                                  stream: pickUpLocationStream,
                                  builder: (context, snapshot) {
                                    if(snapshot.data != null){
                                      final String name = snapshot.data == null
                                          ? ""
                                          : snapshot.data!.name ?? "";

                                      final String address = snapshot.data == null
                                          ? ""
                                          : snapshot.data!.address ?? "";

                                      propertyLat = snapshot.data == null
                                          ? ""
                                          : snapshot.data!.latitude.toString();

                                      propertyLng = snapshot.data == null
                                          ? ""
                                          : snapshot.data!.longitude.toString();


                                      if(name.isNotEmpty && address.isNotEmpty){
                                        locationController.text = name + "\n" + address;
                                      }
                                    }
                                    return Center(
                                      child: TextField(
                                          cursorColor: black,
                                          autocorrect: false,
                                          controller: locationController,
                                          keyboardType: TextInputType.multiline,
                                          readOnly: true,
                                          maxLines: null,
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => LocationSearchScreen(title: "Search the location",sink: pickUpLocationSink,)),
                                            );
                                          },
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration:  const InputDecoration(
                                              counterText: "",
                                              border: InputBorder.none,
                                              hintText: 'Search Location',
                                              hintStyle: TextStyle(
                                                color: dark_text,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300,
                                              ))),
                                    );
                                  }),
                            ),
                            Container(
                              height: 26,
                            ),
                            const Text(
                              'Monthly Rent',
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
                                  keyboardType: Platform.isIOS?
                                  const TextInputType.numberWithOptions(signed: true)
                                      : TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  cursorColor: black,
                                  controller: rentController,
                                  maxLength: 10,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: const InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: 'Budget in Rs.',
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
                              'Available From',
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
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Flexible(
                                        child: TextField(
                                            cursorColor: black,
                                            controller: dateinput,
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(),
                                                  firstDate: DateTime.now().subtract(const Duration(days: 0)),
                                                  //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101),
                                                  helpText: 'Preferred Move Date',
                                                  builder: (BuildContext context, Widget? child) {
                                                    return Theme(data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(
                                                      primary: black,
                                                      onPrimary: Colors.white,
                                                      surface: light_pink,
                                                      onSurface: black,
                                                    ),
                                                      dialogBackgroundColor: light_orange,
                                                    ),
                                                      child: child!,
                                                    );
                                                  });

                                              if (pickedDate != null) {
                                                double timeStamp = (pickedDate.millisecondsSinceEpoch) / 1000 ;
                                                propertyAvailableFrom = timeStamp.toInt().toString();
                                                String formattedDate = DateFormat('dd MMMM,yyyy').format(pickedDate);
                                                //you can implement different kind of Date Format here according to your requirement
                                                setState(() {
                                                  dateinput.text = formattedDate; //set output date to TextField value.
                                                });
                                              }
                                            },
                                            style: const TextStyle(
                                              color: black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            decoration:
                                            const InputDecoration(
                                                counterText: "",
                                                border:
                                                InputBorder.none,
                                                hintText: 'Move Date',
                                                hintStyle: TextStyle(
                                                  color: dark_text,
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w300,
                                                )))),
                                    const Icon(
                                      Icons.calendar_today_rounded,
                                      size: 24,
                                      color: dark_text,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 26,
                            ),
                            const Text(
                              'Looking For',
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
                                        lookingFor = _choicesList[index];
                                      });
                                    },
                                    backgroundColor: light_orange,
                                    elevation: 4,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                onTap: () async {
                                  propertyTitle = titleController.text.toString();
                                  propertyLocation = locationController.text.toString();
                                  propertyRent = rentController.text.toString();

                                  if(checkValidation()){
                                    final page = AdvanceAddProperty(propertyTypeId,propertyTitle,propertyLocation,
                                        propertyRent,lookingFor,propertyLat,propertyLng, propertyAvailableFrom,
                                        (widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData : Properties(),
                                        (widget as AddProperty).isFromEdit);

                                    /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), (Route<dynamic> route) => route.isFirst);*/

                                    PropertySaveResponse propertySaveResponse = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => page),
                                    );

                                     if(propertySaveResponse.success == 1){
                                       Navigator.of(context).pop(true);
                                       Navigator.push(
                                         context,
                                         MaterialPageRoute(builder: (context) =>  PropertyDetailPage(propertySaveResponse.property!.propertyId!)),
                                       );
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Next",
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
                          (widget as AddProperty).isFromEdit ? Container() : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50.0,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(top: 40, bottom: 10,left: 8),
                              decoration: BoxDecoration(
                                  color: light_orange,
                                  border: Border.all(color: dark_orange),
                                  borderRadius: const BorderRadius.all(Radius.circular(30))),
                              child: InkWell(
                                onTap: () {
                                  propertyTitle = titleController.text.toString();
                                  propertyLocation = locationController.text.toString();
                                  propertyRent = rentController.text.toString();

                                  if(checkValidation()){
                                    setState(() {
                                      _isMainLoading = true;
                                    });
                                    _saveProperty();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Skip Advance Details",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: dark_orange,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }

  bool checkValidation(){
    bool isValid = true;
    if(propertyTitle.isEmpty){
      isValid = false;
      showSnackBar("Please enter property title.", context);
    }
    else if(propertyLat.isEmpty && propertyLng.isEmpty){
      isValid = false;
      showSnackBar("Please enter property location.", context);
    }
    else if(propertyRent.isEmpty){
      isValid = false;
      showSnackBar("Please enter property budget.", context);
    }
    else if(propertyAvailableFrom.isEmpty){
      isValid = false;
      showSnackBar("Please select property availability date.", context);
    }
    return isValid;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _isMainLoading = true;
    });

    if (isOnline) {
      _getAllPropertyTypes();
    }

    if((widget as AddProperty).isFromEdit){
      titleController.text = (widget as AddProperty).propertyData.title.toString();
      locationController.text = (widget as AddProperty).propertyData.location.toString();
      rentController.text = (widget as AddProperty).propertyData.price.toString();
      propertyLat = (widget as AddProperty).propertyData.locationLatitude.toString();
      propertyLng = (widget as AddProperty).propertyData.locationLongitude.toString();
      dateinput.text = (widget as AddProperty).propertyData.availableFromFormat.toString();

      propertyAvailableFrom = (widget as AddProperty).propertyData.availableFrom.toString();

      for(int i=0;i<_choicesList.length;i++){
          if(_choicesList[i] == (widget as AddProperty).propertyData.lookingFor.toString()){
            defaultChoiceIndex = i;
            lookingFor = (widget as AddProperty).propertyData.lookingFor.toString();
            break;
          }
      }
    }
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

          if((widget as AddProperty).isFromEdit){
              for(int i=0;i<listPropertyTypes!.length;i++){
                if(listPropertyTypes![i].propertyTypeId == (widget as AddProperty).propertyData.propertyTypeId){
                  dropdownValue = listPropertyTypes?[i];
                  propertyTypeId = dropdownValue!.propertyTypeId.toString();
                }
              }
          }
          else{
            dropdownValue = listPropertyTypes?[0];
            propertyTypeId = dropdownValue!.propertyTypeId.toString();
          }

          setState(() {
            _isMainLoading = false;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _saveProperty() async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(BASE_URL + saveProperty);

    Map<String, String> jsonBody = {
      'apiId': API_KEY,
      'user_id': sessionManager.getUserId() ?? "0",
      'token': sessionManager.getToken() ?? "",
      'email': sessionManager.getEmail() ?? "",
      'property_type_id' : propertyTypeId,
      'city_id' : sessionManager.getCityId() ?? "",
      'title' : propertyTitle.trim(),
      'price' : propertyRent.trim(),
      'location_latitude' : propertyLat,
      'location_longitude' : propertyLng,
      'location' : propertyLocation,
      'beds': (widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData.beds.toString() : "",
      'bathrooms':(widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData.bathrooms.toString() : "",
      'balcony':(widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData.balcony.toString() : "",
      'furnished':"",
      'max_flatmates':(widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData.maxFlatmates.toString() : "",
      'internet':(widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData.internet.toString() : "0",
      'parking':(widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData.parking.toString() : "0",
      'looking_for': lookingFor,
      'about_property': (widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData.aboutProperty.toString() : "",
      'aminities':"",
      'property_id':(widget as AddProperty).isFromEdit ? (widget as AddProperty).propertyData.propertyId.toString() : "",
      'property_user_preferance':"",
      'removeImages': "",
      'from_app':"true",
      'available_from': propertyAvailableFrom
    };

    final response = await http.post(
        url,
        body: jsonBody
    );

    final statusCode = response.statusCode;

    setState(() {
      _isMainLoading = false;
    });

    if (statusCode == 200) {
      final body = response.body;

      Map<String, dynamic> user = jsonDecode(body);
      var propertySaveResponse = PropertySaveResponse.fromJson(user);
      showSnackBar(propertySaveResponse.message, context);
      if (propertySaveResponse.success == 1) {
        Navigator.of(context).pop(true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  PropertyDetailPage(propertySaveResponse.property!.propertyId!)),
        );
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    rentController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  void castStatefulWidget() {
    widget is AddProperty;
  }
}
