import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemagicx/dlist.dart';
import 'package:cinemagicx/morex.dart';
import 'package:cinemagicx/rads.dart';
import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/signup.dart';
import 'package:cinemagicx/videox.dart';
import 'package:cinemagicx/watchltr.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ExtVdo extends StatefulWidget {
  final Map<String, dynamic> xdat;

  final String tit;
  ExtVdo({super.key, required this.xdat, required this.tit});

  @override
  State<ExtVdo> createState() => ExtVdoX();
}

class ExtVdoX extends State<ExtVdo> {
  List<Widget> rajux = [];

  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    super.initState();

    widget.xdat.forEach((key, value) {
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
            (indexxx) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoX(idx: value[indexxx]["_id"]),
                        ));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/loader.gif",
                      image: "${imgUrl + value[indexxx]["BNR"]}",
                      fit: BoxFit.scaleDown,
                    ),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              dtx[1],
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          ),
        ));
      } else if (dtx.first == "native") {
        print("\n==========\n");

        if (value == "small") {
          if (Random().nextBool()) {
            rajux.add(IronsourceNative(
              key: GlobalKey(),
            ));
          } else {
            rajux.add(GoogleNative(
              key: GlobalKey(),
            ));
          }
        }
        if (value == "large") {
          if (Random().nextBool()) {
            rajux.add(IronsourceNative(
              key: GlobalKey(),
              issall: false,
            ));
          } else {
            rajux.add(GoogleNative(
              key: GlobalKey(),
              isssmall: false,
            ));
          }
        }
        print(value);
        print("\n==========\n");
      } else {
        rajux.add(Container(
          // color: Colors.white,
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${dtx.first}",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
              ),
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
                      side: WidgetStatePropertyAll(
                          BorderSide(color: Colors.white)),
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.transparent)),
                  child: Text(
                    "More",
                    style: TextStyle(fontSize: 11),
                  )),
          ],
        ));
        rajux.add(SizedBox(
          height: 10,
        ));
      }
    });

    rajux = rajux.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MySignUp();
                    }));
                  },
                  child: Text("Profile")),
              MenuItemButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DownloadedPage();
                    }));
                  },
                  child: Text("Download List")),
              MenuItemButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Vatchlist();
                    }));
                  },
                  child: Text("Watch Later")),
            ],
            builder: (context, controller, child) => IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              color: Colors.white,
              height: 1,
            )),
        foregroundColor: Colors.white,
        titleSpacing: 0,
        title: Center(
          child: Image.asset(
            "assets/logo.png",
            height: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: rajux,
        ),
      ),
    );
  }
}
