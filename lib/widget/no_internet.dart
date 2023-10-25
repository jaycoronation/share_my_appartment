import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_my_appartment/constant/constants.dart';

class NoInternetWidget extends StatelessWidget {

  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/no_internet_animation.json',height: 200,repeat: true,animate: true,frameRate: FrameRate.max),
            Container(
              height: 12,
            ),
            const Text(
              'You are not connected to internet.',
              style: TextStyle(
                  color: black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
              ),
            )
          ],
        ));
  }
}
