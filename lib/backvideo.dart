// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:better_player/better_player.dart';
// import 'package:chewie/chewie.dart';
// import 'package:cinemagicx/dlist.dart';
// import 'package:cinemagicx/raju.dart';
// import 'package:cinemagicx/ratingx.dart';
// import 'package:cinemagicx/signup.dart';
// import 'package:cinemagicx/sub.dart';
// import 'package:cinemagicx/watchltr.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
// import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
// import 'package:flutter_hls_parser/flutter_hls_parser.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:ironsource_mediation/ironsource_mediation.dart';
// // import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'dart:math';
// // import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';
// import 'package:wakelock_plus/wakelock_plus.dart';
// //

// class DloadPrgs extends StatefulWidget {
//   final List<String> u;

//   final Map<String, dynamic> data;

//   DloadPrgs({required this.u, required this.data});

//   @override
//   _DloadPrgstate createState() => _DloadPrgstate();
// }

// class _DloadPrgstate extends State<DloadPrgs> {
//   int tx = 1;
//   List<String> ux = [];
//   int len = 0;

//   bool fixv = false;

//   late http.Client client;

//   Future<void> _downloadFile(String url, File outputFile) async {
//     try {
//       final response = await client.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         await outputFile.writeAsBytes(response.bodyBytes,
//             mode: FileMode.append);
//       } else {
//         throw 'Failed to download $url: ${response.reasonPhrase}';
//       }
//     } catch (e) {
//       throw 'Error downloading $url: $e';
//     }
//   }

//   Future<void> loopx() async {
//     Directory appDir = await getApplicationDocumentsDirectory();
//     final outputFile = File(appDir.path + "/" + widget.data["_id"] + ".ts");
//     print(appDir.path);
//     if (await outputFile.exists()) {
//       await outputFile.delete();
//     }

//     for (var i = 0; i < len; i++) {
//       print(i);
//       try {
//         await _downloadFile(ux[i], outputFile);
//       } catch (e) {
//         Navigator.pop(context);
//         break;
//       }

//       setState(() {
//         tx = i;
//       });
//     }

//     // Navigator.pop(context);
//     if (tx > len - 3) {
//       final outputFilex = File(appDir.path + "/" + widget.data["_id"] + ".jpg");

//       // await FFmpegKit.execute(
//       //     '-i ${appDir.path + "/" + widget.data["_id"]}.ts -c:v mpeg4 ${appDir.path + "/" + widget.data["_id"]}.mp4');

//       await _downloadFile("$imgUrl/${widget.data["BNR"]}", outputFilex);

//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       final op = prefs.getStringList("download") ?? [];

//       op.add(widget.data["_id"]);

//       await prefs.setStringList("download", op);

//       await prefs.setString(widget.data["_id"], jsonEncode(widget.data));

//       Navigator.pop(context);

//       await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text(
//             "Done",
//             textAlign: TextAlign.center,
//           ),
//           actionsAlignment: MainAxisAlignment.center,
//           content: Text("Download Compeleted", textAlign: TextAlign.center),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);

//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return DownloadedPage();
//                     },
//                   ));
//                   return;
//                 },
//                 child: Text("Close"))
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     ux = widget.u;

//     client = http.Client();

//     loopx();
//     setState(() {
//       len = ux.length;
//     });

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       // actionsAlignment: MainAxisAlignment.center,
//       title: Image.asset(
//         "assets/loader.gif",
//         width: 50,
//         height: 50,
//       ),
//       content: LinearProgressIndicator(
//         value: tx / len,
//       ),
//       actions: [
//         TextButton.icon(
//             onPressed: () {
//               client.close();
//             },
//             icon: Icon(Icons.timer_sharp),
//             label: Text("Cancel"))
//       ],
//     );
//   }
// }

// class VideoX extends StatefulWidget {
//   String idx = "";

// //showads
//   final AdSize adSize = AdSize.fullBanner;

//   final String adUnitId = Platform.isAndroid
//       ? 'ca-app-pub-4899021849652416/7371054139'
//       : 'ca-app-pub-4899021849652416/7520543235';
//   VideoX({super.key, this.idx = ""});

//   @override
//   State<VideoX> createState() => VideoXX();
// }

// // 005EEA border 0381E9 btn

// class VideoXX extends State<VideoX> with LevelPlayInterstitialListener {
//   bool rdeatc = true;

