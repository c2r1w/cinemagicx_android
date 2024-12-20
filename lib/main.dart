import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cinemagicx/firstp.dart';
import 'package:cinemagicx/xman.dart';
import 'package:flutter/material.dart';
import 'package:cinemagicx/videox.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:chewie/chewie.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  // runApp(DevicePreview(
  //   enabled: true,
  //   builder: (context) {
  //     return const MyApp();
  //   },
  // ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final fgj = Uri.parse("http://x.com");
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: Typography.whiteCupertino,
          colorScheme: ColorScheme.fromSeed(
              primary: const Color(0xff005EEA),
              seedColor: const Color.fromARGB(255, 220, 54, 54),
              background: const Color(0xff071427)),
          useMaterial3: true,
        ),
        // home: HomePage());



    // home: DloadPrgs(
    //   u: fgj,
    // )


class LevelPlayNativeAdListenerClass with LevelPlayNativeAdListener {
  @override
  void onAdClicked(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    // TODO: implement onAdClicked
  }
}

class NotificationDemo extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _initializeNotifications(flutterLocalNotificationsPlugin);
            await _scheduleNotification(flutterLocalNotificationsPlugin);
          },
          child: Text('Schedule Notification'),
        ),
      ),
    );
  }

  Future<void> _initializeNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  final ranx = Random();

  Future<void> _scheduleNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'lol${ranx.nextInt(100)}', // Change this value for different channels
      'your_channel_name ${ranx.nextInt(100)}', // Change this value for different channels
      // Change this value for different channels
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Title', // Notification title
      'Body', // Notification body


}


  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    return Text("data");
  }
}









// class Examplex extends StatefulWidget {
//   const Examplex({super.key});

//   @override
//   State<Examplex> createState() => ExamplexX();
// }

// class ExamplexX extends State<Examplex> {
//   int star = 5;

//   @override
//   Widget build(BuildContext context) {
//     double screenSize = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           FilledButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return ReviewPagePopup();
//                   },
//                 );
//               },
//               child: Text("lol"))
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }

//   final channel = IOWebSocketChannel.connect('ws://127.0.0.1:5000');
//   final List<String> rtx = ["n"];
//   @override
//   void initState() {
//     super.initState();

//     channel.stream.listen(
//       (message) {
//         print(message);

//         setState(() {
//           rtx.add(message);
//         });
//       },
//       onError: (error) {},
//       onDone: () {
//         print('WebSocket connection closed');
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FilledButton(
//             onPressed: () {
//               channel.sink.add("lol");
//             },
//             child: Text("wertyu")),
//         ListView.builder(
//             itemCount: rtx.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return Align(
//                 alignment: index % 2 == 0
//                     ? Alignment.centerRight
//                     : Alignment.centerLeft,
//                 child: FractionallySizedBox(
//                   widthFactor: .7,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child:
//                         Container(color: Colors.red, child: Text(rtx[index])),
//                   ),
//                 ),
//               );
//             }),
//       ],
//     );
//   }
// }
// //  = jsonList.map((data) {
// //     return Container(
// //       width: data['width'].toDouble(),
// //       height: data['height'].toDouble(),
// //       color: Color(data['color']),
// //     );
// //   }).toList();
//   String jsonData = '''[
//   {
//     "name": "Alice Smith",
//     "age": 28,
//     "hex_color": "#7E57C2",
//     "profession": "Graphic Designer"
//   },
//   {
//     "name": "Bob Johnson",
//     "age": 35,
//     "hex_color": "#FF9800",
//     "profession": "Marketing Manager"
//   },
//   {
//     "name": "Eva Williams",
//     "age": 42,
//     "hex_color": "#009688",
//     "profession": "Data Scientist"
//   },
//   {
//     "name": "Charlie Davis",
//     "age": 30,
//     "hex_color": "#FF5722",
//     "profession": "Architect"
//   },
//   {
//     "name": "Grace Brown",
//     "age": 22,
//     "hex_color": "#673AB7",
//     "profession": "Student"
//   },
//   {
//     "name": "Daniel Miller",
//     "age": 45,
//     "hex_color": "#03A9F4",
//     "profession": "Financial Analyst"
//   },
//   {
//     "name": "Olivia Taylor",
//     "age": 32,
//     "hex_color": "#8BC34A",
//     "profession": "Teacher"
//   },
//   {
//     "name": "Henry Anderson",
//     "age": 40,
//     "hex_color": "#FFC107",
//     "profession": "Software Developer"
//   },
//   {
//     "name": "Sophia Garcia",
//     "age": 27,
//     "hex_color": "#9C27B0",
//     "profession": "HR Specialist"
//   },
//   {
//     "name": "Liam Martinez",
//     "age": 34,
//     "hex_color": "#E91E63",
//     "profession": "Product Manager"
//   }
// ]''';
//   List<Container> cards = [];

//   @override
//   void initState() {
//     super.initState();

//     List<dynamic> jsonList = json.decode(jsonData);

//     for (var element in jsonList) {
//       cards.add(Container(
//         alignment: Alignment.center,
//         child: Text(element["name"].toString()),
//         color: Colors.red,
//       ));
//     }
//     print(jsonList);

//     // final t = jsonList.map((data) {}).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Column(
//         children: cards,
//       )),
//     );
//   }
// }

// class Examplexxx extends StatelessWidget {
//   List<ClipRRect> cards = [
//     ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       child: Stack(
//         children: [
//           Center(
//             child: Image(
//               image: AssetImage("assets/bnr.png"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(color: Colors.black.withAlpha(200)),
//             height: 80,
//           )
//         ],
//       ),
//     ),
//     ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       child: Stack(
//         children: [
//           Container(
//             color: Colors.blue,
//             child: Image(
//               image: AssetImage("assets/bnr.png"),
//               fit: BoxFit.fill,
//               width: 300,
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(color: Colors.black.withAlpha(200)),
//             height: 80,
//           )
//         ],
//       ),
//     ),
//     ClipRRect(
//       borderRadius: BorderRadius.circular(15),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(color: Colors.black.withAlpha(200)),
//             height: 80,
//           )
//         ],
//       ),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           height: 500,
//           width: 350,
//           child: CardSwiper(
//             cardsCount: cards.length,
//             cardBuilder:
//                 (context, index, percentThresholdX, percentThresholdY) =>
//                     cards[index],
//           ),
//         ),
//       ),
//     );
//   }
// }
