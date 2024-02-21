import 'dart:convert';

import 'package:cinemagicx/morex.dart';
import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/videox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Xman extends StatefulWidget {
  const Xman({super.key});

  @override
  State<Xman> createState() => XmanX();
}

// 005EEA border 0381E9 btn

class XmanX extends State<Xman> with TickerProviderStateMixin {
  int expandedTileIndex = -1;

  List<dynamic> data = [];

  Future<void> featchdata() async {
    try {
      var response = await http.get(
        Uri.parse('$backendurl/categories'),
        headers: {"Content-Type": "application/json"},
      );
      final datax = jsonDecode(response.body);
      data = datax["data"];
      setState(() {
        //

        tabController = TabController(length: data.length, vsync: this);
      });
    } catch (e) {
      print(e);
    }
  }

  late TabController tabController;

  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    super.initState();

    featchdata();

    tabController = TabController(length: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
          title: Image.asset(
            "assets/logo.png",
            height: 50,
          ),
          bottom: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              controller: tabController,
              dividerHeight: 2,
              tabs: List.generate(
                  tabController.length,
                  (index) => Column(
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: "assets/loader.gif",
                            image: "${imgUrl + data[index]["dp"]}",
                            height: 30,
                          ),
                          Text(
                            "${data[index]["name"]}",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ))),
        ),
        body: TabBarView(
            controller: tabController,
            children: List.generate(tabController.length, (index) {
              Map<String, dynamic> xdat = jsonDecode(data[index]["data"]);

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
                          placeholder: "assets/loader.gif",
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
                          placeholder: "assets/loader.gif",
                          image: "${imgUrl + value["dp"]}",
                        ),
                      ));
                    }
                  } else {
                    rajux.add(FadeInImage.assetNetwork(
                        placeholder: "assets/loader.gif",
                        image: "${imgUrl + value["dp"]}"));
                  }
                } else if (dtx.first == "SLIDER") {
                  List<Widget> imglist = List.generate(
                      value.length,
                      (indexxx) => ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/loader.gif",
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
                } else if (dtx.first == "Categoryx") {
                  rajux.add(SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: value.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, indext) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MoreX(
                                      catid: value[indext]["_id"],
                                    ),
                                  ));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/loader.gif",
                                image: "${imgUrl + value[indext]["dp"]}",
                                height: 100,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ));

                  rajux.add(Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      dtx[1],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ));
                } else {
                  rajux.add(SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: value.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, indext) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VideoX(idx: value[indext]["_id"]),
                                  ));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.assetNetwork(
                                placeholder: "assets/loader.gif",
                                image: "${imgUrl + value[indext]["APP"]}",
                                height: 100,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ));

                  rajux.add(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${dtx.first}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (dtx.length > 1 && dtx.last != "null")
                        FilledButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MoreX(
                                      catid: dtx.last,
                                    ),
                                  ));
                            },
                            style: ButtonStyle(
                                side: MaterialStatePropertyAll(
                                    BorderSide(color: Colors.white)),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.transparent)),
                            child: Text(
                              "More",
                              style: TextStyle(fontSize: 13),
                            )),
                    ],
                  ));
                  rajux.add(SizedBox(
                    height: 10,
                  ));
                }
              });

              return SingleChildScrollView(
                  child: Column(children: rajux.reversed.toList()));
            })));
  }
}
