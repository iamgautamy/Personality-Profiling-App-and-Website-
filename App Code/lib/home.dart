// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, must_be_immutable, constant_identifier_names, prefer_typing_uninitialized_variables, empty_catches

library flutter_blue_plus;

import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:developer' as developer;
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/health.dart';
import 'package:samsug/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gen/flutterblueplus.pb.dart' as protos;
import 'package:samsug/questionare.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:screen_state/screen_state.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
part 'src/bluetooth_characteristic.dart';
part 'src/bluetooth_descriptor.dart';
part 'src/bluetooth_device.dart';
part 'src/bluetooth_service.dart';
part 'src/flutter_blue_plus.dart';
part 'src/guid.dart';

@pragma('vm:entry-point')
Future<void> startCallback() async {
  // The setTaskHandler function must be called to handle the task in the background.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  int _eventCount = 0;
  CollectionReference screens =
      FirebaseFirestore.instance.collection('ScreenState');
  CollectionReference FlutterBt =
      FirebaseFirestore.instance.collection("Bluetooth");

  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _sendPort = sendPort;

// You can use the getData function to get the stored data.
    FlutterBluePlus.instance.state.listen((state) async {
      if (state == BluetoothState.on) {}
      if (state == BluetoothState.off) {}
      if (state == BluetoothState.turningOn) {}
      if (state == BluetoothState.turningOff) {}
      if (state == BluetoothState.unknown) {}
      //add state to firebase
      FlutterBt.add({
        'state': state.toString(),
        'time': DateTime.now().toString(),
        'uuid': prefs.getString('imei'),
      })
          .then((value) => developer.log("Bt data submitted"))
          .catchError((error) => developer.log("Failed to add Data: $error"));
    });
    // ignore: no_leading_underscores_for_local_identifiers
    Screen _screen = Screen();
    _screen.screenStateStream!.listen((event) async {
      screens
          .add({
            'event': event.toString().split('.').last,
            'time': DateTime.now().toIso8601String(),
            'uuid': prefs.getString('imei'),
          })
          .then((value) => developer.log("Screen state data submitted"))
          .catchError((error) => developer.log("Failed to add Data: $error"));
    });
  }

  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    FlutterForegroundTask.updateService(
      notificationTitle: 'Samsung Prism',
      notificationText: 'Data Collection in Progress',
    );

    // Send data to the main isolate.
    sendPort?.send(_eventCount);

    _eventCount++;
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    // You can use the clearAllData function to clear all the stored data.
    await FlutterForegroundTask.clearAllData();
  }

  @override
  void onButtonPressed(String id) {
    // Called when the notification button on the Android platform is pressed.
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp("/");
    _sendPort?.send('onNotificationPressed');
  }
}

class Home extends StatefulWidget {
  var myuuid;
  Home({Key? key, this.myuuid}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_NOT_ADDED,
  STEPS_READY,
}

class _HomeState extends State<Home> {
  String gselectedValue = "Male";
  String aselectedValue = "15-25";
  String oselectedValue = "Employed";
  String gender = 'Male';
  String agegrp = '15-25';
  String occupation = 'Employed';
  ReceivePort? _receivePort;
  static SendPort? uiSendPort;

  void _initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'notification_channel_id',
        channelName: 'Foreground Notification',
        channelDescription:
            'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
          backgroundColor: Colors.orange,
        ),
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<bool> _startForegroundTask() async {
    try {
      await Firebase.initializeApp();
      await initUsage();
    } catch (e) {
      return false;
    }
    if (!await FlutterForegroundTask.canDrawOverlays) {
      final isGranted =
          await FlutterForegroundTask.openSystemAlertWindowSettings();
      if (!isGranted) {
        return false;
      }
    }

    // You can save data using the saveData function.
    await FlutterForegroundTask.saveData(key: 'customData', value: 'CustomKey');

    bool reqResult;
    if (await FlutterForegroundTask.isRunningService) {
      reqResult = await FlutterForegroundTask.restartService();
    } else {
      reqResult = await FlutterForegroundTask.startService(
        notificationTitle: 'Foreground Service is running',
        notificationText: 'Tap to return to the app',
        callback: startCallback,
      );
    }

    ReceivePort? receivePort;
    if (reqResult) {
      receivePort = await FlutterForegroundTask.receivePort;
    }

    return _registerReceivePort(receivePort);
  }

  bool _registerReceivePort(ReceivePort? receivePort) {
    _closeReceivePort();

    if (receivePort != null) {
      _receivePort = receivePort;
      _receivePort?.listen((message) {
        if (message is int) {
          //print('eventCount: $message');
        } else if (message is String) {
          if (message == 'onNotificationPressed') {
            Navigator.of(context).pushNamed('/resume-route');
          }
        } else if (message is DateTime) {}
      });

      return true;
    }

    return false;
  }

