import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cinemagicx/raju.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:pinput/pinput.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

// 005EEA border 0381E9 btn

class _HomePageState extends State<HomePage> {
  List<String> raju = ["raju"];

  bool isclick = false;

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.video_call,
                          size: 40,
                          color: Color(0xff1AC8FF),
                        ),
                        Text("Home"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.video_call,
                          size: 40,
                          color: Color(0xff1AC8FF),
                        ),
                        Text("Web Series"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.video_call,
                          size: 40,
                          color: Color(0xff1AC8FF),
                        ),
                        Text("Short Film"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.video_call,
                          size: 40,
                          color: Color(0xff1AC8FF),
                        ),
                        Text("Films"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.video_call,
                          size: 40,
                          color: Color(0xff1AC8FF),
                        ),
                        Text("Films"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.video_call,
                          size: 40,
                          color: Color(0xff1AC8FF),
                        ),
                        Text("Films"),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    height: 300,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: raju.length,
                      itemBuilder: (context, index) {
                        return FilledButton(
                            onPressed: () {}, child: Text("ADD"));
                      },
                    ))
              ],
            )));
  }
}
