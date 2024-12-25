import 'dart:async';
import 'dart:convert';

import 'package:cinemagicx/firstp.dart';
import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/signup.dart';
import 'package:cinemagicx/xman.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOtp extends StatefulWidget {
  String num;
  MyOtp({
    required this.num,
    super.key,
  });

  @override
  State<MyOtp> createState() => _MyOtpState();
}

// 005EEA border 0381E9 btn

class _MyOtpState extends State<MyOtp> {
  bool isclick = false;

  final TextEditingController _textEditingController = TextEditingController();

//login requests --> {"number":""}

  Future<void> sendotp(BuildContext ctx) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.post(Uri.parse('$backendurl/verifyotp'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {"phone": widget.num, "otp": _textEditingController.text}));

      print(jsonEncode(
          {"phone": widget.num, "otp": _textEditingController.text}));

      print(response.body);

      if (response.body.contains("_id")) {
        final rtc = jsonDecode(response.body);

        List<String> rent = [...rtc["rent"]];

        prefs.setString("_id", rtc["_id"]);
        prefs.setString("name", rtc["name"] ?? "");
        prefs.setString("email", rtc["email"] ?? "");
        prefs.setString("phone", rtc["phone"] ?? "");
        prefs.setString("dp", rtc["dp"] ?? "");
        prefs.setInt("sub", rtc["sub"] ?? 0);
        prefs.setStringList("rent", rent);

        rtc["ref"];

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MySpalash()),
          (Route<dynamic> route) => false,
        );
      } else {
        setState(() {
          isclick = false;
        });

        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Warning"),
                  content: Text("Otp Not Match"),
                ));
      }
    } catch (e) {
      print(e);
    }

    // Timer.periodic(const Duration(seconds: 3), (timmer) async {
    //   final prefh = await SharedPreferences.getInstance();

    //   await prefh.setBool("islogin", true);

    //   print(prefh.getBool("islogin"));
    //   setState(() {
    //     timmer.cancel();

    //     Navigator.pushReplacement(context,
    //         MaterialPageRoute(builder: (context) {
    //       return Xman();
    //     }));
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 60, right: 60),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Spacer(),
            Image.asset(
              "assets/logo.png",
              fit: BoxFit.scaleDown,
            ),
            const Text(
              "OTP Verification",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffFFAB6F),
                fontSize: 30,
                fontFamily: "Antonio",
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            const Text(
              "Enter the code from the sms we sent to",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff606268),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.num,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xff19C8FF), fontSize: 18),
            ),
            // OutlinedButton.icon(
            //   onPressed: () {},
            //   icon: Image.asset(
            //     "assets/google.png",
            //     fit: BoxFit.scaleDown,
            //     width: 30,
            //     height: 30,
            //   ),
            //   label: const Padding(
            //     padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: ),
            //     child: Text(
            //       "Sign With Google",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            //   style: const ButtonStyle(
            //       shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(5))))),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            const Spacer(),
            Pinput(
              length: 5,
              controller: _textEditingController,
            ),

            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: () {
                if (isclick) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.alarm,
                              size: 50,
                              color: Colors.white,
                            ),
                            Text(
                              "Please wait",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        actions: [
                          Center(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("OK")))
                        ],
                      );
                    },
                  );
                  // CoolAlert.show(
                  //   context: context,
                  //   type: CoolAlertType.custom,
                  //   backgroundColor: Colors.red,
                  //   confirmBtnColor: Colors.pink,
                  //   text: "Your transaction was successful!",
                  // );
                } else {
                  setState(() {
                    isclick = true;
                  });

                  sendotp(context);
                }

                // Navigator.of(context).push(PageRouteBuilder(
                //   pageBuilder: (context, animation, secondaryAnimation) =>
                //       const MyLogin(),
                //   transitionsBuilder:
                //       (context, animation, secondaryAnimation, child) {
                //     const begin = Offset(1.0, 0.0);
                //     const end = Offset.zero;
                //     const curve = Curves.ease;

                //     var tween = Tween(begin: begin, end: end)
                //         .chain(CurveTween(curve: curve));

                //     return SlideTransition(
                //       position: animation.drive(tween),
                //       child: child,
                //     );
                //   },
                // ));
              },
              style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: SizedBox(
                width: screenSize * .8,
                height: 50,
                child: Center(
                  child: isclick
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Color(0xff071427),
                          ),
                        )
                      : const Text(
                          "NEXT",
                          style: TextStyle(fontSize: 20),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            const Text(
              "help desk support : 943-113-1005 ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
          ]),
        ),
      ),
    );
  }
}
