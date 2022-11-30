// ignore_for_file: deprecated_member_use, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables, library_private_types_in_public_api

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usage_stats/usage_stats.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';

class permo extends StatefulWidget {
  var myuuid;

  permo({Key? key, this.myuuid}) : super(key: key);

  @override
  _permo createState() => _permo();
}

class _permo extends State<permo> {
  bool usagepermo = false;
  bool batterypermo = false;
  bool autopermo = false;
  bool isenabled = false;
  void _checkpermissionapp() async {
    if (await UsageStats.checkUsagePermission() == true) {
      setState(() {
        usagepermo = true;
      });
    } else {
      setState(() {
        usagepermo = false;
      });
    }
  }

  void _checkpermissionbattery() async {
    if (await DisableBatteryOptimization.isBatteryOptimizationDisabled ==
        true) {
      setState(() {
        batterypermo = true;
      });
    } else {
      setState(() {
        batterypermo = false;
      });
    }
  }

  void checkpermissionautostart() async {
    if (await DisableBatteryOptimization.isAutoStartEnabled == true) {
      setState(() {
        autopermo = true;
        isenabled = true;
      });
    } else {
      setState(() {
        autopermo = false;
      });
    }
  }

  routetosubmit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => submit()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Access'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                "For app to work properly, please grant following permission",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    UsageStats.grantUsagePermission();
                    _checkpermissionapp();
                  },
                  style: ButtonStyle(
                    backgroundColor: //if usagepermo is true green else fasle
                        MaterialStateProperty.all<Color>(usagepermo
                            ? Colors.green
                            : Colors
                                .red), //if usagepermo is true green else fasle
                  ),
                  child: const Text("App usage"),
                  //change button color from red to green when permission is granted
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
                "App usage data is a critical part of our data collcection drive.\nPlease grant us access to your app usage data"),
            const SizedBox(height: 20),
            //for disable battery optimization
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    DisableBatteryOptimization
                        .showDisableBatteryOptimizationSettings();
                    _checkpermissionbattery();
                  },
                  style: ButtonStyle(
                    backgroundColor: //if batterypermo is true green else fasle
                        MaterialStateProperty.all<Color>(
                            batterypermo ? Colors.green : Colors.red),
                  ),
                  child: const Text("Disable Battery Optimization"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
                "Disabling battery optimization will help us to collect data even when android decides to kill our app"),
            const SizedBox(height: 20),
            //route to submit function

            Row(children: [
              ElevatedButton(
                onPressed: () {
                  DisableBatteryOptimization.showEnableAutoStartSettings(
                      "Enable Auto Start",
                      "Follow the steps and enable the auto start of this app");
                  checkpermissionautostart();
                },
                style: ButtonStyle(
                  backgroundColor: //if batterypermo is true green else fasle
                      MaterialStateProperty.all<Color>(
                          autopermo ? Colors.green : Colors.red),
                ),
                child: const Text("Enable Auto Start"),
              ),
            ]),
            const SizedBox(height: 10),
            const Text(
                "Enabling auto start will help us to collect data even when device is restarted"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isenabled && batterypermo && usagepermo && autopermo
                  ? routetosubmit
                  : null,
              style: ButtonStyle(
                backgroundColor: //if isenabled is true green else fasle
                    MaterialStateProperty.all<Color>(
                        isenabled ? Colors.green : Colors.red),
              ),
              child: const Text("Next"),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Text(
                  "Do not hide the notification",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class submit extends StatefulWidget {
  var myuuid;

  submit({Key? key, this.myuuid}) : super(key: key);

  @override
  State<submit> createState() => _submitState();
}

class _submitState extends State<submit> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        //change background color

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/1.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "ALL YOUR DATA IS SAFE WITH US",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "We do not collect any private data such as your Contact Number,SMS,Location.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("We respect your privacy, all the data is encrypted.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  UsageStats.grantUsagePermission();
                  Navigator.pushNamedAndRemoveUntil(context, '/MyWidget',
                      (_) => false); //navigate to home page
                },
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
            //create hr line
            const SizedBox(
              height: 20,
            ),
            const Text(
              "By clicking Next you agree to our Terms and Conditions",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  _launchURLBrowser() async {
    const url = 'https://prisminterz.online/';
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[120],
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'asset/ty.png',
              fit: BoxFit.fill,
            ),
            Positioned(
              height: 670,
              width: 350,
              child: IconButton(
                iconSize: 50,
                onPressed: () {
                  _launchURLBrowser();
                },
                icon: const Icon(
                  Icons.web,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
