import 'package:cinemagicx/xman.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

void main() {
  // runApp(DevicePreview(
  //   enabled: true,
  //   builder: (context) {
  //     return const MyApp();
  //   },
  // ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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

        // home: const MyHomePage(title: 'Flutter Demo Home Page'),

        home: Xman());
  }
}

class Examplex extends StatefulWidget {
  const Examplex({super.key});

  @override
  State<Examplex> createState() => ExamplexX();
}

class ExamplexX extends State<Examplex> {
  ChewieController? _controllerx;
  late Widget ty;

  bool st = false;
  Future<void> fth() async {
    final _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://dacastmmod-mmd-cust.lldns.net/127--1708088887--1708089007--692e9c05dab4a7caf2f7b149ab11463b/e5/7b127d5f-3b75-4c9c-ae84-7d7ddbd9c832/c22e8dc9-547c-47bd-8fba-eaaebc5ddb21/stream.ismd/manifest.m3u8?stream=a488aa56-1148-3f3e-f894-07267faa49a5_rendition%3B5fe1b2aa-8e27-6bee-14a6-b7e31ff540ee_rendition%3B092a7135-bf22-dfce-d960-be220d8ff73e_rendition'),
    );

    await _controller.initialize();

    _controllerx = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: _controller.value.aspectRatio,
        looping: true,
        customControls: CupertinoControls(
          backgroundColor: Colors.black12,
          iconColor: Colors.white,
        ));

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fth();

    // _controller.addListener(() {
    //   setState(() {});
    // });
    // _controller.setLooping(true);
    // _controller.

    // _controller.play();
    // setState(() {
    //   _controller = VideoPlayerController.networkUrl(Uri.parse(
    //       "https://dacastmmod-mmd-cust.lldns.net/127--1707845332--1707845452--11202a2d6c150c4d58afa4cb536e0cf2/e5/7b127d5f-3b75-4c9c-ae84-7d7ddbd9c832/5bda7af1-b37e-424e-a1a7-3a0c013983c2/stream.ismd/manifest.m3u8?stream=2bb303f5-dac2-1c00-24e4-9449893b521f_rendition%3B87681312-6924-2316-add8-d7c66315fef9_rendition%3B8ca0a648-039c-c32c-70e1-5f02a26cd797_rendition"));
    // });
  }

  @override
  Widget build(BuildContext context) {
    final fpx = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Container(
            color: Colors.black,
            height: fpx * .3,
            child: Chewie(
              controller: _controllerx!,
            )),
      ]),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controllerx!.dispose();
  }
}

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


