import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemagicx/raju.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MoreX extends StatefulWidget {
  final String catid;

  const MoreX({super.key, required this.catid});

  @override
  State<MoreX> createState() => MoreXX();
}

// 005EEA border 0381E9 btn

class MoreXX extends State<MoreX> {
  int expandedTileIndex = -1;

  Map<String, dynamic> data = {};
  List<Widget> dataz = [];

  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> featchdata() async {
    try {
      var response = await http.get(
        Uri.parse(
            '$backendurl/more?direct=true&limit=1000&on=_id&search=${widget.catid}'),
        headers: {"Content-Type": "application/json"},
      );
      final datax = jsonDecode(response.body);

      final xdat = jsonDecode(datax["data"]);
      List<Widget> rajux = [];

      xdat.forEach((key, value) {
        final dtx = key.split("|");

        if (dtx.first == "ADS") {
          if (value["link"].length > 4) {
            if (value["height"].length > 1) {
              rajux.add(InkWell(
                onTap: () {
                  _launchUrl(value["link"]);
                },
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/logo.png",
                  image: "${imgUrl + value["dp"]}",
                  fit: BoxFit.scaleDown,
                  height: double.parse(
                    value["height"],
                  ),
                ),
              ));
            } else {
              rajux.add(InkWell(
                onTap: () {
                  _launchUrl(value["link"]);
                },
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/logo.png",
                  image: "${imgUrl + value["dp"]}",
                ),
              ));
            }
          } else {
            rajux.add(FadeInImage.assetNetwork(
                placeholder: "assets/logo.png",
                image: "${imgUrl + value["dp"]}"));
          }
        } else if (dtx.first == "SLIDER") {
          List<Widget> imglist = List.generate(
              value.length,
              (indexxx) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/logo.png",
                      image: "${imgUrl + value[indexxx]["BNR"]}",
                      fit: BoxFit.scaleDown,
                    ),
                  ));

          rajux.add(Container(
            child: CarouselSlider(
              items: imglist,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  viewportFraction: .8,
                  enlargeCenterPage: true),
            ),
          ));
        } else {
          final items = value;

          rajux.add(Column(children: [
            for (int i = 0; i < (items.length / 3).ceil(); i++)
              SizedBox(
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int j = i * 3;
                        j < (i * 3) + 3 && j < items.length;
                        j++)
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/logo.png",
                                image: "${imgUrl + value[j]["BNR"]}",
                                height: 100,
                                placeholderFit: BoxFit.scaleDown,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
          ]));
        }
      });

      setState(() {
        dataz = rajux;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          actions: [
            Icon(
              Icons.emoji_events,
              color: Colors.white,
              size: 40,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
          ],
          leadingWidth: 0,
          title: Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              "assets/logo.png",
              height: 50,
            ),
          ),
        ),
        body: dataz.length < 1
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: dataz,
                ),
              ));
  }
}