//   /*
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused) {
//       setState(() {
//         rdeatc = false;
//       });

//       // App is paused, store the video state
//     } else if (state == AppLifecycleState.resumed) {
//       // App is resumed, restore the video state

//       _controllerx?.dispose();

//       if (!rdeatc) {
//         _controllerrtx?.initialize().then((xgi) {
//           _controllerx = ChewieController(
//               videoPlayerController: _controllerrtx!,
//               looping: true,
//               autoPlay: true,
//               customControls: CupertinoControls(
//                 backgroundColor: Colors.black12,
//                 iconColor: Colors.white,
//               ));

//           // myideo = Chewie(controller: _controllerx!);

//           setState(() {
//             rdeatc = true;
//           });
//         });
//       }
//     }
//     super.didChangeAppLifecycleState(state);
//   }

// */

// //download
//   SharedPreferences? pref;
//   Timer? _timer;

//   // @override
//   // void dispose() {

//   //   _timer?.call();

//   //   super
//   //       .dispose();

//   // }

//   VideoPlayerController? _controllerrtx;

//   BetterPlayerController? _betterPlayerController;

//   Future<void> updateserverx({bool isstart = false, String adi = ""}) async {
//     print(adi);
//     if (pref == null) {
//       pref = await SharedPreferences.getInstance();
//     }

//     print("inside timer --> go${isstart.toString()} ing");

//     if (isstart) {
//       pref?.setInt("ct", 0);

//       _timer = Timer.periodic(Duration(minutes: 1), (timer) {
//         print("inside timer going");

//         if (_controllerx != null && _controllerx!.isPlaying) {
//           print("inside timer going to incaress");
//           pref?.setInt("ct",
//               ((pref?.getInt("ct") == null ? 0 : pref!.getInt("ct")!) + 5));
//         }
//       });
//     } else {
//       print("i dontknow====\n\n");
//       _timer?.cancel();
//       final response = await http.get(
//         Uri.parse(
//             '$backendurl/status?vid=${widget.idx}&adi=$adi&wt=${pref?.getInt("ct") ?? 0}'),
//         headers: {"Content-Type": "application/json"},
//       );

//       // _controllerx?.videoPlayerController.dispose();

//       _controllerx?.dispose();
//       // _controllerxads?.videoPlayerController.dispose();

//       _controllerxads?.dispose();
//     }
//   }

//   Future<void> updateads() async {
//     final response = await http.get(
//       Uri.parse('$backendurl/status?aid=${adsids}'),
//       headers: {"Content-Type": "application/json"},
//     );
//   }

//   Future<void> getHLSVideoUrls(Map<String, dynamic> data) async {
//     final pref = await SharedPreferences.getInstance();

//     final jo = pref.getStringList("download") ?? [];

//     if (jo.contains(data["_id"])) {
//       await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text("Already Exists"),
//           content: Text("File is Alredy in Your Downloaded List"),
//           actions: [
//             TextButton(
//                 onPressed: () => Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         updateserverx(adi: "open download");
//                         return DownloadedPage();
//                       },
//                     )),
//                 child: Text("goto download")),
//             TextButton(
//                 onPressed: () => Navigator.pop(context), child: Text("Close"))
//           ],
//         ),
//       );

//       return;
//     }

//     final tyh = await http.get(
//       Uri.parse(
//           'https://playback.dacast.com/content/access?contentId=${data["VIDEOID"]}&provider=universe'),
//       headers: {"Content-Type": "application/json"},
//     );

//     final hls = jsonDecode(tyh.body);

//     if (hls["hls"] == null) {
//       print("object");
//       return;
//     }

//     final fpxt = Uri.parse(hls["hls"]);

//     final response = await http.get(fpxt);

//     if (response.statusCode == 200) {
//       final playList =
//           await HlsPlaylistParser.create().parseString(fpxt, response.body);
//       playList as HlsMasterPlaylist;

//       final List<TextButton> lisx = [];

//       for (final element in playList.variants) {
//         if (element.format.height == null) {
//           continue;
//         }
//         lisx.add(TextButton(
//             onPressed: () async {
//               final bas = [...element.url.pathSegments];

//               bas.removeLast();

//               final basx = "https://" + element.url.host + "/" + bas.join("/");

//               final response = await http.get(element.url);

//               final playList = await HlsPlaylistParser.create()
//                   .parseString(element.url, response.body);

//               playList as HlsMediaPlaylist;

//               print(element.url);

//               List<String> lpx = [];

//               for (final element in playList.segments) {
//                 if (element.url == null) {
//                   continue;
//                 }
//                 lpx.add("$basx/${element.url}");
//               }

//               Navigator.pop(context);
//               showDialog(
//                 barrierDismissible: false,
//                 context: context,
//                 builder: (context) => DloadPrgs(u: lpx, data: data),
//               );

//               // setState(() {
//               //   print(element.url.pathSegments.last + "?" + element.url.query);

//               //   print("\n\n\nrrxrrr\n\n\n");

//               //   print(element.url);
//               //   fgh = element.url.path;
//               // });
//             },
//             child: Text("${element.format.height}p")));
//       }

//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(
//               "Select Quility",
//               textAlign: TextAlign.center,
//             ),
//             content: Column(mainAxisSize: MainAxisSize.min, children: lisx),
//           );
//         },
//       );
//     } else {
//       throw Exception('Failed to load HLS playlist');
//     }
//   }

//   int expandedTileIndex = -1;
//   //showads
//   BannerAd? _bannerAd;

//   Future<void> shareNetworkImage(String imageUrl, String text) async {
//     final http.Response response = await http.get(Uri.parse(imageUrl));

//     print(response.contentLength);

//     final Directory directory = await getTemporaryDirectory();

//     print(directory);

//     final File file = await File('${directory.path}/Image.png')
//         .writeAsBytes(response.bodyBytes);
//     await Share.shareXFiles(
//       [
//         XFile(file.path),
//       ],
//       text: text,
//     );
//   }

//   bool xtg = false;

// //showads
//   InterstitialAd? _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;

//   Map<String, dynamic> data = {};
//   List<Widget> dataz = [];

//   int adstype = 0;
//   String adsids = "";

//   int Changetx = 10;
//   int Changextxx = 10;

//   ChewieController? _controllerx;
//   ChewieController? _controllerxtrailer;
//   ChewieController? _controllerxads;

//   bool playp = false;
//   bool skiped = true;
//   Timer? tre;
//   void func() {
//     tre = Timer.periodic(Duration(seconds: 1), (tcc) {
//       setState(() {
//         Changetx--;
//       });
//       if (Changetx < 1) {
//         // _controllerx?.play();
//         tre?.cancel();
//         tcc?.cancel();
//       }
//     });
//   }

//   static final AdRequest request = AdRequest();

//   void _createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/1033173712'
//             : 'ca-app-pub-3940256099942544/4411468910',
//         request: request,
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             print('$ad loaded\n\mi  am   loadddddddddddddddddddddddd');

//             setState(() {
//               _interstitialAd = ad;
//               _numInterstitialLoadAttempts = 0;
//             });
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load  got errrrrrrrrrrrr: $error.');
//             _numInterstitialLoadAttempts += 1;
//             _interstitialAd = null;
//             if (_numInterstitialLoadAttempts < 1) {
//               _createInterstitialAd();
//             }
//           },
//         ));
//   }

//   void _showInterstitialAd() {
//     print(
//         'Im called: attempt to show interstitial before loaded.\n\n--------------------');

//     if (_interstitialAd == null) {
//       print(
//           'Warning: attempt to show interstitial before loaded.\n\n--------------------');

//       _controllerx?.play();

//       setState(() {
//         adstype = 0;
//       });

//       updateserverx(isstart: true, adi: "ads  faild ads");

//       return;
//     }

//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         setState(() {
//           adstype = 0;
//         });

//         updateserverx(isstart: true, adi: "ads dismiss");

//         _controllerx?.play();

//         ad.dispose();
//         // _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         setState(() {
//           adstype = 0;
//         });
//         _controllerx?.play();

//         updateserverx(isstart: true, adi: "ads faild");
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }

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