  void _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }

  T? _ambiguate<T>(T? value) => value;

  @override
  void initState() {
    super.initState();
    _initForegroundTask();
    _ambiguate(WidgetsBinding.instance)?.addPostFrameCallback((_) async {
      // You can get the previous ReceivePort without restarting the service.
      if (await FlutterForegroundTask.isRunningService) {
        final newReceivePort = await FlutterForegroundTask.receivePort;
        _registerReceivePort(newReceivePort);
      }
    });
  }

  @override
  void dispose() {
    _closeReceivePort();
    super.dispose();
  }

  static Future<void> callback() async {
    developer.log('Alarm fired!');
    // Get the previous cached count and increment it.

    await Firebase.initializeApp();
    CollectionReference pedo =
        FirebaseFirestore.instance.collection("PedoMeter");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    HealthFactory health = HealthFactory();
    initUsage();
    Future fetchStepData() async {
      int? steps;

      // get steps for today (i.e., since midnight)
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);

      bool requested =
          await health.requestAuthorization([HealthDataType.STEPS]);

      if (requested) {
        try {
          steps = await health.getTotalStepsInInterval(midnight, now);
        } catch (error) {}

        //add steps to firebase

      }
      pedo
          .add({
            'pedometer': steps,
            'time': DateTime.now().toString().substring(0, 19),
            'uuid': prefs.getString('imei')
          })
          .then((value) => developer.log("PedoData Added"))
          .catchError((error) => developer.log("Failed to add user: $error"));
    }

    fetchStepData();
    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }

  @override
  Widget build(BuildContext context) {
    String myuuid = widget.myuuid;
    CollectionReference g_info =
        FirebaseFirestore.instance.collection("g_info");
    return Builder(builder: (context) {
      return WithForegroundTask(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('BioData Submission'),
            centerTitle: true,
            backgroundColor: Colors.indigo[800],
            elevation: 0,
          ),
          body: Column(
            children: <Widget>[
              Card(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text('Gender'),
                      DropdownButton(
                          value: gselectedValue,
                          items: const [
                            DropdownMenuItem(
                              value: "Male",
                              child: Text("Male"),
                            ),
                            DropdownMenuItem(
                              value: "Female",
                              child: Text("Female"),
                            ),
                            DropdownMenuItem(
                              value: "Others",
                              child: Text('Other'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              gender = value as String;
                              gselectedValue = value;
                              //g_info.add({'Gender': gender});
                            });
                          })
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text('Age Group'),
                      DropdownButton(
                          value: aselectedValue,
                          items: const [
                            DropdownMenuItem(
                              value: "15-25",
                              child: Text("15-25"),
                            ),
                            DropdownMenuItem(
                              value: "26-35",
                              child: Text("26-35"),
                            ),
                            DropdownMenuItem(
                              value: "36-45",
                              child: Text('36-45'),
                            ),
                            DropdownMenuItem(
                              value: "45 and above",
                              child: Text('45 and above'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              agegrp = value as String;
                              aselectedValue = value;
                              //g_info.add({'Age Group': agegrp});
                            });
                          })
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text('Occupation'),
                      DropdownButton(
                          value: oselectedValue,
                          items: const [
                            DropdownMenuItem(
                              value: "Employed",
                              child: Text("Employed"),
                            ),
                            DropdownMenuItem(
                              value: "Unemployed",
                              child: Text("Unemployed"),
                            ),
                            DropdownMenuItem(
                              value: "Student",
                              child: Text('Student'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              occupation = value as String;
                              oselectedValue = value;
                              //g_info.add({'Occupation': occupation});
                            });
                          })
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  // ignore: deprecated_member_use
                  ElevatedButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Saving...'),
                        duration: Duration(seconds: 1),
                      ));
                      AndroidAlarmManager.periodic(
                        const Duration(hours: 24), //Do the same every 24 hours
                        Random().nextInt(
                            pow(2, 31) as int), //Different ID for each alarm
                        callback,
                        wakeup:
                            true, //the device will be woken up when the alarm fires
                        startAt: DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            23,
                            27), //Start whit the specific time 5:00 am
                        rescheduleOnReboot: true, //Work after reboot
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              personality(myuuid: widget.myuuid),
                        ),
                      );

                      _startForegroundTask();

                      g_info
                          .doc(myuuid)
                          .set({
                            'Gender': gender,
                            'Age': agegrp,
                            'Occupation': occupation
                          })
                          .then((value) =>
                              developer.log("Data Submitted for $myuuid"))
                          .catchError(
                              (error) => const Text("data not submitted"));
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
