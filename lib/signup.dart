import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cinemagicx/firstp.dart';
import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/sub.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';
import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LevelPlayNativeAdListenerClass with LevelPlayNativeAdListener {
  @override
  void onAdLoaded(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    print("ima loafeddd\n\n\n");
  }

  @override
  void onAdLoadFailed(LevelPlayNativeAd? nativeAd, IronSourceError? error) {
    print("----->eroor");

    print(error);

    print("----->eroor");

    // Invoked when the native ad loading process has failed.
  }

  @override
  void onAdImpression(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    // Invoked each time the first pixel is visible on the screen
  }

  @override
  void onAdClicked(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    // Invoked when end user clicked on the native ad
  }
}

class MySignUp extends StatefulWidget {
  MySignUp({
    super.key,
  });

  @override
  State<MySignUp> createState() => _MySignUpState();
}

// 005EEA border 0381E9 btn

class _MySignUpState extends State<MySignUp> {
  bool isclick = false;
  final picker = ImagePicker();
  File? profilepic;

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController nname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  Future<void> pickImagex(String imgx) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    final dg = await pickedImage?.readAsBytes();

    Uint8List cx = dg != null ? dg : Uint8List(0);

    print(await uploadfile(cx));

    if (pickedImage != null) {
      setState(() {
        print(pickedImage.path);

        switch (imgx) {
          case 'profilepic':
            profilepic = File(pickedImage.path);
            break;
        }
      });
    }
  }

  // Future<void> uploadImage(File file) async {
  //   final Uri serverUri = Uri.parse("$backendurl/upload");
  // final http.MultipartRequest request =
  //     http.MultipartRequest('POST', serverUri);

  //   request.files.add(await http.MultipartFile.fromPath('file', file.path));

  //   try {
  //     final http.Response response =
  //         await http.Response.fromStream(await request.send());
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   } catch (error) {
  //     print('Error uploading image: $error');
  //   }
  // }

  String dp = "1725910393851.jpg";
  String id = "";

  int rt = 0;

  Future<void> updat() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.post(Uri.parse('$backendurl/profileupdate'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "_id": prefs.getString("_id"),
            "dp": dp,
            "name": nname.text,
            "email": email.text
          }));

      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: Icon(Icons.done, color: Colors.white),
          content: Text("Update Complete..."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("close"))
          ],
        ),
      );

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setu() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString("_id")!;

    try {
      var response =
          await http.get(Uri.parse('$backendurl/profileupdate?_id=' + id));

      final rtc = jsonDecode(response.body);

      print(rtc);
      nname.text = rtc["name"];
      textEditingController.text = "${rtc["rc"] ?? 0} Referred";

      email.text = rtc["email"];
      dp = rtc["dp"];

      phone.text = rtc["phone"];
    } catch (e) {
      print(e);
    }

    DateTime currentUtc = DateTime.now().toUtc();

    DateTime givenUtc = DateTime.fromMillisecondsSinceEpoch(
        prefs.getInt("sub") ?? 0,
        isUtc: true);

    if (givenUtc.isAfter(currentUtc)) {
      rt = givenUtc.difference(currentUtc).inDays;
    }

    setState(() {});
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String?> uploadfile(Uint8List bytes,
      {String fileName = "x.jpg"}) async {
    const url = '$backendurl/upload';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    var filey = http.MultipartFile.fromBytes("file", bytes, filename: fileName);

    request.files.add(filey);

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final up = jsonDecode(await response.stream.bytesToString());

        dp = up["name"];

        setState(() {});
        return up["name"];
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setu();
  }

  TextEditingController textEditingController =
      TextEditingController(text: "0 Referred");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      title: Text(
                        "Refer  And Earn",
                        style: TextStyle(fontSize: 14),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: textEditingController,
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                fillColor: Colors.black,
                                filled: true,
                                suffixIcon: Icon(
                                  Icons.copy,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            _launchURL("https://cinemagicx.com/ref.php?id=$id");
                          },
                          child: Text("Claim Reward"),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await Share.share("$backendurl/invite?d=$id");
                            },
                            child: Text("Share"))
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Container(
                color: Colors.white,
                height: 1,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        children: [
                          ClipOval(
                            child: FadeInImage.assetNetwork(
                              placeholder: "assets/logo.png",
                              image: "$imgUrl/$dp",
                              width: 120,
                              height: 120,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          Positioned(
                              top: 80,
                              left: 80,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  pickImagex("profilepic");
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nname,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 38, 15, 240)),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 38, 15, 240)),
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "e.g:rajahasda@gmail.com",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 120, 118, 110))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Email ID :",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: email,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 38, 15, 240)),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 38, 15, 240)),
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "e.g:demo@gmail.com",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 120, 118, 110))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "User Name :",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    readOnly: true,
                    controller: phone,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 38, 15, 240)),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 38, 15, 240)),
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "e.g:+91 9876543210",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 120, 118, 110))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          updat();
                        },
                        child: Text("Update Details")),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();

                          sp.clear();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MySpalash(),
                              ));
                        },
                        icon: Icon(
                          Icons.logout,
                        ),
                        label: Text("Logout"),
                      ),
                      rt > 0
                          ? Text(
                              "$rt Days Left\nSubcription",
                              textAlign: TextAlign.center,
                            )
                          : ElevatedButton.icon(
                              onPressed: () async {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Subx(),
                                    ));
                              },
                              icon: Icon(
                                Icons.emoji_events,
                              ),
                              label: Text("Subscribe"),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          _launchURL("https://cinemagicx.com/term-of-use.html");
                        },
                        child: Text("Terms & Conditions")),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            _launchURL(
                                "https://cinemagicx.com/privacy-policy.html");
                          },
                          child: Text("Privacy Policy")),
                      TextButton(
                          onPressed: () {
                            _launchURL("https://cinemagicx.com/refund.html");
                          },
                          child: Text("Refund Policy")),
                    ],
                  )
                ]),
          ),
        ));
  }
}