//   List<dynamic> serrios = [];

//   Future<void> featchdata() async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             '$backendurl/createvideo?limit=10&on=_id&pro=TITLE,BNR&search=${widget.idx}'),
//         headers: {"Content-Type": "application/json"},
//       );

//       print(response.body);
//       print(
//           "\nlololo\n${'$backendurl/createvideo?limit=10&on=_id&pro=TITLE,BNR&search=${widget.idx}'}\n\n");
//       xtg = true;
//       final tgp = jsonDecode(response.body);

//       print(tgp);

//       data = tgp["vdo"];

//       canplayx(data);

//       setState(() {});

//       if (tgp["ser"] != null) {
//         serrios = tgp["ser"];
//       }

//       if (tgp["ads"] != null) {
//         if (tgp["ads"]["name"] == "Google ADS") {
//           adstype = 1;
//           adsids = "Google ADS";
//         } else if (tgp["ads"]["name"] == "Blank ADS") {
//           adstype = 0;
//         } else {
//           print("===========");
//           print(tgp["ads"]);
//           print("===========");
//           Changetx = int.parse(tgp["ads"]["time"]);
//           adsids = "${tgp["ads"]["_id"]}";

//           final tyhx = await http.get(
//             Uri.parse(
//                 'https://playback.dacast.com/content/access?contentId=${tgp["ads"]["vid"]}&provider=universe'),
//             headers: {"Content-Type": "application/json"},
//           );

//           final hlsx = jsonDecode(tyhx.body);

//           print(hlsx);

//           if (hlsx["hls"] != null) {
//             final _controllerz = VideoPlayerController.networkUrl(
//               // Uri.parse("http://localhost:3000/uploads/x.mp4"),
//               Uri.parse(hlsx["hls"]),
//             );
//             await _controllerz.initialize();

//             _controllerxads = ChewieController(
//                 videoPlayerController: _controllerz,
//                 looping: true,
//                 showControls: false);
//           }
//           adstype = 2;

//           setState(() {});
//         }
//       }

//       final tyh = await http.get(
//         Uri.parse(
//             'https://playback.dacast.com/content/access?contentId=${data["VIDEOID"]}&provider=universe'),
//         headers: {"Content-Type": "application/json"},
//       );

//       final hls = jsonDecode(tyh.body);

//       if (hls["hls"] == null) {
//         print("object");
//         return;
//       }
//       _controllerrtx = VideoPlayerController.networkUrl(
//         Uri.parse(hls["hls"]),
//         // Uri.parse("http://localhost:3000/uploads/x.mp4"),
//       );

//       await _controllerrtx!.initialize();

//       _controllerx = ChewieController(
//           videoPlayerController: _controllerrtx!,
//           looping: true,
//           customControls: CupertinoControls(
//             backgroundColor: Colors.black12,
//             iconColor: Colors.white,
//           ));

//       setState(() {});
//     } catch (d) {
//       print(d);
//     }
//   }

//   bool isinpaidlist = false;
//   bool hassub = false;

//   var cfPaymentGatewayService = CFPaymentGatewayService();

//   Future<void> updat(String daysx) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     final ad24 = DateTime.now().millisecondsSinceEpoch + (24 * 60 * 60 * 1000);

//     // final ad24 = DateTime.now().millisecondsSinceEpoch + (60 * 1000);

//     List<String> rntx = prefs.getStringList("rent") ?? [];
//     List<String> rnt = prefs.getStringList("rent") ?? [];

//     //.contains(widget.idx);

//     rntx.forEach((yi) {
//       if (yi.contains(widget.idx)) {
//         rnt.remove(yi);
//       }
//     });

//     rnt.add(daysx + "|$ad24");

//     await prefs.setStringList("rent", rnt);

//     try {
//       var response = await http.post(Uri.parse('$backendurl/profileupdate'),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode({
//             "_id": prefs.getString("_id"),
//             "rent": rnt,
//           }));

//       print("$backendurl/profileupdate");
//       print(jsonEncode({
//         "_id": prefs.getString("_id"),
//         "rent": rnt,
//       }));

//       print(response.body);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> webCheckout() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     int amt = data["price"];
//     try {
//       cfPaymentGatewayService.setCallback((datac) async {
//         print(datac);

//         // showDialog(
//         //   barrierDismissible: false,
//         //   context: context,
//         //   builder: (context) => AlertDialog(
//         //     title: Icon(
//         //       Icons.local_dining,
//         //       color: Colors.white,
//         //     ),
//         //     content: Text("Please Wait..."),
//         //   ),
//         // );

//         await updat(widget.idx);
//         print("parches compelete");

//         await showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Icon(Icons.done, color: Colors.white),
//             content: Text("Purchase Complete..."),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text("close"))
//             ],
//           ),
//         );

//         canplayx(data);
//         setState(() {});
//         Navigator.pop(context);
//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => VideoX(
//                 idx: widget.idx,
//               ),
//             ));
//       }, (err, rr) {
//         print("parches failed");

