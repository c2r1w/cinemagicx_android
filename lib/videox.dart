import 'dart:async';
import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/xman.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

//

class VideoX extends StatefulWidget {
  String idx = "";

  VideoX({super.key, this.idx = ""});

  @override
  State<VideoX> createState() => VideoXX();
}

// 005EEA border 0381E9 btn

class VideoXX extends State<VideoX> {
  int expandedTileIndex = -1;

  Map<String, dynamic> data = {};
  List<Widget> dataz = [];

  int adstype = 0;

  int Changetx = 10;

  ChewieController? _controllerx;
  ChewieController? _controllerxads;
  bool playp = false;

  Future<void> featchdata() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$backendurl/createvideo?limit=10&on=_id&pro=TITLE,BNR&search=${widget.idx}'),
        headers: {"Content-Type": "application/json"},
      );

      final tgp = jsonDecode(response.body);

      data = tgp["vdo"];

      if (tgp["ads"] != null) {
        if (tgp["ads"]["name"] == "Google ADS") {
          adstype = 1;
        } else if (tgp["ads"]["name"] == "Blank ADS") {
          adstype = 0;
        } else {
          print(tgp["ads"]);
          final tyhx = await http.get(
            Uri.parse(
                'https://playback.dacast.com/content/access?contentId=${tgp["ads"]["vid"]}&provider=universe'),
            headers: {"Content-Type": "application/json"},
          );

          final hlsx = jsonDecode(tyhx.body);

          print(hlsx);

          if (hlsx["hls"] != null) {
            final _controllerz = VideoPlayerController.networkUrl(
              Uri.parse(hlsx["hls"]),
            );
            await _controllerz.initialize();

            _controllerxads = ChewieController(
                videoPlayerController: _controllerz,
                aspectRatio: _controllerz.value.aspectRatio,
                looping: true,
                showControls: false);
          }
          adstype = 2;
        }
      }

      final tyh = await http.get(
        Uri.parse(
            'https://playback.dacast.com/content/access?contentId=${data["VIDEOID"]}&provider=universe'),
        headers: {"Content-Type": "application/json"},
      );

      final hls = jsonDecode(tyh.body);

      if (hls["hls"] == null) {
        print("object");
        return;
      }
      final _controller = VideoPlayerController.networkUrl(
        Uri.parse(hls["hls"]),
      );
      await _controller.initialize();

      _controllerx = ChewieController(
          videoPlayerController: _controller,
          aspectRatio: _controller.value.aspectRatio,
          looping: true,
          customControls: CupertinoControls(
            backgroundColor: Colors.black12,
            iconColor: Colors.white,
          ));

      setState(() {});
    } catch (d) {
      print(d);
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
    final fpx = MediaQuery.of(context).size.height;

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
        foregroundColor: Colors.white,
        title: Image.asset(
          "assets/logo.png",
          height: 50,
        ),
      ),
      body: _controllerx == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  color: Colors.black,
                  height: fpx * .3,
                  child: Stack(
                    children: [
                      playp
                          ? Chewie(
                              controller: adstype == 2
                                  ? _controllerxads!
                                  : _controllerx!)
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                FadeInImage.assetNetwork(
                                    placeholder: "assets/logo.png",
                                    image: "${imgUrl + data["BNR"]}"),
                                Center(
                                    child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      (adstype == 2
                                              ? _controllerxads!
                                              : _controllerx!)
                                          .play();

                                      if (adstype == 2) {
                                        Timer.periodic(
                                            Duration(seconds: Changetx),
                                            (timer) {
                                          setState(() {
                                            adstype -= 1;
                                          });
                                          if (Changetx == 0) {
                                            setState(() {
                                              adstype = 0;
                                            });
                                            timer.cancel();
                                          }
                                        });
                                      }

                                      // _controllerx?.play();
                                      playp = true;
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/rtzx.gif",
                                    height: 100,
                                    width: 100,
                                  ),
                                )),
                                Center(
                                    child: Icon(
                                  Icons.play_circle_fill,
                                  fill: 0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 15,
                                )),
                              ],
                            ),
                      Align(
                        alignment: Alignment(.8, .9),
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                                "Skip ${Changetx != 0 ? "in $Changetx s" : ""}")),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Story",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "${data["DESCRIPTION"]}\n\n",
                          style: TextStyle(fontSize: 11),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text.rich(TextSpan(
                                  text: "DIRECTOR",
                                  style: TextStyle(fontSize: 15),
                                  children: [
                                    TextSpan(
                                        text: "\n${data["DIRECTOR"]}",
                                        style: TextStyle(fontSize: 13))
                                  ])),
                            ),
                            Flexible(
                              child: Text.rich(TextSpan(
                                  text: "CAST",
                                  style: TextStyle(fontSize: 15),
                                  children: [
                                    TextSpan(
                                        text: "\n${data["CAST"]}",
                                        style: TextStyle(fontSize: 13))
                                  ])),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text.rich(TextSpan(
                                  text: "DIRECTOR",
                                  style: TextStyle(fontSize: 15),
                                  children: [
                                    TextSpan(
                                        text: "\n${data["DIRECTOR"]}",
                                        style: TextStyle(fontSize: 13))
                                  ])),
                            ),
                          ],
                        )
                      ]),
                )
              ],
            ),
    );
  }

  @override
  void dispose() {
    _controllerx?.videoPlayerController.dispose();
    _controllerx?.dispose();

    _controllerxads?.videoPlayerController.dispose();
    _controllerxads?.dispose();

    super.dispose();
  }
}
