import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/*show message to user*/
showSnackBar(String? message,BuildContext? context) {
  try {
    return ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(message!),
          duration: const Duration(seconds: 1),
        ),
      );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

/*check email validation*/
bool isValidEmail(String ? input) {
  try {
    return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(input!);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return false;
  }
}

/*convert string to CamelCase*/
toDisplayCase (String str) {
  try {
    String data = str.trim();
    return data.toLowerCase().split(' ').map((word) {
        String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
        return word[0].toUpperCase() + leftText;
      }).join(' ');
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

/*generate hex color into material color*/
MaterialColor createMaterialColor(Color color) {
  try {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
        strengths.add(0.1 * i);
      }
    for (var strength in strengths) {
        final double ds = 0.5 - strength;
        swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1,
        );
      }
    return MaterialColor(color.value, swatch);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return const MaterialColor(0xFFFFFFFF, <int, Color>{});
  }
}

/*share text content to social apps*/
Future<void> shareTextContent(String title,String text,String link,String chooserTitle) async {
  try {
    await FlutterShare.share(
          title: title,
          text: text,
          linkUrl: link,
          chooserTitle: chooserTitle
      );
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

/*share text content along with media*/
Future<void> shareFileWithText(String title,String text,String filePath) async {
  try {
    Share.shareXFiles([XFile(filePath)], text: text);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

/*open device google maps application*/
Future<void> openMap(double latitude, double longitude) async {
  try {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    launch(googleUrl);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

/*generate custom map marker*/
Future<Uint8List> getBytesFromCanvas(String customNum, int width, int height) async  {
  final PictureRecorder pictureRecorder = PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color = white;
  final Radius radius = Radius.circular(width/2);
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, width.toDouble(),  height.toDouble()),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      paint);

  TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = TextSpan(
    text: '₹' + customNum.toString(), // your custom number here
    style: GoogleFonts.nunito(
        fontSize: 42,
        color: black,
        fontWeight: FontWeight.w700),
  );

  painter.layout();
  painter.paint(
      canvas,
      Offset((width * 0.5) - painter.width * 0.5,
          (height * .5) - painter.height * 0.5));
  final img = await pictureRecorder.endRecording().toImage(width, height);
  final data = await img.toByteData(format: ImageByteFormat.png);
  return data!.buffer.asUint8List();
}

