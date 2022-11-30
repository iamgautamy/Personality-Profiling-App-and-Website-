// ignore_for_file: sort_child_properties_last, unnecessary_cast, avoid_unnecessary_containers, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:samsug/pedo.dart';
import 'dart:developer' as developer;

class personality extends StatefulWidget {
  var myuuid;
  personality({Key? key, this.myuuid}) : super(key: key);

  @override
  State<personality> createState() => _personalityState();
}

class _personalityState extends State<personality> {
  String p1 = 'Disagree';
  String p2 = 'Disagree';
  String p3 = 'Disagree';
  String p4 = 'Disagree';
  String p5 = 'Disagree';
  String p6 = 'Disagree';
  String p7 = 'Disagree';
  String p8 = 'Disagree';
  String p9 = 'Disagree';
  String p10 = 'Disagree';
  String p11 = 'Disagree';
  String p12 = 'Disagree';
  String p13 = 'Disagree';
  String p14 = 'Disagree';
  String p15 = 'Disagree';
  String selectedp1 = 'Disagree';
  String selectedp2 = 'Disagree';
  String selectedp3 = 'Disagree';
  String selectedp4 = 'Disagree';
  String selectedp5 = 'Disagree';
  String selectedp6 = 'Disagree';
  String selectedp7 = 'Disagree';
  String selectedp8 = 'Disagree';
  String selectedp9 = 'Disagree';
  String selectedp10 = 'Disagree';
  String selectedp11 = 'Disagree';
  String selectedp12 = 'Disagree';
  String selectedp13 = 'Disagree';
  String selectedp14 = 'Disagree';
  String selectedp15 = 'Disagree';

  @override
  Widget build(BuildContext context) {
    String myuuid = widget.myuuid;
    CollectionReference persona =
        FirebaseFirestore.instance.collection("Questionare");
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personality Questionare',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo[800],
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
              child: Column(children: <Widget>[
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('I am the life of the party'),
                    Container(
                        child: DropdownButton(
                            value: selectedp1,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p1 = value as String;
                                selectedp1 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Feel little concern for others'),
                    Container(
                        child: DropdownButton(
                            value: selectedp2,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p2 = value as String;
                                selectedp2 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Am always prepared'),
                    Container(
                        child: DropdownButton(
                            value: selectedp3,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p3 = value as String;
                                selectedp3 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Get stressed out easily'),
                    Container(
                        child: DropdownButton(
                            value: selectedp4,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p4 = value as String;
                                selectedp4 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Have a rich vocabulary'),
                    Container(
                        child: DropdownButton(
                            value: selectedp5,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p5 = value as String;
                                selectedp5 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Dont talk a lot'),
                    Container(
                        child: DropdownButton(
                            value: selectedp6,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p6 = value as String;
                                selectedp6 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Am interested in people'),
                    Container(
                        child: DropdownButton(
                            value: selectedp7,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p7 = value as String;
                                selectedp7 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Leave my belongings around'),
                    Container(
                        child: DropdownButton(
                            value: selectedp8,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p8 = value as String;
                                selectedp8 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Am relaxed most of the time'),
                    Container(
                        child: DropdownButton(
                            value: selectedp9,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p9 = value as String;
                                selectedp9 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Have difficulty understanding abstract ideas'),
                    Container(
                        child: DropdownButton(
                            value: selectedp10,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p10 = value as String;
                                selectedp10 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(' Am easily disturbed.'),
                    Container(
                        child: DropdownButton(
                            value: selectedp11,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p11 = value as String;
                                selectedp11 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                        ' Often forget to put things back in their proper place.'),
                    Container(
                        child: DropdownButton(
                            value: selectedp12,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p12 = value as String;
                                selectedp12 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(' Start conversations'),
                    Container(
                        child: DropdownButton(
                            value: selectedp13,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p13 = value as String;
                                selectedp13 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(' Pay attention to details'),
                    Container(
                        child: DropdownButton(
                            value: selectedp14,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p14 = value as String;
                                selectedp14 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text('Take time out for others.'),
                    Container(
                        child: DropdownButton(
                            value: selectedp15,
                            items: const [
                              DropdownMenuItem(
                                child: Text("Disagree"),
                                value: "Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Disagree"),
                                value: "Slightly Disagree",
                              ),
                              DropdownMenuItem(
                                child: Text('Neutral'),
                                value: "Neutral",
                              ),
                              DropdownMenuItem(
                                child: Text("Slightly Agree"),
                                value: "Slightly Agree",
                              ),
                              DropdownMenuItem(
                                child: Text("Agree"),
                                value: "Agree",
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                p15 = value as String;
                                selectedp15 = value as String;
                                //g_info.add({'Gender': gender});
                              });
                            }))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Saving Personality Traits'),
                  duration: Duration(seconds: 1),
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pedop(myuuid: myuuid),
                  ),
                );
                persona
                    .doc(myuuid)
                    .set({
                      'Q1': p1,
                      'Q2': p2,
                      'Q3': p3,
                      'Q4': p4,
                      'Q5': p5,
                      'Q6': p6,
                      'Q7': p7,
                      'Q8': p8,
                      'Q9': p9,
                      'Q10': p10,
                      'Q11': p11,
                      'Q12': p12,
                      'Q13': p13,
                      'Q14': p14,
                      'Q15': p15,
                    })
                    .then((value) => developer.log("Data Submitted $myuuid"))
                    .catchError(
                        (error) => developer.log("Failed to add Data: $error"));
              },
              child: const Text('Next',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            )
          ]));
        }),
      );
    });
  }
}
