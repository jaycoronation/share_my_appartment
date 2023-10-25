import 'package:flutter/material.dart';
import 'package:share_my_appartment/utils/app_utils.dart';

import 'listing.dart';
import 'model/city_response.dart';

class ViewAllCities extends StatefulWidget {
  final List<Cities> listCities;
  const ViewAllCities(this.listCities,{Key? key}) : super(key: key);

  @override
  _ViewAllCitiesState createState() => _ViewAllCitiesState();
}

class _ViewAllCitiesState extends State<ViewAllCities> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0XffEDEDEE),
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
          height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(22.0)),
              color: Color(0xffF7F8F8),
            ),
          margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top:10),
          padding: const EdgeInsets.all(12),
          child:  GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 28,
                  crossAxisSpacing: 10),
              shrinkWrap: true,
              primary: false,
              itemCount: widget.listCities.length,
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PropertyListingPage(widget.listCities[index].cityId!,widget.listCities[index].name!,widget.listCities)),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                              width: 110,
                              height: 100,
                              child: Container(
                                margin: const EdgeInsets.only(right:8),
                                decoration: ShapeDecoration(
                                    color: createMaterialColor(Color(int.parse(widget.listCities[index].background!.replaceAll('#', '0xff')))).withOpacity(0.3),
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          style: BorderStyle.none),
                                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                    )),
                                child: Center(
                                    child: widget.listCities[index].icon!.isNotEmpty ? Image.network(widget.listCities[index].icon!+'&w=198',fit: BoxFit.contain, width: 60, height: 60) :
                                    Image.asset('assets/images/building.png',fit: BoxFit.cover,
                                      width: 50,
                                      color: Colors.transparent,
                                      height: 50,)),
                              )),
                          Container(
                            height: 12,
                          ),
                          Wrap(
                            children: [
                              Text(toDisplayCase(widget.listCities[index].name!),
                                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700, fontSize: 13))
                            ],)
                        ],
                      ))
                    ],
                  ),
                );
              }),
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
