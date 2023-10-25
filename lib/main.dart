import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/constant/global_context.dart';
import 'package:share_my_appartment/login_screen.dart';
import 'package:share_my_appartment/services/PushNotificationService.dart';
import 'package:share_my_appartment/tabcontrol/tabnavigation.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:share_my_appartment/utils/session_manager.dart';
import 'package:share_my_appartment/utils/session_manager_new.dart';

import 'my_inquiry.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // you need to initialize firebase first
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data.toString()}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    /*await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
        apiKey: "AIzaSyDyd8HmF7Stbg3yUOmHcFfVF1CJVw36UIw",
        appId: "1:411061342956:web:989c34b19e993a37020bc9",
        messagingSenderId: "411061342956",
        projectId: "share-my-appartment",
      ),
    );*/
  await SessionManagerNew.init();
  //To show custom widget on error instead of ErrorWidget
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) => errorScreen(flutterErrorDetails.exception);
    //await PushNotificationService().setupInteractedMessage();
    // you can just pass the function like this
    /*FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      //App received a notification when it was killed
      NavigationService.notif_type = initialMessage.data['content_type'];
    }*/
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Splash Screen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: createMaterialColor(const Color(0XffEDEDEE)),
            scaffoldBackgroundColor: const Color(0XffEDEDEE),
            toggleableActiveColor: dark_orange,
            textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)),
      home: const MyHomePage(),
      navigatorKey: NavigationService.navigatorKey
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false ;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      SessionManager sessionManager = SessionManager();
      isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;
      if(NavigationService.notif_type.isNotEmpty){
        Timer(
            const Duration(seconds: 3),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyInquiryListingPage())));
      }
      else{
        Timer(
            const Duration(seconds: 3),
                () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            isLoggedIn == true ? const TabNavigation() : const LoginScreen()), (Route<dynamic> route) => false));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: white,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.png',fit: BoxFit.contain),
            Align(
              alignment: Alignment.center,
              child: Text('Share My\nAppartment',style: GoogleFonts.poppins(
                fontSize: 44,
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Custom Widget
Widget errorScreen(dynamic detailsException) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
        //Check is it release mode
        Foundation.kReleaseMode
        //Widget for release mode
            ? const Center(child: Text('Sorry for inconvenience',style: TextStyle(fontSize: 24.0)))
        //Widget for debug mode
            : SingleChildScrollView(child: Text('Exeption Details:\n\n$detailsException')),
      )
  );
}
