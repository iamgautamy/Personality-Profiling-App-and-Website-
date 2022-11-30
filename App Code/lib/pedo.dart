// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, library_private_types_in_public_api, constant_identifier_names, empty_catches, unused_local_variable

library health;

import 'dart:async';
import 'dart:collection';
import 'dart:io' show Platform;
import 'dart:developer' as developer;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:samsug/last.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

part 'src/data_types.dart';
part 'src/functions.dart';
part 'src/health_data_point.dart';
part 'src/health_value_types.dart';
part 'src/health_factory.dart';

class Pedop extends StatefulWidget {
  var myuuid;

  Pedop({Key? key, this.myuuid}) : super(key: key);
  @override
  _PedopState createState() => _PedopState();
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

class _PedopState extends State<Pedop> {
  List<HealthDataPoint> _healthDataList = [];
  int _nofSteps = 10;
  HealthFactory health = HealthFactory();
  Future fetchData() async {
    final types = [
      HealthDataType.STEPS,
    ];

    final permissions = [
      HealthDataAccess.READ,
    ];
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 5));
    bool requested =
        await health.requestAuthorization(types, permissions: permissions);
    await Permission.activityRecognition.request();
    await Permission.location.request();
    if (requested) {
      try {
        // fetch health data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(yesterday, now, types);
        // save all the new data points (only the first 100)
        _healthDataList.addAll((healthData.length < 100)
            ? healthData
            : healthData.sublist(0, 100));
      } catch (error) {}

      // filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      // print the results
      for (var x in _healthDataList) {
      }

      // update the UI to display the results
      setState(() {});
    } else {}
  }

  Future fetchStepData() async {
    int? steps;

    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {}

      setState(() {
        _nofSteps = (steps == null) ? 0 : steps;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference pedo =
        FirebaseFirestore.instance.collection("PedoMeter");
    return WithForegroundTask(
      child: MaterialApp(
        home: Scaffold(
          //appBar: AppBar(),
          body: Stack(
            children: <Widget>[
              Image.asset('asset/walku.png'),
              Container(
                padding: const EdgeInsets.only(top: 470, right: 90),
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Text("Sign-In"),
                      onPressed: () async {
                        //getYesterdayStep();
                        fetchStepData();
                      },
                    ),
                    Text(_nofSteps.toString()),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => permo(myuuid: widget.myuuid),
                ),
              );

              pedo
                  .add({
                    'pedometer': _nofSteps,
                    'time': DateTime.now().toString().substring(0, 19),
                    'uuid': widget.myuuid
                  })
                  .then((value) => developer.log("User Added"))
                  .catchError((error) => developer.log("Failed to add user: $error"));
            },
            child: const Icon(Icons.navigate_next),
          ),
        ),
      ),
    );
  }
}
