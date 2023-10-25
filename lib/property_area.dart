import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/property_rent_timing.dart';


class PropertyArea extends StatefulWidget {
  const PropertyArea({Key? key}) : super(key: key);

  @override
  _PropertyAreaState createState() => _PropertyAreaState();
}

class _PropertyAreaState extends State<PropertyArea> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  bool status = true;
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
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child:  const Text("YOUR IDEAL PLACE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.normal,
                                fontSize: 12)),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child:  const Text("Where would you like to live?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                      Container(
                        height: 20,
                      ),
                      const Text('Areas',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                      Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(left: 12,right: 12),
                        decoration: BoxDecoration(
                            color: white,
                            border:
                            Border.all(color: dark_text),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(28))),
                        child: const Center(
                          child: TextField(
                              keyboardType: TextInputType.number,
                              cursorColor: black,
                              maxLength: 10,
                              style: TextStyle(
                                color: black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  hintText: 'Budget in Rs.',
                                  hintStyle: TextStyle(
                                    color: dark_text,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ))),
                        ),
                      ),
                    ),
                  ),
                      Container(
                        height: 8,
                      ),
                      const Text('We recommend choosing at least 4 areas',style: TextStyle(color: dark_text,fontSize: 12,fontWeight: FontWeight.w300),)
                    ],
                  ),
                ),
              ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PropertyRentTiming()),
                      );
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