//         showDialog(
//           barrierDismissible: false,
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Icon(
//               Icons.warning,
//               color: Colors.white,
//             ),
//             content: Text("Purchase Failed..."),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text("close"))
//             ],
//           ),
//         );
//         print(err.getMessage());
//         print(rr);
//       });
//       var response = await http.post(Uri.parse('$backendurl/checkout'),
//           headers: {"Content-Type": "application/json"},
//           body: jsonEncode({
//             "phone": prefs.getString("phone"),
//             "amt": amt,
//             "_id": prefs.getString("_id")
//           }));

//       print(response.body);
//       final rtc = jsonDecode(response.body);
//       CFEnvironment environment = CFEnvironment.PRODUCTION;
//       var session = CFSessionBuilder()
//           .setEnvironment(environment)
//           .setOrderId(rtc["order_id"])
//           .setPaymentSessionId(rtc["payment_session_id"])
//           .build();
//       var theme = CFThemeBuilder()
//           .setNavigationBarBackgroundColorColor("#ffffff")
//           .setNavigationBarTextColor("#ffffff")
//           .build();

//       var cfWebCheckout = CFWebCheckoutPaymentBuilder()
//           .setSession(session!)
//           .setTheme(theme)
//           .build();
//       cfPaymentGatewayService.doPayment(cfWebCheckout);
//     } catch (e) {
//       print(e);
//     }
//   }

//   bool cansub = false;
//   bool canbuy = false;
//   bool canplay = false;

//   int gh = 10;

//   void canplayx(data) {
//     if (data["typex"] == "Paid+Subscription") {
//       if (!(isinpaidlist || hassub)) {
//         cansub = true;
//         canbuy = true;
//         return;
//       }
//     } else if (data["typex"] == "Paid") {
//       if (!(isinpaidlist)) {
//         canbuy = true;
//         return;
//       }
//     } else if (data["typex"] == "Subscription") {
//       if (!(hassub)) {
//         cansub = true;
//         return;
//       }
//     }

//     canplay = true;
//   }

//   Future<void> showxxad() async {
//     print(iads ? "rads------------>" : "gads----------->|---->");
//     iads ? await IronSource.showInterstitial() : _showInterstitialAd();

//     // await Timer.periodic(Duration(seconds: 2), (callback) {
//     //   print("im testdata$data");
//     //   callback.cancel();
//     // });

//     // });
//   }

//   Future<void> showaler() async {
//     return await showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Icon(
//                 Icons.emoji_events,
//                 color: Colors.white,
//               ),
//               content: Text(
//                 "This is A Primium Content\n  ${cansub && canbuy ? " You Can Rent only This \nOR\n You Can Subscribe" : cansub ? "You Have To Subscribe" : "You can only watch this by renting it"}",
//                 textAlign: TextAlign.center,
//               ),
//               actions: [
//                 canbuy
//                     ? ElevatedButton(
//                         onPressed: () {
//                           webCheckout();
//                         },
//                         child: Text("Rent"))
//                     : SizedBox(),
//                 cansub
//                     ? ElevatedButton(
//                         onPressed: () async {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Subx(),
//                               ));
//                         },
//                         child: Text("Subscribe"))
//                     : SizedBox()
//               ],
//             ));
//   }

//   Future<void> checksub() async {
//     SharedPreferences sp = await SharedPreferences.getInstance();

//     if (sp.getStringList("rent") != null) {
//       final hhj = sp.getStringList("rent") ?? [];

//       //.contains(widget.idx);

//       hhj.forEach((yi) {
//         if (yi.contains(widget.idx)) {
//           try {
//             if (int.parse(yi.split("|")[1]) -
//                     DateTime.now().millisecondsSinceEpoch >
//                 0) {
//               print("ican print view");
//               isinpaidlist = true;
//             }
//           } catch (e) {}
//         }
//       });
//     }

//     DateTime currentUtc = DateTime.now().toUtc();

//     DateTime givenUtc =
//         DateTime.fromMillisecondsSinceEpoch(sp.getInt("sub") ?? 0, isUtc: true);

//     if (givenUtc.isAfter(currentUtc)) {
//       hassub = true;
//     }
//     setState(() {});
//   }

//   bool iads = true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     setState(() {
//       Random random = Random();
//       // iads = random.nextBool();
//     });

//     //showads
//     IronSource.setLevelPlayInterstitialListener(this);
//     checksub();
//     featchdata();

//     _loadAd();

//     iads ? IronSource.loadInterstitial() : _createInterstitialAd();

//     WakelockPlus.enable();
//   }

//   late Offset _tapPosition;

//   double _rating = 0.0;

//   void _setRating(double rating) {
//     setState(() {
//       _rating = rating;
//     });
//   }

//   bool progrs = false;
//   bool progrsx = false;
//   bool progrsxx = false;

//   Future<void> sendvlog() async {
//     try {
//       final response = await http.get(
//         Uri.parse(
//             '$backendurl/createvideo?limit=10&on=_id&pro=TITLE,BNR&search=${widget.idx}'),
//         headers: {"Content-Type": "application/json"},
//       );
//     } catch (e) {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenSize = MediaQuery.of(context).size.width;

//     return Scaffold(
//       //showads
//       bottomNavigationBar: SizedBox(
//         height: widget.adSize.height.toDouble(),
//         //showads
//         child: _bannerAd == null
//             // Nothing to render yet.
//             ? SizedBox()
//             // The actual ad.
//             : Center(child: AdWidget(ad: _bannerAd!)),
//       ),

//       appBar: AppBar(
//         toolbarHeight: 80,
//         backgroundColor: Colors.transparent,
//         centerTitle: false,
//         actions: [
//           MenuAnchor(
//             menuChildren: [
//               MenuItemButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       updateserverx(adi: "open  profile");
//                       return MySignUp();
//                     }));
//                   },
//                   child: Text("Profile")),
//               MenuItemButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       updateserverx(adi: "open download");
//                       return DownloadedPage();
//                     }));
//                   },
//                   child: Text("Download List")),
//               MenuItemButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) {
//                       updateserverx(adi: "open watchlist");
//                       return Vatchlist();
//                     }));
//                   },
//                   child: Text("Watch Later")),
//             ],
//             builder: (context, controller, child) => IconButton(
//               onPressed: () {
//                 if (controller.isOpen) {
//                   controller.close();
//                 } else {
//                   controller.open();
//                 }
//               },
//               icon: Icon(
//                 Icons.person,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           )
//         ],
//         bottom: PreferredSize(
//             preferredSize: Size.fromHeight(1),
//             child: Container(
//               color: Colors.white,
//               height: 1,
//             )),
//         foregroundColor: Colors.white,
//         titleSpacing: 0,
//         title: Center(
//           child: Image.asset(
//             "assets/logo.png",
//             height: 40,
//           ),
//         ),
//       ),
//       body: !xtg
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: Container(
//                       color: Color(0xff071427),
//                       height: 250,
//                       child: Stack(
//                         children: [
//                           playp
//                               ? GestureDetector(
//                                   behavior: HitTestBehavior.translucent,
//                                   onTapDown: (details) =>
//                                       _tapPosition = details.globalPosition,
//                                   onDoubleTap: () {
//                                     final screenWidth =
//                                         MediaQuery.of(context).size.width;
//                                     final middle = screenWidth / 2;
//                                     if (_tapPosition.dx < middle &&
//                                         adstype == 0) {
//                                       print("Left");

//                                       final currentPosition = _controllerx
//                                           ?.videoPlayerController
//                                           .value
//                                           .position;
//                                       _controllerx?.seekTo(Duration(
//                                           seconds:
//                                               currentPosition!.inSeconds - 5));
//                                     } else if (adstype == 0) {
//                                       print("Right");
//                                       final currentPosition = _controllerx
//                                           ?.videoPlayerController
//                                           .value
//                                           .position;
//                                       _controllerx?.seekTo(Duration(
//                                           seconds:
//                                               currentPosition!.inSeconds + 5));
//                                     }
//                                   },
//                                   child: (_controllerx != null ||
//                                               _controllerxads != null) &&
//                                           rdeatc
//                                       ? Chewie(
//                                           controller: adstype == 2
//                                               ? _controllerxads!
//                                               : _controllerx!)
//                                       : SizedBox(),
//                                 )
//                               : Stack(
//                                   alignment: Alignment.center,
//                                   children: [
//                                     FadeInImage.assetNetwork(
//                                         placeholder: "assets/logo.png",
//                                         fit: BoxFit.cover,
//                                         image: "${imgUrl + data["BNR"]}"),
//                                     Center(
//                                         child: InkWell(
//                                       onTap: () {
//                                         if (!canplay) {
//                                           showaler();
//                                           return;
//                                         }

//                                         if (adstype == 2) {
//                                           func();
//                                         }

//                                         setState(() {
//                                           adstype == 2
//                                               ? _controllerxads?.play()
//                                               : adstype == 0
//                                                   ? _controllerx?.play()
//                                                   : "";

//                                           // _controllerx?.play();
//                                           playp = true;
//                                         });

//                                         if (adstype == 1) {
//                                           //showads
//                                           showxxad();
//                                         }
//                                       },
//                                       child: Image.asset(
//                                         "assets/rtzx.gif",
//                                         height: 100,
//                                         width: 100,
//                                       ),
//                                     )),
//                                     Center(
//                                         child: Icon(
//                                       Icons.play_circle_fill,
//                                       fill: 0,
//                                       color: Color.fromARGB(255, 255, 255, 255),
//                                       size: 15,
//                                     )),
//                                   ],
//                                 ),
//                           Visibility(
//                             visible: playp && skiped && adstype == 2,
//                             child: Align(
//                               alignment: Alignment(.8, .9),
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     if (Changetx == 0) {
//                                       setState(() {
//                                         skiped = false;
//                                         adstype = 0;
//                                       });

//                                       updateads();
//                                       updateserverx(
//                                           isstart: true, adi: "play btn");
//                                       _controllerxads?.pause();
//                                       _controllerxads?.videoPlayerController
//                                           .dispose();
//                                       _controllerxads?.dispose();
//                                       _controllerx?.play();
//                                     }
//                                   },
//                                   child: Text(
//                                       "Skip ${Changetx != 0 ? "in $Changetx s" : ""}")),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: 10,
//                   // ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             "${data["TITLE"]}",
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "${data["DURATION"]} | ${data["LANGUAGE"]} | ${data["YEAR"]}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 132, 9, 0)),
//                           ),
//                           Text.rich(TextSpan(
//                               text: "Ganere : ",
//                               children: [
//                                 TextSpan(
//                                     text: "${data["GENRE"]}",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.normal,
//                                         color: Colors.white))
//                               ],
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromARGB(255, 132, 9, 0)))),

