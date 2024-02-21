import 'package:flutter/material.dart';

class Screen9 extends StatefulWidget {
  const Screen9();
  @override
  State<Screen9> createState() => ri();
}

class ri extends State<Screen9> {
  bool btn1 = false;
  bool btn2 = false;
  bool btn3 = true;

  @override
  Widget build(BuildContext context) {
    double xheight = MediaQuery.of(context).size.height;
    double xwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(children: [
        Container(
            height: xheight,
            width: xwidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffFF0000),
                Color(0xff9E005D),
                Color(0xff662D91)
              ], stops: [
                0.02,
                0.4,
                1
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            )),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: xheight * 0.03,
              ),
              const Image(
                image: AssetImage("image/fwm.png"),
              ),
              SizedBox(
                height: xheight * 0.03,
              ),
              Image(
                image: AssetImage("image/s9.png"),
              ),
              const Text(
                "Hello, Let's Create Your Profilex!",
                style: TextStyle(
                    color: Color(0xffE5E5E5),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Just fill in the fields below, and we'll get a new",
                style: TextStyle(
                    color: Color(0xffE5E5E5),
                    fontSize: 11,
                    fontFamily: "Montserrat"),
              ),
              const Text(
                "account set up for you in no time.",
                style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontSize: 11,
                    fontFamily: "Montserrat"),
              ),
              SizedBox(
                height: xheight * 0.03,
              ),
              const Text(
                "Select Gender",
                style: TextStyle(
                    color: Color(0xffE5E5E5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: xheight * 0.02,
              ),
              FilledButton(
                  onPressed: () {
                    setState(() {
                      btn1 = true;
                      btn2 = false;
                      btn3 = false;
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        btn1 ? Color(0xffFD0606) : Color(0xffF0FFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Container(
                    width: xwidth * 0.4,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Man",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Comfortoo",
                            color: btn1 ? Color(0xffFFFFFF) : Color(0x803D3939),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              SizedBox(
                height: xheight * 0.01,
              ),
              FilledButton(
                  onPressed: () {
                    setState(() {
                      btn1 = false;
                      btn2 = true;
                      btn3 = false;
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        btn2 ? Color(0xffFD0606) : Color(0xffF0FFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Container(
                    width: xwidth * 0.4,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Woman",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Comfortoo",
                            color: btn2 ? Color(0xffFFFFFF) : Color(0x803D3939),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              SizedBox(
                height: xheight * 0.01,
              ),
              FilledButton(
                  onPressed: () {
                    setState(() {
                      btn1 = false;
                      btn2 = false;
                      btn3 = true;
                    });
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        btn3 ? Color(0xffFD0606) : Color(0xffF0FFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Container(
                    width: xwidth * 0.4,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Other",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Comfortoo",
                            color: btn3 ? Color(0xffFFFFFF) : Color(0x803D3939),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xffFD0606),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: SizedBox(
                  height: 40,
                  width: xwidth * 0.2,
                  child: const Center(
                    child: Text(
                      "Next",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: xheight * 0.03,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
