import 'dart:convert';
import 'dart:io';

import 'package:cinemagicx/videox.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'raju.dart';

class Vatchlist extends StatefulWidget {
  @override
  _VatchlistSt createState() => _VatchlistSt();
}

class _VatchlistSt extends State<Vatchlist> {
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
          title: Text('WatchLatter Videos'),
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
                itemCount: (prefs?.getStringList("watch") ?? []).length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> dtx = jsonDecode(prefs?.getString(
                          prefs?.getStringList("watch")![index] ?? "{}") ??
                      "{}");

                  print(dtx);

                  return Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return VideoX(
                              idx: dtx["_id"],
                            );
                          },
                        );
                      },
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  width: 120,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: "assets/loader.gif",
                                    image: "${imgUrl + "/" + dtx["BNR"]}",
                                    width: 120,
                                    placeholderFit: BoxFit.scaleDown,
                                    placeholderScale: .2,
                                    fit: BoxFit.scaleDown,
                                  ),
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
                                            final op =
                                                prefs?.getStringList("watch") ??
                                                    [];

                                            op.remove("${dtx["_id"]}");

                                            await prefs?.setStringList(
                                                "watch", op);

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
