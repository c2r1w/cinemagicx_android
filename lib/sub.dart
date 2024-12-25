import 'dart:convert';

import 'package:cinemagicx/firstp.dart';
import 'package:cinemagicx/raju.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Subx extends StatefulWidget {
  const Subx({Key? key}) : super(key: key);

  @override
  State<Subx> createState() => _SubxState();
}

class _SubxState extends State<Subx> {
  List<dynamic> data = [];

  Future<void> sendotp() async {
    try {
      var response = await http.get(Uri.parse('$backendurl/subx'));

      final rtc = jsonDecode(response.body);

      setState(() {
        data = rtc["data"];
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updat(int daysx) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    DateTime currentUtc = DateTime.now().toUtc();
    DateTime finalUtc;

    DateTime givenUtc = DateTime.fromMillisecondsSinceEpoch(
        prefs.getInt("sub") ?? 0,
        isUtc: true);

    if (givenUtc.isAfter(currentUtc)) {
      finalUtc = givenUtc.add(Duration(days: daysx));
    } else {
      finalUtc = currentUtc.add(Duration(days: daysx));
    }
    print(prefs.getKeys());

    await prefs.setInt("sub", finalUtc.millisecondsSinceEpoch);

    try {
      var response = await http.post(Uri.parse('$backendurl/profileupdate'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "_id": prefs.getString("_id"),
            "sub": finalUtc.millisecondsSinceEpoch,
          }));

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  var cfPaymentGatewayService = CFPaymentGatewayService();

  Future<void> webCheckout(int amt, int dat) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      cfPaymentGatewayService.setCallback((datac) async {
        print(datac);

        print("parches compelete");
        await updat(dat);

        await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Icon(Icons.done, color: Colors.white),
            content: Text("Purchase Complete..."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("close"))
            ],
          ),
        );

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MySpalash(),
            ),
            (v) => false);
      }, (err, rr) {
        print("parches failed");

        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Icon(
              Icons.warning,
              color: Colors.white,
            ),
            content: Text("Purchase Failed..."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("close"))
            ],
          ),
        );

        print(err.getMessage());
        print(rr);
      });

      var response = await http.post(Uri.parse('$backendurl/checkout'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "phone": prefs.getString("phone"),
            "amt": amt,
            "_id": prefs.getString("_id"),
            "data": "$dat",
            "rent": false
          }));

      final rtc = jsonDecode(response.body);
      CFEnvironment environment = CFEnvironment.PRODUCTION;
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(rtc["order_id"])
          .setPaymentSessionId(rtc["payment_session_id"])
          .build();
      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#ffffff")
          .setNavigationBarTextColor("#ffffff")
          .build();

      var cfWebCheckout = CFWebCheckoutPaymentBuilder()
          .setSession(session!)
          .setTheme(theme)
          .build();
      cfPaymentGatewayService.doPayment(cfWebCheckout);
    } catch (e) {
      print(e);
    }
  }

  int plan = 0;
  @override
  void initState() {
    super.initState();
    sendotp();
  }

  @override
  Widget build(BuildContext context) {
    // double xheight = MediaQuery.of(context).size.height;
    // double xwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text(
          "Upgrade Your Plans",
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(
              height: 1,
              color: Colors.white,
            )),
      ),
      body: Column(children: [
        Table(
          columnWidths: {
            0: const FlexColumnWidth(3),
            1: const FlexColumnWidth(1),
            2: const FlexColumnWidth(1),
            3: const FlexColumnWidth(1.5),
          },
          children: const [
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(""),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Silver',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Gold ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Diamond ',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Premium Content',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'HD Support',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Watch List',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Live Shows',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Unlimited Downloads',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'No Ads',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.check, color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              data.length,
              (index) => InkWell(
                onTap: () {
                  setState(() {
                    plan = index;
                  });
                  webCheckout(int.parse(data[index]["amount"]),
                      int.parse(data[index]["days"]));

                  // updat(2);
                },
                child: Container(
                  width: 130,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: plan == index ? Colors.deepPurple : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Save ${((1 - int.parse(data[index]["amount"]) / int.parse(data[index]["icon"])) * 100).toStringAsFixed(2)}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${data[index]["name"]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '₹ ${data[index]["icon"]}',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '₹  ${data[index]["amount"]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${data[index]["days"]} days',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
