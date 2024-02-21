import 'dart:async';
import 'dart:convert';

import 'package:cinemagicx/raju.dart';
import 'package:cinemagicx/signup.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:pinput/pinput.dart';

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
    // try {
    //   var response = await http.post(Uri.parse('$backendurl/sendotp'),
    //       headers: {"Content-Type": "application/json"},
    //       body: jsonEncode({"number": _textEditingController.text}));

    //   print(response.body);
    //   if (response.body.contains("OTP SENT")) {
    //   } else {
    //     setState(() {
    //       isclick = false;
    //     });
    //   }
    // } catch (e) {
    //   print(e);
    // }

    Timer.periodic(const Duration(seconds: 3), (timmer) async {
      setState(() {
        timmer.cancel();

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return MySignUp();
        }));
      });
    });
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
            const Pinput(),

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
