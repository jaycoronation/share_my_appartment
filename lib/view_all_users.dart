import 'package:flutter/material.dart';
import 'package:share_my_appartment/userprofile.dart';
import 'package:share_my_appartment/utils/app_utils.dart';

import 'model/user_list_response.dart';

class ViewAllUsers extends StatefulWidget {
  final List<Users>? listUsers;
  const ViewAllUsers(this.listUsers,{Key? key}) : super(key: key);

  @override
  _ViewAllUsersState createState() => _ViewAllUsersState();
}

class _ViewAllUsersState extends State<ViewAllUsers> {

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
          child:  ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: widget.listUsers!.length,
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfilePage(widget.listUsers![index].userId!)),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5,
                          child: widget.listUsers![index].profilePic!.isNotEmpty ? FadeInImage.assetNetwork(
                            image: widget.listUsers![index].profilePic!+"&w=720",
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            placeholder:
                            'assets/images/placeholder.png',
                          ) :
                          Image.asset('assets/images/placeholder.png',fit: BoxFit.cover,
                            width: 60,
                            height: 60,),
                        ),
                        Flexible(child: Container(
                          margin: const EdgeInsets.only(left: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                toDisplayCase(widget.listUsers![index].name!),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              Container(
                                height: 6,
                              ),
                              Text(
                                toDisplayCase(widget.listUsers![index].distance! + ' away'),
                                style: const TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),flex: 1,),
                        const Divider(),
                        const Icon(
                          Icons.remove_red_eye_rounded,
                          size: 24,
                        )
                      ],
                    ),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),),
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
