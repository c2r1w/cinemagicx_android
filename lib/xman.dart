import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cinemagicx/rads.dart';
import 'package:flutter/material.dart';
import 'package:cinemagicx/ExVdo.dart';
import 'package:cinemagicx/dlist.dart';
import 'package:cinemagicx/morex.dart';
import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/searc.dart';
import 'package:cinemagicx/signup.dart';
import 'package:cinemagicx/videox.dart';
import 'package:cinemagicx/watchltr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class Xman extends StatefulWidget {
  Xman({super.key});

// stop ads

  @override
  State<Xman> createState() => XmanX();
}

// 005EEA border 0381E9 btn

class XmanX extends State<Xman> with TickerProviderStateMixin {
  int expandedTileIndex = -1;
// stop ads

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

        tabController = TabController(
            length: data.length > 4 ? 5 : data.length, vsync: this);
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

  bool iads = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    featchdata();

    tabController = TabController(length: 0, vsync: this);
    // stop ads

    setState(() {
      Random random = Random();
      iads = true;
      random.nextBool();
    });
  }

  bool showmore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.red,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () async {
                // await showModalBottomSheet(
                //     backgroundColor: Color(0xff071427),
                //     context: context,
                //     builder: (context) => pPadding(
                //           padding: const EdgeInsets.only(
                //               top: 15, left: 10, right: 10),
                //           child: XSearch(),
                //         ));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => XSearch(),
                    ));
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MySignUp()));
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
          title: Image.asset(
            "assets/logo.png",
            height: 40,
          ),
          bottom: TabBar(
            tabAlignment: TabAlignment.fill,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(0),
            labelPadding: EdgeInsets.all(0),
            controller: tabController,
            dividerColor: Colors.white,

            labelColor: Colors.white,
            dividerHeight: 2,
            onTap: (value) {
              if (value == tabController.length - 1) {
                tabController.animateTo(tabController.previousIndex);

                setState(() {
                  showmore = !showmore;
                });
              }
            },
            tabs: List.generate(
                tabController.length,
                (index) => tabController.length == index + 1
                    ? Tab(
                        height: 50,
                        icon: showmore
                            ? Icon(
                                Icons.close,
                                color: Colors.white,
                              )
                            : Icon(
                                color: Color.fromARGB(255, 91, 198, 250),
                                Icons.arrow_drop_down_circle_outlined,
                              ),
                        child: showmore
                            ? Text(
                                "Less",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "heaid",
                                    color: Colors.white),
                              )
                            : Text("More",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: "heaid")))
                    : Tab(
                        height: 50,
                        icon: CachedNetworkImage(
                            height: 20,
                            imageUrl: "${imgUrl + data[index]["dp"]}"),
                        child: Text(
                          "${data[index]["name"]}",
                          style: TextStyle(fontSize: 10, fontFamily: "heaid"),
                        ),
                      )),

            //  Column(
            //       children: [
            //         // FadeInImage.assetNetwork(
            //         //   placeholder: "assets/loader.gif",
            //         //   image: "{$imgUrl + data[index]["dp"]}",
            //         //   height: 20,
            //         // ),
            //         Text(
            //           "${data[index]["name"]}",
            //           style: TextStyle(
            //               fontSize: 13,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white),
            //         )
            //       ],
            //     )
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
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
                                  child: CachedNetworkImage(
                                    placeholder: (rf, tg) => Image.asset(
                                      "assets/loader.gif",
                                      width: 50,
                                      height: 50,
                                    ),
                                    imageUrl:
                                        "${imgUrl + value[indexxx]["BNR"]}",
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
                                  child: CachedNetworkImage(
                                    placeholder: (rf, tg) => Image.asset(
                                      "assets/loader.gif",
                                      width: 50,
                                      height: 50,
                                    ),
                                    imageUrl: "${imgUrl + value[indext]["dp"]}",
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
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
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
                                  child: CachedNetworkImage(
                                    placeholder: (rf, tg) => Image.asset(
                                      "assets/loader.gif",
                                      width: 50,
                                      height: 50,
                                    ),
                                    imageUrl:
                                        "${imgUrl + value[indext]["APP"]}",
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
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.normal),
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
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.transparent)),
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

                  return SingleChildScrollView(
                      child: Column(children: rajux.reversed.toList()));
                })),
            Visibility(
              visible: showmore,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),

                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text("More Options"),
                    SizedBox(
                      height: 10,
                    ),
                    ...List.generate(
                      ((data.length - 1) / 4).ceil(),
                      (rowIndex) {
                        int startIndex = 4 + rowIndex * 4;
                        int endIndex = startIndex + 4;

                        // Ensure endIndex does not exceed the length of the data
                        if (endIndex > data.length) {
                          endIndex = data.length;
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            ((endIndex - startIndex) > 0
                                ? (endIndex - startIndex)
                                : 0),
                            (index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ExtVdo(
                                            xdat: jsonDecode(
                                                data[startIndex + index]
                                                    ["data"]),
                                            tit:
                                                "${data[startIndex + index]["name"]}"),
                                      ));
                                },
                                child: Tab(
                                  icon: CachedNetworkImage(
                                      height: 20,
                                      imageUrl:
                                          "${imgUrl + data[startIndex + index]["dp"]}"),
                                  text: "${data[startIndex + index]["name"]}",
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DownloadedPage()));
                          },
                          label: Text("Download List"),
                          icon: Icon(Icons.download),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Vatchlist()));
                          },
                          label: Text("Watch List"),
                          icon: Icon(Icons.alarm),
                        ),
                      ],
                    )
                  ],
                ),
                color: Colors.black.withOpacity(0.9), // Semi-transparent black
                width: double.infinity,
                height: double.infinity,
              ),
            )
          ],
        ));
  }
// stop ads

  // void _loadAd() {
  //   final bannerAd = BannerAd(
  //     size: widget.adSize,
  //     adUnitId: widget.adUnitId,
  //     request: const AdRequest(),
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (ad) {
  //         if (!mounted) {
  //           ad.dispose();
  //           return;
  //         }
  //         setState(() {
  //           _bannerAd = ad as BannerAd;
  //         });
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (ad, error) {
  //         print("ttyyy$error");
  //         debugPrint('BannerAd failed to load: $error');
  //         ad.dispose();
  //       },
  //     ),
  //   );

  //   // Start loading.
  //   bannerAd.load();
  // }
}
