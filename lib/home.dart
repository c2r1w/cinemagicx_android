import 'package:cinemagicx/dlist.dart';
import 'package:cinemagicx/searc.dart';
import 'package:cinemagicx/signup.dart';
import 'package:cinemagicx/watchltr.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

// 005EEA border 0381E9 btn

class _HomePageState extends State<HomePage> {
  List<String> raju = ["raju"];

  bool isclick = false;
  int th = 0;
  final tabController = DefaultTabController(length: 5, child: SizedBox());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 50,
                ),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    // await showModalBottomSheet(
                    //     backgroundColor: Color(0xff071427),
                    //     context: context,
                    //     builder: (context) => pPadding(
                    //           padding: const EdgeInsets.only(
                    //               top: 15, left: 10, right: 10),
                    //           child: XSearch(),
                    //         ));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => XSearch(),
                        ));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MySignUp()));
                        },
                        child: Text("Profile")),
                    MenuItemButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DownloadedPage()));
                        },
                        child: Text("Download List")),
                    MenuItemButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Vatchlist()));
                        },
                        child: Text("Watch Later")),
                  ],
                  builder: (context, controller, child) => IconButton(
                    onPressed: () {
                      if (controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          ),
          DefaultTabController(
            length: 5,
            child: TabBar(
              tabAlignment: TabAlignment.fill,
              isScrollable: false,
              dividerHeight: 0,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  icon: Icon(Icons.star),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: "Homex",
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
