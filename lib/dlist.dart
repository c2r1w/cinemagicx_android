import 'dart:convert';
import 'dart:io';

import 'package:better_player/better_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VidplerPop extends StatefulWidget {
  final String urx;

  const VidplerPop({super.key, required this.urx});
  @override
  _VidplerPopState createState() => _VidplerPopState();
}

class _VidplerPopState extends State<VidplerPop> {
  Future<void> initializePlayer() async {
    // final tp = File(widget.urx + (Platform.isAndroid ? ".ts" : ".mp4"));

    // print("---->");
    // print(await tp.length());
    // print("---->");
    // final _videoPlayerController1 = VideoPlayerController.file(tp);

    print("object");

    // await _videoPlayerController1.initialize();

    print("object");

    // _chewieController =
    //     ChewieController(videoPlayerController: _videoPlayerController1);

    print("object");

    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _chewieController?.videoPlayerController.dispose();
    // _chewieController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff071427),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                // _chewieController?.pause();

                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              )),
        ),
        AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer.file(
                widget.urx + (Platform.isAndroid ? ".ts" : ".mp4")))
      ]),
    );
  }
}

class DownloadedPage extends StatefulWidget {
  @override
  _DownloadedState createState() => _DownloadedState();
}

class _DownloadedState extends State<DownloadedPage> {
  List<String> videoUrls = [];

  String fgh = "";

  String pat = "";

  SharedPreferences? prefs;

  Future<void> rtx() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    pat = appDir.path;

    print(pat);

    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    rtx();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double widthx = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff071427),
          foregroundColor: Colors.white,
          title: Text('Downloaded Videos'),
        ),
        body: Column(
          children: [
            Container(
              height: 1,
              width: widthx,
              color: Colors.white,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (prefs?.getStringList("download") ?? []).length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> dtx = jsonDecode(prefs?.getString(
                          prefs?.getStringList("download")![index] ?? "{}") ??
                      "{}");

                  print(dtx);

                  return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: InkWell(
                      onTap: () async {
                        // showDialog(
                        //   barrierDismissible: false,
                        //   context: context,
                        //   builder: (context) {
                        //     return VidplerPop(
                        //       urx: pat + "/" + dtx["_id"],
                        //     );
                        //   },
                        // // );
                        // print("=================\n\n=====================");
                        // VideoConverter()
                        //     .convertTsToMp4(pat + "/" + dtx["_id"] + ".ts",
                        //         pat + "/" + dtx["_id"] + ".mp4")
                        //     .then((onValue) {
                        //   print("=================\n\n=====================");
                        // });

                        showBottomSheet(
                          backgroundColor: const Color(0xff071427),
                          context: context,
                          builder: (context) => VidplerPop(
                            urx: pat + "/" + dtx["_id"],
                          ),
                        );

                        // try {
                        //   String result = await VideoConverter.convertTsToMp4(
                        //       pat + "/" + dtx["_id"] + ".mov",
                        //       pat + "/" + dtx["_id"] + ".ts");
                        //   print("Conversion successful: $result");
                        // } catch (e) {
                        //   print("Error during conversion: $e");
                        // }
                      },
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: Image.file(
                                  File(pat + "/" + dtx["_id"] + ".jpg"),
                                  width: 120,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: widthx - 150,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${dtx["TITLE"]}",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text("${dtx["GENRE"]} | ${dtx["DURATION"]}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(255, 132, 9, 0))),
                                  Row(
                                    children: [
                                      ...List.generate(5, (index) {
                                        return Icon(
                                          dtx["xstar"] > index
                                              ? Icons.star_rate
                                              : Icons.star_border_outlined,
                                          color:
                                              Color.fromARGB(255, 255, 149, 10),
                                          size: 16,
                                        );
                                      }),
                                      IconButton(
                                          onPressed: () async {
                                            final op = prefs?.getStringList(
                                                    "download") ??
                                                [];

                                            await File(pat +
                                                    "/" +
                                                    dtx["_id"] +
                                                    ".jpg")
                                                .delete();
                                            await File(pat +
                                                    "/" +
                                                    dtx["_id"] +
                                                    ".ts")
                                                .delete();

                                            op.remove("${dtx["_id"]}");

                                            await prefs?.setStringList(
                                                "download", op);

                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

// class VideoConverter {
//   static const platform = MethodChannel('com.example.converter');

//   Future<void> convertTsToMp4(String inputPath, String outputPath) async {
//     try {
//       print("object i am a good boy");
//       final String result = await platform.invokeMethod('convertTsToMp4', {
//         'inputPath': inputPath,
//         'outputPath': outputPath,
//       });
//       print(result);
//       print("object i am a good boy");
//     } on PlatformException catch (e) {
//       print("Failed to convert video: '${e.message}'.");
//     }
//   }
// }

// class VideoConverter {
//   static const MethodChannel _channel =
//       MethodChannel('com.shivalay.cinemagicx/video_converter');

//   static Future<String> convertTsToMp4(
//       String inputFilePath, String outputFilePath) async {
//     final String result = await _channel.invokeMethod('convertTsToMp4', {
//       'inputFilePath': inputFilePath,
//       'outputFilePath': outputFilePath,
//     });
//     return result;
//   }
// }