//                           Row(
//                             children: [
//                               Text("Rating : ",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Color.fromARGB(255, 132, 9, 0))),
//                               ...List.generate(5, (index) {
//                                 return Icon(
//                                   data["xstar"] > index
//                                       ? Icons.star_rate
//                                       : Icons.star_border_outlined,
//                                   color: Color.fromARGB(255, 255, 149, 10),
//                                   size: 16,
//                                 );
//                               })
//                             ],
//                           ),
//                           // Text.rich(TextSpan(
//                           //     text: "Rating : ",
//                           //     children: [
//                           //       TextSpan(
//                           //           text: "★★★★☆",
//                           //           style: TextStyle(
//                           //               fontWeight: FontWeight.normal,
//                           //               color: Color.fromARGB(255, 255, 149, 10)))
//                           //     ],
//                           //     style: TextStyle(
//                           //         fontWeight: FontWeight.bold,
//                           //         color: Color.fromARGB(255, 132, 9, 0)))),

//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   FilledButton.icon(
//                                       icon: Icon(Icons.play_arrow),
//                                       onPressed: () {
//                                         setState(() {
//                                           gh = 100;
//                                         });

//                                         // _controllerx?.play();

//                                         if (!canplay) {
//                                           showaler();
//                                           return;
//                                         }

