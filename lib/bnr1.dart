import 'package:cinemagicx/bnr2.dart';
import 'package:cinemagicx/login.dart';
import 'package:flutter/material.dart';

class Bnr1 extends StatefulWidget {
  const Bnr1({super.key});

  @override
  State<Bnr1> createState() => Bnr1X();
}

// 005EEA border 0381E9 btn

class Bnr1X extends State<Bnr1> {
  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
            child: const Text("skip"),
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const MyLogin(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              ));
            },
          ),
        ),
      ),
      const Spacer(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Image.asset(
          "assets/bnr.png",
          fit: BoxFit.scaleDown,
          height: 300,
        ),
      ),
      const Spacer(),
      const Text(
        "Unlimited \nMovies,\nShows & More",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xff1AC8FF),
          fontSize: 30,
          fontFamily: "Antonio",
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xff1AC8FF))),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const Bnr2(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ));
          },
          style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 8),
            child: Text(
              "NEXT",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      const Spacer(),
    ]));
  }
}
