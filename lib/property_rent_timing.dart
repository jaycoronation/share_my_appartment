import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/employeement_status.dart';

class PropertyRentTiming extends StatefulWidget {
  const PropertyRentTiming({Key? key}) : super(key: key);

  @override
  _PropertyRentTimingState createState() => _PropertyRentTimingState();
}

class _PropertyRentTimingState extends State<PropertyRentTiming> {
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;
  bool status = true;
  String dropdownValue = '12 Month+';
  TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child:  const Text("YOUR BUDGET & REQUIREMENT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child:  const Text("Rent & Timing",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                    Container(
                      height: 20,
                    ),
                    const Text('Monthly Budget',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
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
                      height: 26,
                    ),
                    const Text('Preferred Move Date',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
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
                          child: InkWell(
                            onTap: () {

                            },
                            child: Row(
                              children: [
                                Flexible(child: TextField(
                                    cursorColor: black,
                                    controller: dateinput,
                                    maxLength: 10,
                                    readOnly: true,
                                    onTap: ()async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context, initialDate: DateTime.now(),
                                          firstDate: DateTime.now().subtract(const Duration(days: 0)), //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2101),
                                          helpText: 'Preferred Move Date',
                                          builder: (BuildContext context, Widget? child) {
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme: const ColorScheme.dark(
                                                  primary: black,
                                                  onPrimary: Colors.white,
                                                  surface: light_pink,
                                                  onSurface: black,
                                                ),
                                                dialogBackgroundColor: light_orange,
                                              ),
                                              child: child!,
                                            );
                                          }
                                      );

                                      if(pickedDate != null ){
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
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: 'Move Date',
                                        hintStyle: TextStyle(
                                          color: dark_text,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                        )))),
                                const Icon(Icons.calendar_today_rounded,size: 24,color: dark_text,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 26,
                    ),
                    const Text('Preferred Length Of Stay',style: TextStyle(color: black,fontSize: 16,fontWeight: FontWeight.bold),),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.only(left: 12,top: 12,right: 12,bottom: 12),
                          decoration: BoxDecoration(
                              color: white,
                              border:
                              Border.all(color: dark_text),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(28))),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded,color: dark_text,),
                            iconSize: 24,
                            isDense: true,
                            isExpanded: true,
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: black,),
                            underline: const SizedBox.shrink(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                              '12 Month+',
                              '24 Month+',
                              '36 Month+',
                              '4 Years'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                            builder: (context) => const EmployeementStatus()),
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
