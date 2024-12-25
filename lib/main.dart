import 'dart:convert';
import 'dart:io';

import 'package:cinemagicx/ExVdo.dart';
import 'package:cinemagicx/firebase_options.dart';
import 'package:cinemagicx/firstp.dart';
import 'package:cinemagicx/notification_servicesx.dart';
import 'package:cinemagicx/rads.dart';
import 'package:cinemagicx/videox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationServicesx notificationServicesx = NotificationServicesx();
  await notificationServicesx.initlocal();
  notificationServicesx.shownot(message);

  print('Handling a background message ${message.messageId}');
}

class Dtx with LevelPlayInitListener {
  @override
  void onInitFailed(LevelPlayInitError error) {
    print(" TODO: implement Feild");
  }

  @override
  void onInitSuccess(LevelPlayConfiguration configuration) {
    print(" TODO: implement onInitSuccess");
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationServicesx().firebaseinit();

  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ["FDBD3C29FCF6B9EE903B3A4C9888F12D"],
    ),
  );
  await init();
  // runApp(DevicePreview(
  //   enabled: ,
  //   builder: (context) {
  //     return MyApp();
  //   },
  // ));

  // IronSource.init(appKey: Platform.isAndroid ? "1fc55372d" : "1fc55aa3d");
  // IronSource.setAdaptersDebug(true);

  runApp(MyApp());
}

Future<void> init() async {
  final appKey = Platform.isAndroid ? "1fc55372d" : "1fc55aa3d";
  try {
    List<AdFormat> legacyAdFormats = [
      AdFormat.BANNER,
      AdFormat.REWARDED,
      AdFormat.INTERSTITIAL,
      AdFormat.NATIVE_AD
    ];
    final initRequest =
        LevelPlayInitRequest(appKey: appKey, legacyAdFormats: legacyAdFormats);
    await LevelPlay.init(initRequest: initRequest, initListener: Dtx());
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  MyApp();

  final x =
      ''' {"nnnn|null":[{"_id":"65f6d82ddf0c344946287680","TITLE":"Laapata EP3 (Pyar ka izhaar)","BNR":"1710675919792.jpg","APP":"1710675927881.jpg"}],"native|15":"small","native|76":"large"}''';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final fgj = Uri.parse("http://x.com");
    return MaterialApp(
        title: 'Cinemagicx',
        theme: ThemeData(
          textTheme: Typography.whiteCupertino,
          colorScheme: ColorScheme.fromSeed(
              primary: const Color(0xff005EEA),
              seedColor: const Color.fromARGB(255, 220, 54, 54),
              surface: const Color(0xff071427)),
          useMaterial3: true,
        ),
        home: MySpalash());
  }
}

class AdmobInt extends StatefulWidget {
  @override
  _AdmobInt createState() => _AdmobInt();
}

class _AdmobInt extends State<AdmobInt> with LevelPlayInterstitialAdListener {
  LevelPlayInterstitialAd? _interstitialAd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _interstitialAd = LevelPlayInterstitialAd(adUnitId: "qslh0eeklqwctffp");
    _interstitialAd!.setListener(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            FilledButton(
                onPressed: () async {
                  // print("${await IronSource.getAdvertiserId()}");

                  // print("object");

                  await _interstitialAd?.loadAd();
                },
                child: Text("data")),
            FilledButton(
                onPressed: () async {
                  // print("${await IronSource.getAdvertiserId()}");

                  // print("object");

                  await _interstitialAd?.showAd();
                },
                child: Text("data")),
            IronsourceNative(
              issall: false,
            ),
            Text("hello"),
            IronsourceNative(
              issall: true,
            ),
            Text("hello"),
            GoogleNative(
              key: GlobalKey(),
            ),
            Text("hello"),
            GoogleNative(
              key: GlobalKey(),
              isssmall: false,
            )
          ],
        ),
      ),
    );
  }

  @override
  void onAdClicked(LevelPlayAdInfo adInfo) {
    print("\n\n\n\n\n================\n\n");
    print(" // TODO: implement onAdClicked");
    print("\n\n\n\n\n================\n\n");
  }

  @override
  void onAdClosed(LevelPlayAdInfo adInfo) {
    // TODO: implement onAdClosed
    print("\n\n\n\n\n================\n\n");
    print(" //  TODO: implement onAdClosed");
    print("\n\n\n\n\n================\n\n");
  }

  @override
  void onAdDisplayFailed(LevelPlayAdError error, LevelPlayAdInfo adInfo) {
    print("\n\n\n\n\n================\n\n");
    print(" //  TODO: implement onAdDisplayFailed");
    print("\n\n\n\n\n================\n\n");
    //
  }

  @override
  void onAdDisplayed(LevelPlayAdInfo adInfo) {
    print("\n\n\n\n\n================\n\n");
    print(" // TODO: implement onAdDisplayed");
    print("\n\n\n\n\n================\n\n");
    // TODO: implement onAdDisplayed
  }

  @override
  void onAdInfoChanged(LevelPlayAdInfo adInfo) {
    print("\n\n\n\n\n================\n\n");
    print(" //  TODO: implement onAdInfoChanged");
    print("\n\n\n\n\n================\n\n");
    // TODO: implement onAdInfoChanged
  }

  @override
  void onAdLoadFailed(LevelPlayAdError error) {
    print("\n\n\n\n\n================\n\n");
    print(" // TODO: implement onAdLoadFailed");
    print("\n\n\n\n\n================\n\n");
  }

  @override
  void onAdLoaded(LevelPlayAdInfo adInfo) {
    _interstitialAd?.showAd();
    print("\n\n\n\n\n================\n\n");
    print(" // TODO: implement onAdLoaded");
    print("\n\n\n\n\n================\n\n");
  }
}








