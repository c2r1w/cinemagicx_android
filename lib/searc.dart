import 'dart:convert';

import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/videox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class XSearch extends StatefulWidget {
  XSearch({super.key});

  @override
  State<XSearch> createState() => XSearchX();
}

class XSearchX extends State<XSearch> {
  List<dynamic> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff071427),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          leadingWidth: 30,
          titleTextStyle: TextStyle(color: Colors.white),
          title: SizedBox(
            height: 45,
            child: TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) async {
                final tcty = await http.get(Uri.parse(
                    "${backendurl}/createvideo?limit=12&on=TITLE&pro=TITLE,BNR,APP&search=$value"));

                data = (jsonDecode(tcty.body))["data"];

                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Search',
                fillColor: Colors.white,
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.white)),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: .8,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoX(idx: data[index]["_id"]),
                    ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/loader.gif",
                  image: "${imgUrl + data[index]["APP"]}",
                  height: 100,
                  fit: BoxFit.scaleDown,
                ),
              ),
            );
          },
        ));
  }
}
