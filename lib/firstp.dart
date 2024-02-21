import 'dart:async';

import 'package:cinemagicx/bnr1.dart';
import 'package:cinemagicx/bnr2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

      setState(() {
        timmer.cancel();

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            if (prefs.getBool("islogin") == true) {
              return Bnr1();
            } else {
              return Bnr2();
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