//                                         if (adstype == 2) {
//                                           func();
//                                         }

//                                         setState(() {
//                                           if (adstype == 2) {
//                                             _controllerxads?.play();
//                                           } else if (adstype == 0) {
//                                             updateserverx(
//                                                 isstart: true,
//                                                 adi: "play arrow");
//                                             _controllerx?.play();
//                                           }

//                                           // _controllerx?.play();

//                                           playp = true;
//                                         });

//                                         if (adstype == 1) {
//                                           //showads

//                                           print(iads
//                                               ? "rads------------>"
//                                               : "gads----------->|---->");

//                                           showxxad();
//                                         }
//                                       },
//                                       style: ButtonStyle(
//                                           backgroundColor:
//                                               WidgetStateProperty.all(
//                                                   Color.fromARGB(
//                                                       255, 230, 6, 6)),
//                                           shape: WidgetStateProperty.all<
//                                                   RoundedRectangleBorder>(
//                                               RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   side: BorderSide(
//                                                       width: 1,
//                                                       color: Colors.white)))),
//                                       label: Text(
//                                         canplay
//                                             ? "Play"
//                                             : canbuy
//                                                 ? "Rent ₹${data["price"]}"
//                                                 : "Subscribe",
//                                       )),
//                                   SizedBox(
//                                     width: 8,
//                                   ),
//                                   data["TRAILER"] == "" ||
//                                           data["TRAILER"] == null
//                                       ? SizedBox(
//                                           width: 10,
//                                         )
//                                       : FilledButton.icon(
//                                           icon: Icon(Icons.play_arrow),
//                                           onPressed: () async {
//                                             setState(() {
//                                               progrsx = true;
//                                             });

//                                             //

//                                             final tyh = await http.get(
//                                               Uri.parse(
//                                                   'https://playback.dacast.com/content/access?contentId=${data["TRAILER"]}&provider=universe'),
//                                               headers: {
//                                                 "Content-Type":
//                                                     "application/json"
//                                               },
//                                             );

//                                             final hls = jsonDecode(tyh.body);

//                                             if (hls["hls"] == null) {
//                                               print("object");

//                                               setState(() {
//                                                 progrsx = false;
//                                               });

//                                               return;
//                                             }

//                                             if (_controllerxtrailer == null) {
//                                               final _controller =
//                                                   VideoPlayerController
//                                                       .networkUrl(
//                                                 Uri.parse(hls["hls"]),
//                                                 // Uri.parse("http://localhost:3000/uploads/x.mp4"),
//                                               );
//                                               await _controller.initialize();

//                                               _controllerxtrailer =
//                                                   ChewieController(
//                                                       videoPlayerController:
//                                                           _controller,
//                                                       looping: true,
//                                                       autoPlay: true);
//                                             }
//                                             // setState(() {});

