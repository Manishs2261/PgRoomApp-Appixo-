import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pgroom/src/utils/ad_helper/google_ad_helper.dart';

class AdProvider with ChangeNotifier {
  bool isDetailsPageLoaded = false;
  late BannerAd detailsPage;

  bool isNativeAdLoaded = false;
  late NativeAd nativeAd;

  void initializeDetailsBanner() async {
    detailsPage = BannerAd(
        size: AdSize.banner,
        adUnitId: GoogleAdHelper.productDetailsPageBanner(),
        listener: BannerAdListener(onAdLoaded: (ad) {
          isDetailsPageLoaded = true;
          print("banner load $isDetailsPageLoaded");
        }, onAdClosed: (ad) {
          isDetailsPageLoaded = false;
          ad.dispose();
        }, onAdFailedToLoad: (ad, error) {
          isDetailsPageLoaded = false;
          print("ad error $error");
        }),
        request: AdRequest());

    await detailsPage.load();
    notifyListeners();
  }

  void initializeNativeAd() async {
    nativeAd = NativeAd(
        adUnitId: GoogleAdHelper.productDetailsNativeAd(),
        listener: NativeAdListener(onAdLoaded: (ad) {
          isNativeAdLoaded = true;
          print("native 2 load $isNativeAdLoaded");
        }, onAdClosed: (ad) {
          isNativeAdLoaded = false;
          ad.dispose();
        }, onAdFailedToLoad: (ad, error) {
          isNativeAdLoaded = false;
          print("ad 2 error $error");
        }),
        request: const AdManagerAdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
          // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.purple,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.cyan,
                backgroundColor: Colors.red,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.red,
                backgroundColor: Colors.cyan,
                style: NativeTemplateFontStyle.italic,
                size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.green,
                backgroundColor: Colors.black,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.brown,
                backgroundColor: Colors.amber,
                style: NativeTemplateFontStyle.normal,
                size: 16.0))
    );



    await nativeAd.load();
    notifyListeners();
  }
}
