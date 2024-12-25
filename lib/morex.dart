import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemagicx/dlist.dart';
import 'package:cinemagicx/rads.dart';
import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/searc.dart';
import 'package:cinemagicx/signup.dart';
import 'package:cinemagicx/videox.dart';
import 'package:cinemagicx/watchltr.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreX extends StatefulWidget {
  final String catid;
  final AdSize adSize = AdSize.fullBanner;

  final String adUnitId = Platform.isAndroid
      ? 'ca-app-pub-4899021849652416/7371054139'
      : 'ca-app-pub-4899021849652416/7520543235';
  MoreX({super.key, required this.catid});

  @override
  State<MoreX> createState() => MoreXX();
}

// 005EEA border 0381E9 btn

class MoreXX extends State<MoreX> with TickerProviderStateMixin {
  int expandedTileIndex = -1;
  List<Widget> rajux = [];
  BannerAd? _bannerAd;
  Map<String, dynamic> data = {};

  Future<void> featchdata() async {
    try {
      var response = await http.get(
        Uri.parse(
            '$backendurl/more?direct=true&limit=1000&on=_id&search=${widget.catid}'),
        headers: {"Content-Type": "application/json"},
      );
      final datax = jsonDecode(response.body);

      data = jsonDecode(datax["data"]);

      data.forEach((key, value) {
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

          rajux.add(Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
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
          rajux.add(SizedBox(
            height: 10,
          ));
          rajux.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "  ${dtx.first}",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
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
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    child: Text(
                      "More",
                      style: TextStyle(fontSize: 13),
                    )),
            ],
          ));

          rajux.add(Container(
            // color: Colors.white,
            height: 100,
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
                        image: "${imgUrl + value[indext]["BNR"]}",
                        height: 100,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                );
              },
            ),
          ));
        }
      });

      setState(() {
        //

        // tabController = TabController(length: data.length, vsync: this);
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

  bool iads = true;
  @override
  void initState() {
    super.initState();

    featchdata();

    tabController = TabController(length: 0, vsync: this);
    setState(() {
      Random random = Random();
      iads = random.nextBool();
    });

    iads
        ? IronSource.loadBanner(
            size: IronSourceBannerSize.BANNER,
            position: IronSourceBannerPosition.Bottom)
        : _loadAd();
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
      //  AppBar(
      //     leadingWidth: 0,
      //     leading: SizedBox(),
      //     foregroundColor: Colors.white,
      //     backgroundColor: Colors.transparent,
      //     centerTitle: false,
      //     actions: [
      //       IconButton(
      //         onPressed: () async {
      //           // await showModalBottomSheet(
      //           //     backgroundColor: Color(0xff071427),
      //           //     context: context,
      //           //     builder: (context) => pPadding(
      //           //           padding: const EdgeInsets.only(
      //           //               top: 15, left: 10, right: 10),
      //           //           child: XSearch(),
      //           //         ));

      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => XSearch(),
      //               ));
      //         },
      //         icon: Icon(
      //           Icons.search,
      //           color: Colors.white,
      //           size: 40,
      //         ),
      //       ),
      //       Icon(
      //         Icons.emoji_events,
      //         color: Colors.white,
      //         size: 40,
      //       ),
      //       MenuAnchor(
      //         menuChildren: [
      //           MenuItemButton(
      //               onPressed: () {
      //                 Navigator.push(context,
      //                     MaterialPageRoute(builder: (context) => MySignUp()));
      //               },
      //               child: Text("Profile")),
      //           MenuItemButton(
      //               onPressed: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => DownloadedPage()));
      //               },
      //               child: Text("Download List")),
      //           MenuItemButton(
      //               onPressed: () {
      //                 Navigator.push(context,
      //                     MaterialPageRoute(builder: (context) => Vatchlist()));
      //               },
      //               child: Text("Watch Later")),
      //         ],
      //         builder: (context, controller, child) => IconButton(
      //           onPressed: () {
      //             if (controller.isOpen) {
      //               controller.close();
      //             } else {
      //               controller.open();
      //             }
      //           },
      //           icon: Icon(
      //             Icons.person,
      //             color: Colors.white,
      //             size: 40,
      //           ),
      //         ),
      //       )
      //     ],
      //     title: Image.asset(
      //       "assets/logo.png",
      //       height: 50,
      //     )),

      bottomNavigationBar: Container(
        width: screenSize.width,
        height: iads ? 100 : widget.adSize.height.toDouble(),
        child: _bannerAd == null
            // Nothing to render yet.
            ? SizedBox()
            // The actual ad.
            : Center(child: AdWidget(ad: _bannerAd!)),
      ),
      body: SingleChildScrollView(child: Column(children: rajux)),
    );
  }

  void _loadAd() {
    final bannerAd = BannerAd(
      size: widget.adSize,
      adUnitId: widget.adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          print("ttyyy$error");
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }
}


//   int expandedTileIndex = -1;

//   Map<String, dynamic> data = {};
//   List<Widget> dataz = [];

//   Future<void> _launchUrl(String _url) async {
//     if (!await launchUrl(Uri.parse(_url))) {
//       throw Exception('Could not launch $_url');
//     }
//   }

//   Future<void> featchdata() async {
//     try {
//       var response = await http.get(
//         Uri.parse(
//             '$backendurl/more?direct=true&limit=1000&on=_id&search=${widget.catid}'),
//         headers: {"Content-Type": "application/json"},
//       );
//       final datax = jsonDecode(response.body);

//       final xdat = jsonDecode(datax["data"]);
//       List<Widget> rajux = [];

//       xdat.forEach((key, value) {
//         final dtx = key.split("|");

//         if (dtx.first == "ADS") {
//           if (value["link"].length > 4) {
//             if (value["height"].length > 1) {
//               rajux.add(InkWell(
//                 onTap: () {
//                   _launchUrl(value["link"]);
//                 },
//                 child: FadeInImage.assetNetwork(
//                   placeholder: "assets/logo.png",
//                   image: "${imgUrl + value["dp"]}",
//                   fit: BoxFit.scaleDown,
//                   height: double.parse(
//                     value["height"],
//                   ),
//                 ),
//               ));
//             } else {
//               rajux.add(InkWell(
//                 onTap: () {
//                   _launchUrl(value["link"]);
//                 },
//                 child: FadeInImage.assetNetwork(
//                   placeholder: "assets/logo.png",
//                   image: "${imgUrl + value["dp"]}",
//                 ),
//               ));
//             }
//           } else {
//             rajux.add(FadeInImage.assetNetwork(
//                 placeholder: "assets/logo.png",
//                 image: "${imgUrl + value["dp"]}"));
//           }
//         } else if (dtx.first == "SLIDER") {
//           List<Widget> imglist = List.generate(
//               value.length,
//               (indexxx) => InkWell(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 VideoX(idx: value[indexxx]["_id"]),
//                           ));
//                     },
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: FadeInImage.assetNetwork(
//                         placeholder: "assets/logo.png",
//                         image: "${imgUrl + value[indexxx]["BNR"]}",
//                         fit: BoxFit.scaleDown,
//                       ),
//                     ),
//                   ));

//           rajux.add(Container(
//             child: CarouselSlider(
//               items: imglist,
//               options: CarouselOptions(
//                   autoPlay: true,
//                   enlargeStrategy: CenterPageEnlargeStrategy.zoom,
//                   viewportFraction: .8,
//                   enlargeCenterPage: true),
//             ),
//           ));
//         } else {
//           final items = value;

//           rajux.add(Column(children: [
//             for (int i = 0; i < (items.length / 3).ceil(); i++)
//               SizedBox(
//                 height: 110,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (int j = i * 3;
//                         j < (i * 3) + 3 && j < items.length;
//                         j++)
//                       Expanded(
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: FadeInImage.assetNetwork(
//                                 placeholder: "assets/logo.png",
//                                 image: "${imgUrl + value[j]["BNR"]}",
//                                 height: 100,
//                                 placeholderFit: BoxFit.scaleDown,
//                                 fit: BoxFit.scaleDown,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               )
//           ]));
//         }
//       });

//       setState(() {
//         dataz = rajux;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   BannerAd? _bannerAd;

//   void _loadAd() {
//     final bannerAd = BannerAd(
//       size: widget.adSize,
//       adUnitId: widget.adUnitId,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           if (!mounted) {
//             ad.dispose();
//             return;
//           }
//           setState(() {
//             _bannerAd = ad as BannerAd;
//           });
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, error) {
//           print("ttyyy$error");
//           debugPrint('BannerAd failed to load: $error');
//           ad.dispose();
//         },
//       ),
//     );

//     // Start loading.
//     bannerAd.load();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadAd();
//     featchdata();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: Container(
//           height: widget.adSize.height.toDouble(),
//           child: _bannerAd == null
//               // Nothing to render yet.
//               ? SizedBox()
//               // The actual ad.
//               : AdWidget(ad: _bannerAd!),
//         ),
//         appBar: AppBar(
//           toolbarHeight: 80,
//           backgroundColor: Colors.transparent,
//           centerTitle: false,
//           actions: [
//             Icon(
//               Icons.emoji_events,
//               color: Colors.white,
//               size: 40,
//             ),
//             Icon(
//               Icons.person,
//               color: Colors.white,
//               size: 40,
//             ),
//           ],
//           leadingWidth: 0,
//           title: Align(
//             alignment: Alignment.topLeft,
//             child: Image.asset(
//               "assets/logo.png",
//               height: 50,
//             ),
//           ),
//         ),
//         body: dataz.length < 1
//             ? Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//                 child: Column(
//                   children: dataz,
//                 ),
//               ));
//   }
// }
