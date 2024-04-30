import 'dart:async';

import 'package:cinemagicx/bnr1.dart';
import 'package:cinemagicx/bnr2.dart';
import 'package:cinemagicx/dlist.dart';
import 'package:cinemagicx/xman.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MySpalash extends StatefulWidget {
  const MySpalash({super.key});

  @override
  State<MySpalash> createState() => MySpalashX();
}

// 005EEA border 0381E9 btn

class MySpalashX extends State<MySpalash> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (timmer) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        final rt = await http.get(Uri.parse("https://google.com"));
      } catch (e) {
        if (prefs.getBool("islogin") == true) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Connection Problem",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "You Don't have a working Internet Connnection \n Will You Like to show Downloaded Videos..?",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text("Exit")),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return DownloadedPage();
                      }));
                    },
                    child: Text("Yes"))
              ],
            ),
          );
        } else {
          await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                      "Connection Problem",
                      textAlign: TextAlign.center,
                    ),
                    content: Text(
                      "You Don't have a working Internet Connnection..",
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: Text("Exit")),
                    ],
                  ));
        }

        setState(() {
          timmer.cancel();
        });

        return;
      }

      setState(() {
        timmer.cancel();

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            if (prefs.getBool("islogin") == true) {
              return Xman();
            } else {
              return Bnr1();
            }
          },
        ));
      });
    });

    super.initState();
  }

  bool showx = false;

  static final Tween<double> zeoone = Tween<double>(begin: 0.0, end: 1.0);

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
              TweenAnimationBuilder(
                  tween: zeoone,
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, child) {
                    if (value > .5) {
                      return SizedBox(
                        height: 70 * (value - .5),
                        width: 70 * (value - .5),
                        child: const CircularProgressIndicator(),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            ]),
      ),
    );
  }
}
