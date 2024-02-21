import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApi extends StatefulWidget {
  const MyApi({super.key});

  @override
  State<MyApi> createState() => MyApiX();
}

// 005EEA border 0381E9 btn

class MyApiX extends State<MyApi> {
  String v = "Click Mez";

  dynamic r = 348;

  List<Map<String, dynamic>> datdx = [
    {
      "_id": "658b2af7147118d21964a1b8",
      "email": "email",
      "phone": "phone",
      "name": "name",
      "password": "1234567890",
      "__v": 0
    },
    {
      "_id": "658b2b5c147118d21964a1c2",
      "email": "34",
      "phone": "56",
      "name": "12",
      "password": "78",
      "__v": 0
    },
    {
      "_id": "658b37a1147118d21964a1c9",
      "email": "poi",
      "phone": "zxc",
      "name": "qwe",
      "password": "ertytrds",
      "__v": 0
    },
    {
      "_id": "6592825463b753abd128948e",
      "email": "xs@email.com",
      "phone": "933848394",
      "name": "deeepali",
      "password": "1234pass",
      "__v": 0
    },
    {
      "_id": "659282f763b753abd12894ad",
      "email": "1234",
      "phone": "1234",
      "name": "1234",
      "password": "234",
      "__v": 0
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView.builder(
      itemCount: datdx.length,
      itemBuilder: (context, index) {
        return Text(
          datdx[index]["name"],
          style: TextStyle(color: Colors.white),
        );
      },
    )));
  }
}