//                                             await showDialog(
//                                               barrierDismissible: false,
//                                               useRootNavigator: false,
//                                               context: context,
//                                               builder: (context) {
//                                                 return Stack(
//                                                   children: [
//                                                     Container(
//                                                       color: const Color(
//                                                           0xff071427),
//                                                     ),
//                                                     Chewie(
//                                                         controller:
//                                                             _controllerxtrailer!),
//                                                     IconButton(
//                                                         onPressed: () {
//                                                           setState(() {
//                                                             progrsx = false;
//                                                           });
//                                                           _controllerxtrailer
//                                                               ?.pause();
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         icon: Icon(
//                                                           Icons.close,
//                                                           color: Colors.white,
//                                                           size: 40,
//                                                         ))
//                                                   ],
//                                                 );
//                                               },
//                                             );

//                                             setState(() {
//                                               progrsx = false;
//                                             });
//                                             _controllerxtrailer?.pause();
//                                             ;
//                                           },
//                                           style: ButtonStyle(
//                                               padding: WidgetStateProperty.all(
//                                                   EdgeInsets.only(
//                                                       right: 20, left: 8)),
//                                               backgroundColor:
//                                                   WidgetStateProperty.all(
//                                                       Color.fromARGB(
//                                                           255, 6, 14, 171)),
//                                               shape: WidgetStateProperty.all<
//                                                       RoundedRectangleBorder>(
//                                                   RoundedRectangleBorder(
//                                                       borderRadius: BorderRadius.circular(8),
//                                                       side: BorderSide(width: 1, color: Colors.white)))),
//                                           label: progrsx
//                                               ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
//                                               : Text(
//                                                   "Trailer",
//                                                 ))
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           progrsxx = true;
//                                         });
//                                         shareNetworkImage(
//                                             "${imgUrl + data["BNR"]}",
//                                             "Watch  ${data["TITLE"]} On CinemagicX \n\n\n Download CinemagicX $backendurl/share?v=${data["_id"]} } ");
//                                         setState(() {
//                                           progrsxx = false;
//                                         });
//                                       },
//                                       icon: progrsxx
//                                           ? SizedBox(
//                                               height: 20,
//                                               width: 20,
//                                               child:
//                                                   CircularProgressIndicator())
//                                           : Icon(
//                                               Icons.ios_share,
//                                               color: Colors.white,
//                                             )),
//                                   IconButton(
//                                       onPressed: () {
//                                         showDialog(
//                                             context: context,
//                                             builder: (context) =>
//                                                 ReviewPagePopup(
//                                                     id: data["_id"]));
//                                       },
//                                       icon: Icon(
//                                         Icons.edit_note,
//                                         color: Colors.white,
//                                       )),
//                                   data["typex"].contains("Paid")
//                                       ? SizedBox()
//                                       : MenuAnchor(
//                                           builder:
//                                               (context, controller, child) =>
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         if (controller.isOpen) {
//                                                           controller.close();
//                                                         } else {
//                                                           controller.open();
//                                                         }
//                                                         //
//                                                       },
//                                                       icon: Icon(
//                                                         Icons.file_download,
//                                                         color: Colors.white,
//                                                       )),
//                                           menuChildren: [
//                                             MenuItemButton(
//                                               onPressed: () {
//                                                 if (!canplay) {
//                                                   showaler();
//                                                   return;
//                                                 }
//                                                 getHLSVideoUrls(data);
//                                               },
//                                               child: Text("Download"),
//                                             ),
//                                             MenuItemButton(
//                                               onPressed: () async {
//                                                 SharedPreferences sp =
//                                                     await SharedPreferences
//                                                         .getInstance();

//                                                 final jo =
//                                                     sp.getStringList("watch") ??
//                                                         [];

//                                                 if (jo.contains(data["_id"])) {
//                                                   await showDialog(
//                                                     context: context,
//                                                     builder: (context) =>
//                                                         AlertDialog(
//                                                       title: Text(
//                                                           "Already Exists"),
//                                                       content: Text(
//                                                           "File is Alredy in Your Watch List"),
//                                                       actions: [
//                                                         TextButton(
//                                                             onPressed: () =>
//                                                                 Navigator.push(
//                                                                     context,
//                                                                     MaterialPageRoute(
//                                                                   builder:
//                                                                       (context) {
//                                                                     updateserverx(
//                                                                         adi:
//                                                                             "go watch list");
//                                                                     return Vatchlist();
//                                                                   },
//                                                                 )),
//                                                             child: Text(
//                                                                 "goto WatchList")),
//                                                         TextButton(
//                                                             onPressed: () =>
//                                                                 Navigator.pop(
//                                                                     context),
//                                                             child:
//                                                                 Text("Close"))
//                                                       ],
//                                                     ),
//                                                   );

//                                                   return;
//                                                 }

//                                                 await sp.setString(data["_id"],
//                                                     jsonEncode(data));

//                                                 final op =
//                                                     sp.getStringList("watch") ??
//                                                         [];

//                                                 op.add(data["_id"]);

//                                                 await sp.setStringList(
//                                                     "watch", op);

//                                                 showDialog(
//                                                     context: context,
//                                                     builder: (context) {
//                                                       return AlertDialog(
//                                                         title: Text(
//                                                           "Done",
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                         ),
//                                                         actionsAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         content: Text(
//                                                             "Added to Watch Later List",
//                                                             textAlign: TextAlign
//                                                                 .center),
//                                                         actions: [
//                                                           TextButton(
//                                                               onPressed: () {
//                                                                 Navigator.pop(
//                                                                     context);

//                                                                 Navigator.push(
//                                                                     context,
//                                                                     MaterialPageRoute(
//                                                                   builder:
//                                                                       (context) {
//                                                                     updateserverx(
//                                                                         adi:
//                                                                             "add watchlist");
//                                                                     return Vatchlist();
//                                                                   },
//                                                                 ));
//                                                                 return;
//                                                               },
//                                                               child:
//                                                                   Text("Close"))
//                                                         ],
//                                                       );
//                                                     });
//                                               },
//                                               child: Text("Watch Later"),
//                                             )
//                                           ],
//                                         )
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text("Story",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Color.fromARGB(255, 255, 149, 10))),
//                           Text("${data["DESCRIPTION"]}"),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: screenSize * .4,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Director",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color.fromARGB(
//                                                 255, 255, 149, 10))),
//                                     Text("${data["DIRECTOR"]}"),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text("Producer",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color.fromARGB(
//                                                 255, 255, 149, 10))),
//                                     Text("${data['PRODUCER']}")
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: screenSize * .4,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Text("Director",
//                                     //     style: TextStyle(
//                                     //         fontWeight: FontWeight.bold,
//                                     //         color: Color.fromARGB(255, 255, 149, 10))),
//                                     // Text("${data["CAST"]}"),
//                                     // SizedBox(
//                                     //   height: 5,
//                                     // ),
//                                     Text("Cast",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Color.fromARGB(
//                                                 255, 255, 149, 10))),
//                                     Text(
//                                       "${data["CAST"]}",
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           // Container(
//                           //   padding: EdgeInsets.symmetric(horizontal: 5),
//                           //   child: Column(
//                           //       crossAxisAlignment: CrossAxisAlignment.start,
//                           //       children: [
//                           //         Text(
//                           //           "Story",
//                           //           style: TextStyle(fontSize: 15),
//                           //         ),
//                           //         Text(
//                           //           "${data["DESCRIPTION"]}",
//                           //           style: TextStyle(fontSize: 11),
//                           //         ),
//                           //         Row(
//                           //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //           children: [
//                           //             Flexible(
//                           //               child: Text.rich(TextSpan(
//                           //                   text: "DIRECTOR",
//                           //                   style: TextStyle(fontSize: 15),
//                           //                   children: [
//                           //                     TextSpan(
//                           //                         text: "\n${data["DIRECTOR"]}",
//                           //                         style: TextStyle(fontSize: 13))
//                           //                   ])),
//                           //             ),
//                           //             Flexible(
//                           //               child: Text.rich(TextSpan(
//                           //                   text: "CAST",
//                           //                   style: TextStyle(fontSize: 15),
//                           //                   children: [
//                           //                     TextSpan(
//                           //                         text: "\n${data["CAST"]}",
//                           //                         style: TextStyle(fontSize: 13))
//                           //                   ])),
//                           //             )
//                           //           ],
//                           //         ),
//                           //         SizedBox(
//                           //           height: 10,
//                           //         ),
//                           //         Row(
//                           //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           //           children: [
//                           //             Flexible(
//                           //               child: Text.rich(TextSpan(
//                           //                   text: "DIRECTOR",
//                           //                   style: TextStyle(fontSize: 15),
//                           //                   children: [
//                           //                     TextSpan(
//                           //                         text: "\n${data["DIRECTOR"]}",
//                           //                         style: TextStyle(fontSize: 13))
//                           //                   ])),
//                           //             ),
//                           //           ],
//                           //         ),
//                           serrios.lastOrNull != null
//                               ? DefaultTabController(
//                                   length: serrios.length,
//                                   child: SizedBox(
//                                     height: 200,
//                                     child: Scaffold(
//                                         appBar: TabBar(
//                                           tabs: List.generate(
//                                               serrios.length,
//                                               (index) =>
//                                                   Text(serrios[index]["_id"])),
//                                         ),
//                                         body: TabBarView(
//                                             children: List.generate(
//                                                 serrios.length, (indexx) {
//                                           return ListView.builder(
//                                             scrollDirection: Axis.horizontal,
//                                             itemCount:
//                                                 serrios[indexx]["DATA"].length,
//                                             itemBuilder: (context, indexzz) {
//                                               return Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: InkWell(
//                                                   onTap: () {
//                                                     Navigator.push(context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) {
//                                                       updateserverx(
//                                                           adi: "return vide");

//                                                       return VideoX(
//                                                           idx:
//                                                               "${serrios[indexx]["DATA"][indexzz]["_id"]}");
//                                                     }));
//                                                   },
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             8),
//                                                     child: FadeInImage
//                                                         .assetNetwork(
//                                                       placeholder:
//                                                           "assets/loader.gif",
//                                                       image:
//                                                           "${imgUrl + serrios[indexx]["DATA"][indexzz]["APP"]}",
//                                                       height: 100,
//                                                       fit: BoxFit.scaleDown,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                           // GridView.builder(
//                                           //   itemCount: serrios[indexx]["DATA"].length,
//                                           //   gridDelegate:
//                                           //       SliverGridDelegateWithFixedCrossAxisCount(
//                                           //           crossAxisCount: 3),
//                                           //   itemBuilder: (context, indexzz) {
//                                           //     return Text(
//                                           //         "${serrios[indexx]["DATA"][indexzz]["APP"]}");
//                                           //   },
//                                           // );
//                                         }))),
//                                   ),
//                                 )
//                               : SizedBox(),
//                           // ]),
//                           // ),
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     WakelockPlus.disable();
//     print("raju\n\n im deathxxxxxxx-->");

