import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.0, style: BorderStyle.solid, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              )),
          child: Lottie.asset('assets/images/loading_animation.json',
              height: 30,
              repeat: true,
              animate: true,
              frameRate: FrameRate.max),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Loading...',
        )
      ],
    ));
  }
}
