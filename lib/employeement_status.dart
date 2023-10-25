import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_my_appartment/constant/constants.dart';

import 'model/property_type_response_model.dart';

class EmployeementStatus extends StatefulWidget {
  const EmployeementStatus({Key? key}) : super(key: key);

  @override
  _EmployeementStatusState createState() => _EmployeementStatusState();
}

class _EmployeementStatusState extends State<EmployeementStatus> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  bool status = true;

  List<PropertyTypeRes> propertyTypeList = [
    PropertyTypeRes(nameStatic: "Working full-time",bgColorStatic:"#ffE9F5F3", itemIconStatic: Icons.card_travel_sharp,iconColorStatic: "#ff5CC19F"),
    PropertyTypeRes(nameStatic: "Working part-time",bgColorStatic:"#ffF5F3F8", itemIconStatic: Icons.lock_clock_rounded,iconColorStatic: "#ff8082BE"),
    PropertyTypeRes(nameStatic: "Working holiday",bgColorStatic:"#ffFEF3E3", itemIconStatic: Icons.stroller,iconColorStatic: "#ffEE9B3D"),
    PropertyTypeRes(nameStatic: "Retired",bgColorStatic:"#ffE5F2F8", itemIconStatic: Icons.people_alt_rounded,iconColorStatic: "#ff3BB0E2"),
    PropertyTypeRes(nameStatic: "Unemployeed",bgColorStatic:"#ffF5F3F8", itemIconStatic: Icons.card_travel_sharp,iconColorStatic: "#ff8186C1"),
    PropertyTypeRes(nameStatic: "Sales\nExecutive",bgColorStatic:"#ffE7F4F0", itemIconStatic: Icons.emoji_people_rounded,iconColorStatic: "#ff5FC2A3"),
    PropertyTypeRes(nameStatic: "Student",bgColorStatic:"#ffE9F3FA", itemIconStatic: Icons.menu_book_rounded,iconColorStatic: "#ff3A97D2"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg_color,
        body: Padding(
          padding: const EdgeInsets.all(20),
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
                      SystemChannels.textInput
                          .invokeMethod('TextInput.hide');
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Flexible(
                  child:  Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      color: white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 20, left: 15,right: 10),
                          child:  const Text("INTRODUCE YOUR SELF",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14)),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 15,top: 0,right: 10),
                          child:  const Text("Employeement Status",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            color: white,
                            child:  GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10),
                                shrinkWrap: true,
                                itemCount: propertyTypeList.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        alignment: Alignment.center,
                                        child:Icon(
                                          propertyTypeList[index].itemIcon,
                                          color: Color(int.parse(propertyTypeList[index].iconColor.replaceAll('#', '0x'))),
                                          size: 36,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(int.parse(propertyTypeList[index].bgColor.replaceAll('#', '0x'))),
                                            borderRadius: BorderRadius.circular(22)),
                                      ),
                                      Container(
                                        height: 8,
                                      ),
                                      Text(propertyTypeList[index].name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: dark_text,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14))
                                    ],
                                  );
                                }),
                          ),
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                  flex: 1),
              Align(alignment: Alignment.bottomCenter,
                child:  Container(
                  height: 50.0,
                  width: 120.0,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 40,bottom: 20),
                  decoration: BoxDecoration(
                      color: light_orange,
                      border: Border.all(
                        color: dark_orange,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30))
                  ),
                  child: InkWell(
                    onTap: () {

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text("Next",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: dark_orange,
                                fontWeight: FontWeight.normal,
                                fontSize: 18)),
                        Container(
                          width: 6,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: dark_orange,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