//     _timer?.cancel();
//     _controllerx?.videoPlayerController.dispose();

//     _controllerx?.dispose();

//     _controllerxads?.videoPlayerController.dispose();
//     _controllerxads?.dispose();

//     _controllerxtrailer?.videoPlayerController.dispose();
//     _controllerxtrailer?.dispose();

//     super.dispose();
//   }

//   @override
//   void onAdClicked(IronSourceAdInfo adInfo) {
//     print("raju\n\n im-->${mounted.toString()}<-- ads---onAdClicked-->$adInfo");
//   }

//   @override
//   void onAdClosed(IronSourceAdInfo adInfo) {
//     // print("raju\n\n im ads---onAdClosed-->$adInfo");
//     // if (_controllerx != null) {
//     //   print("raju help$_controllerx me im not null\n\n");
//     // } else {
//     //   print(" me im not null$_controllerx\n\n");

//     //   print(data);
//     // }
//     print("raju  now inside _controllerrtx");

//     _controllerrtx?.initialize().then((xgi) {
//       print("raju  now inside _controllerrtx");
//       _controllerx = ChewieController(
//           videoPlayerController: _controllerrtx!,
//           looping: true,
//           autoPlay: true,
//           customControls: CupertinoControls(
//             backgroundColor: Colors.black12,
//             iconColor: Colors.white,
//           ));

//       // myideo = Chewie(controller: _controllerx!);

//       setState(() {
//         rdeatc = true;
//       });
//     });
//     updateserverx(isstart: true, adi: "close ads");

//     // TODO: implement onAdClosed
//   }

//   @override
//   void onAdLoadFailed(IronSourceError error) {
//     print("raju\n\n im ads---onAdLoadFailed-->$error");

//     // TODO: implement

//     setState(() {
//       adstype = 0;
//     });
//     _controllerx?.play();
//     updateserverx(isstart: true, adi: "error ads");
//   }

//   @override
//   void onAdOpened(IronSourceAdInfo adInfo) {
//     print("raju\n\n im ads---onAdOpened-->$adInfo");

//     // TODO: implement onAdOpened
//   }

//   @override
//   void onAdReady(IronSourceAdInfo adInfo) {
//     print("raju\n\n im ads---onAdReady-->$adInfo");

//     // TODO: implement onAdReady
//   }

//   @override
//   void onAdShowFailed(IronSourceError error, IronSourceAdInfo adInfo) {
//     print("raju\n\n im ads---onAdS${mounted.toString()}-->$adInfo--->$error");

//     setState(() {
//       adstype = 0;
//     });
//     _controllerx?.play();

//     // TODO: implement onAdShowFailed
//   }

//   @override
//   void onAdShowSucceeded(IronSourceAdInfo adInfo) {
//     print("raju\n\n im ads---onAdSho${mounted.toString()}wSucceeded-->$adInfo");

//     // TODO: implement onAdShowSucceeded
//   }
// }
