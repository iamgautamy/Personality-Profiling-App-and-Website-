// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:isolate';
import 'dart:developer' as developer;
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:samsug/home.dart';
import 'package:samsug/pedo.dart';
import 'package:samsug/last.dart';
import 'package:samsug/questionare.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_information/device_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:usage_stats/usage_stats.dart';

const String countKey = 'count';
const String isolateName = 'isolate';
final ReceivePort port = ReceivePort();
SharedPreferences? prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );
  prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(countKey)) {
    await prefs.setInt(countKey, 0);
  }
  runApp(MaterialApp(
    home: const MyApp(),
    routes: <String, WidgetBuilder>{
      '/welcome': (BuildContext context) => const MyApp(),
      '/home': (context) => Home(),
      '/mood': (context) => personality(),
      '/pedometer': (context) => Pedop(),
      '/submit': (BuildContext context) => submit(),
      '/MyWidget': (BuildContext context) => const MyWidget(),
    },
  ));
}

int? initScreen;

Future<void> initUsage() async {
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  CollectionReference appusse = FirebaseFirestore.instance.collection("AppUse");
  //var myuuid = await DeviceInformation.deviceIMEINumber;
  @override
  DateTime endDate = DateTime.now();
  DateTime startDate = endDate.subtract(const Duration(days: 1));

  List<UsageInfo> t = await UsageStats.queryUsageStats(startDate, endDate);

  for (var g in t) {
    appusse
        .add({
          'packageName': g.packageName,
          'firstTimeStamp': g.firstTimeStamp,
          'lastTimeStamp': g.lastTimeStamp,
          'lastTimeUsed': g.lastTimeUsed,
          'totalTimeInForeground': g.totalTimeInForeground,
          'uuid': prefs.getString('imei'),
        })
        .then((value) => developer.log("App use data submitted"))
        .catchError((error) => developer.log("Failed to add Data: $error"));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    AndroidAlarmManager.initialize();
    port.listen((_) async {
      WidgetsFlutterBinding.ensureInitialized();
      await (Firebase.initializeApp());
      await (initUsage());
    });
    initPlatformState();
  }

  var _imeiNoo;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await Permission.phone.request();
    var _imeiNo = await DeviceInformation.deviceIMEINumber;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imei', _imeiNo);
    setState(() {
      _imeiNoo = _imeiNo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: Image.asset('asset/Samsungl.png'),
        title: const Text(
          "Samsung Prism",
          style: TextStyle(
            fontSize: 18,
            //fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Colors.white10,
        showLoader: true,
        loadingText: Text("Loading... \nID : $_imeiNoo"),
        durationInSeconds: 5,
        navigator: initScreen == 0 || initScreen == null
            ? Home(
                myuuid: _imeiNoo,
              )
            : const MyWidget());
  }
}