/*
  bool _nativeAdIsLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';
  void loadAd() {
    _nativeAd = NativeAd(
        adUnitId: _adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            debugPrint('$NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            debugPrint('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
          templateType: TemplateType.small,
          // Optional: Customize the ad's style.
        ))
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
            onPressed: () {
              loadAd();
            },
            child: Text("data")),
        _nativeAdIsLoaded
            ? Flexible(child: AdWidget(ad: _nativeAd!))
            : Text("data")
      ],
    );
  }
}

class LevelPlayNativeAdListenerClass with LevelPlayNativeAdListener {
  @override
  void onAdClicked(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    // TODO: implement onAdClicked
  }

  @override
  void onAdImpression(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    // TODO: implement onAdImpression
  }

  @override
  void onAdLoadFailed(LevelPlayNativeAd? nativeAd, IronSourceError? error) {
    // TODO: implement onAdLoadFailed
  }

  @override
  void onAdLoaded(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    // TODO: implement onAdLoaded
  }
}

class LevelPlayNativeAdsSection extends StatefulWidget {
  const LevelPlayNativeAdsSection({Key? key}) : super(key: key);

  @override
  _LevelPlayNativeAdsSection createState() => _LevelPlayNativeAdsSection();
}

class _LevelPlayNativeAdsSection extends State<LevelPlayNativeAdsSection>
    with LevelPlayNativeAdListener {
  LevelPlayNativeAd? _nativeAd;
  LevelPlayNativeAdView? _nativeAdView;

  @override
  void initState() {
    IronSource.validateIntegration();
    print(IronSource.getAdvertiserId());
    IronSource.setAdaptersDebug(true);
    super.initState();
    _createNativeAd();
    _createNativeAdView();
  }

  /// Initialize native ad object
  void _createNativeAd() {
    _nativeAd = LevelPlayNativeAd.builder()
        // Your placement name string
        .withListener(this) // Your level play native ad listener
        .build();
  }

  /// Initialize native ad view widget with native ad
  void _createNativeAdView() {
    _nativeAdView = LevelPlayNativeAdView(
      key: GlobalKey(), // Unique key to force recreation of widget
      // Your chosen height
      width: double.infinity,

      height: 150,
      // Your chosen width
      nativeAd: _nativeAd, // Native ad object

      templateStyle: LevelPlayNativeAdTemplateStyle(
          callToActionStyle: LevelPlayNativeAdElementStyle(
              backgroundColor: Color.fromARGB(0xff, 4, 104, 104)),
          titleStyle:
              LevelPlayNativeAdElementStyle(backgroundColor: Colors.red),
          bodyStyle:
              LevelPlayNativeAdElementStyle(backgroundColor: Colors.orange)),

      templateType: LevelPlayTemplateType
          .SMALL, // Built-in native ad template(not required when implementing custom template)
    );
  }

  /// Load native ad
  void _loadAd() {
    _nativeAd?.loadAd();
  }

  /// Destroy current native ad and create new instances of LevelPlayNativeAd and LevelPlayNativeAdView.
  void _destroyAdAndCreateNew() {
    if (_nativeAd == null) return;

    _nativeAd!.destroyAd();
    setState(() {
      _createNativeAd();
      _createNativeAdView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizontalButtons([
          ButtonInfo("Load Ad", () {
            _loadAd();
          }),
          ButtonInfo("Destroy Ad", () {
            _destroyAdAndCreateNew(); // Call this method on button press
          }),
        ]),
        Container(
            color: const Color.fromARGB(255, 42, 1, 30),
            child: _nativeAdView ?? Container()),
        Text("vvv")
      ],
    );
  }

  // LevelPlay NativeAd listener

  @override
  void onAdClicked(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    print('onAdLoaded - adInfo: $adInfo');
  }

  @override
  void onAdImpression(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    print('onAdLoaded - adInfo: $adInfo');
  }

  @override
  void onAdLoadFailed(LevelPlayNativeAd? nativeAd, IronSourceError? error) {
    print('onAdLoadFailed - error: $error');
  }

  @override
  void onAdLoaded(LevelPlayNativeAd? nativeAd, IronSourceAdInfo? adInfo) {
    print('onAdLoaded - nativeAd: $_nativeAd, adInfo: $adInfo');
    setState(() {
      _nativeAd = nativeAd;
    });
  }
}

class ButtonInfo {
  final String title;
  final void Function()? onPressed;
  ButtonInfo(this.title, this.onPressed);
}

class HorizontalButtons extends StatelessWidget {
  final List<ButtonInfo> buttons;
  const HorizontalButtons(this.buttons, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final smallBtnStyle =
        ElevatedButton.styleFrom(minimumSize: const Size(150, 45));
    return Row(
        children: buttons
            .map((btn) => Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        onPressed: btn.onPressed,
                        child: Text(btn.title),
                        style: smallBtnStyle,
                      )),
                ))
            .toList());
  }
}

*/