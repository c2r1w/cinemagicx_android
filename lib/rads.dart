import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ironsource_mediation/ironsource_mediation.dart';

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

class IronsourceBanner extends StatefulWidget {
  const IronsourceBanner({Key? key}) : super(key: key);

  @override
  _LevelPlayBannerAdViewSectionState createState() =>
      _LevelPlayBannerAdViewSectionState();
}

class _LevelPlayBannerAdViewSectionState extends State<IronsourceBanner>
    with LevelPlayBannerAdViewListener, LevelPlayInitListener {
  LevelPlayBannerAdView? _bannerAdView;

  @override
  void initState() {
    super.initState();
    _createBannerAdView();
  }

  void _createBannerAdView() {
    final _bannerKey = GlobalKey<LevelPlayBannerAdViewState>();
    _bannerAdView = LevelPlayBannerAdView(
      key: _bannerKey,
      adUnitId: Platform.isAndroid ? 'h4rrhjesfw61kmni' : '9k5tz8dv9nhsaaon',
      adSize: LevelPlayAdSize.BANNER,
      listener: this,
      onPlatformViewCreated: () => _bannerAdView?.loadAd(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50, child: _bannerAdView ?? Container());
  }

  @override
  void onAdClicked(LevelPlayAdInfo adInfo) {
    print("Banner Ad View - onAdClicked: $adInfo");
  }

  @override
  void onAdCollapsed(LevelPlayAdInfo adInfo) {
    print("Banner Ad View - onAdCollapsed: $adInfo");
  }

  @override
  void onAdDisplayFailed(LevelPlayAdInfo adInfo, LevelPlayAdError error) {
    print(
        "Banner Ad View - onAdDisplayFailed: adInfo - $adInfo, error - $error");
  }

  @override
  void onAdDisplayed(LevelPlayAdInfo adInfo) {
    print("Banner Ad View - onAdDisplayed: $adInfo");
  }

  @override
  void onAdExpanded(LevelPlayAdInfo adInfo) {
    print("Banner Ad View - onAdExpanded: $adInfo");
  }

  @override
  void onAdLeftApplication(LevelPlayAdInfo adInfo) {
    print("Banner Ad View - onAdLeftApplication: $adInfo");
  }

  @override
  void onAdLoadFailed(LevelPlayAdError error) {
    print("Banner Ad View - onAdLoadFailed: $error");
  }

  @override
  void onAdLoaded(LevelPlayAdInfo adInfo) {
    print("Banner Ad View - onAdLoaded: $adInfo");
  }

  @override
  void onInitFailed(LevelPlayInitError error) {
    print(" TODO: implement error");
    // TODO: implement onInitFailed
  }

  @override
  void onInitSuccess(LevelPlayConfiguration configuration) {
    print(" TODO: implement onInitSuccess");
  }
}

class IronsourceNative extends StatefulWidget {
  final bool issall;
  const IronsourceNative({Key? key, this.issall = true});

  @override
  _LevelPlayNativeAdsSection createState() => _LevelPlayNativeAdsSection();
}

class _LevelPlayNativeAdsSection extends State<IronsourceNative>
    with LevelPlayNativeAdListener {
  LevelPlayNativeAd? _nativeAd;
  LevelPlayNativeAdView? _nativeAdView;

  @override
  void initState() {
    super.initState();
    _createNativeAd();
    _createNativeAdView();
  }

  /// Initialize native ad object
  void _createNativeAd() {
    _nativeAd = LevelPlayNativeAd.builder()
        .withPlacementName('') // Your placement name string
        .withListener(this) // Your level play native ad listener
        .build();
  }

  /// Initialize native ad view widget with native ad
  void _createNativeAdView() {
    _nativeAdView = LevelPlayNativeAdView(
        key: GlobalKey(), // Unique key to force recreation of widget
        height: widget.issall ? 100 : 350, // Your chosen height
        width: double.infinity, // Your chosen width
        nativeAd: _nativeAd, // Native ad object
        onPlatformViewCreated: () => _nativeAd?.loadAd(),
        templateType: widget.issall
            ? LevelPlayTemplateType.SMALL
            : LevelPlayTemplateType
                .MEDIUM // Built-in native ad template(not required when implementing custom template),
        );
  }

  @override
  void dispose() {
    _nativeAd!.destroyAd();

    // TODO: implement dispose
    super.dispose();
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
    return _nativeAdView ?? Container();
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

class GoogleNative extends StatefulWidget {
  final bool isssmall;

  const GoogleNative({Key? key, this.isssmall = true});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<GoogleNative> {
  NativeAd? _smallNativeAd;
  NativeAd? _largeNativeAd;
  bool _isSmallAdLoaded = false;
  bool _isLargeAdLoaded = false;

  void loadSmallNativeAd() {
    _smallNativeAd = NativeAd(
      adUnitId: 'ca-app-pub-4899021849652416/5727042156',
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.small),
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isSmallAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  void loadLargeNativeAd() {
    _largeNativeAd = NativeAd(
      adUnitId: 'ca-app-pub-4899021849652416/5727042156', // Test Ad Unit ID
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.medium),
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLargeAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    widget.isssmall ? loadSmallNativeAd() : loadLargeNativeAd();
  }

  @override
  void dispose() {
    widget.isssmall ? _smallNativeAd?.dispose() : _largeNativeAd?.dispose();
    super.dispose();
  }

  bool fux = false;
  @override
  Widget build(BuildContext context) {
    return widget.isssmall
        ? (_isSmallAdLoaded && _smallNativeAd != null)
            ? Container(
                height: 100,
                child: AdWidget(ad: _smallNativeAd!),
              )
            : Container()
        : (_isLargeAdLoaded && _largeNativeAd != null)
            ? Container(
                height: 350,
                child: AdWidget(ad: _largeNativeAd!),
              )
            : Container();
  }
}
