import 'dart:async';
import 'dart:convert';

import 'package:cinemagicx/otp.dart';
import 'package:cinemagicx/raju.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

// 005EEA border 0381E9 btn

class _MyLoginState extends State<MyLogin> {
  bool isclick = false;

  final TextEditingController _textEditingController = TextEditingController();

//login requests --> {"number":""}

  Future<void> sendotp(BuildContext ctx) async {
    try {
      var response = await http.post(Uri.parse('$backendurl/sendotp'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"phone": _textEditingController.text}));

      print(response.body);
      if (response.body.contains("acknowledged")) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return MyOtp(
            num: _textEditingController.text,
          );
        }));
      } else {
        setState(() {
          isclick = false;
        });
      }
    } catch (e) {
      print(e);
    }

    // Timer.periodic(const Duration(seconds: 3), (timmer) async {
    //   setState(() {
    //     timmer.cancel();
    //     print("login requests send -->${jsonEncode({
    //           "number": _textEditingController.text
    //         })} ");

    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) {
    //   return MyOtp(
    //     num: _textEditingController.text,
    //   );
    // }));
    //   });
    // });
  }

  bool isindia = true;

  Future<void> rtd() async {
    final jjjj = await http.get(Uri.parse("http://ipinfo.io/"),
        headers: {"User-Agent": "curl/8.7.1"});

    print(jjjj.body);

    final kl = jsonDecode(jjjj.body);

    if (kl["country"] == "IN") {
      print("im india");
    } else {
      setState(() {
        isindia = false;
      });

      print("im innotdia");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rtd();
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 60, right: 60),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Spacer(),
            Image.asset(
              "assets/logo.png",
              fit: BoxFit.scaleDown,
            ),
            const Text(
              "Just You In",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff1AC8FF),
                fontSize: 30,
                fontFamily: "Antonio",
              ),
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
            Spacer(),
            TextFormField(
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              controller: _textEditingController,
              decoration: InputDecoration(
                label: Text(isindia ? "Mobile Number" : "Email Address",
                    style: TextStyle(color: Colors.white)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff005EEA))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff005EEA))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff005EEA))),
              ),
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
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.alarm,
                              size: 50,
                              color: Colors.white,
                            ),
                            Text(
                              "Please $isindia wait",
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
            Spacer(),
          ]),
        ),
      ),
    );
  }
}
