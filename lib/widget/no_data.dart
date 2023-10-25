import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_my_appartment/constant/constants.dart';

class MyNoDataWidget extends StatelessWidget {
  final String msg;

  const MyNoDataWidget({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/images/no_data_animation.json',height: 200,width:200,repeat: true,animate: true,frameRate: FrameRate.max),
              Container(
                height: 12,
              ),
              Text(
                msg,
                style: const TextStyle(
                    color: black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
        ));
  }
}
