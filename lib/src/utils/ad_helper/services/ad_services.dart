import 'package:flutter/foundation.dart';
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
          if (kDebugMode) {
            print("banner load $isDetailsPageLoaded");
          }
        }, onAdClosed: (ad) {
          isDetailsPageLoaded = false;
          ad.dispose();
        }, onAdFailedToLoad: (ad, error) {
          isDetailsPageLoaded = false;
          if (kDebugMode) {
            print("ad error $error");
          }
        }),
        request: const AdRequest());

    await detailsPage.load();
    notifyListeners();
  }

  void initializeNativeAd() async {
    nativeAd = NativeAd(
        adUnitId: GoogleAdHelper.productDetailsNativeAd(),
        listener: NativeAdListener(onAdLoaded: (ad) {
          isNativeAdLoaded = true;
          if (kDebugMode) {
            print("native 2 load $isNativeAdLoaded");
          }
        }, onAdClosed: (ad) {
          isNativeAdLoaded = false;
          ad.dispose();
        }, onAdFailedToLoad: (ad, error) {
          isNativeAdLoaded = false;
          if (kDebugMode) {
            print("ad 2 error $error");
          }
        }),
        request: const AdManagerAdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.medium,
            // Optional: Customize the ad's style.
            mainBackgroundColor: Colors.white,
            cornerRadius: 10.0,
            callToActionTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.monospace,
                size: 16.0),
            primaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black, backgroundColor: Colors.white, style: NativeTemplateFontStyle.italic, size: 16.0),
            secondaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.bold,
                size: 16.0),
            tertiaryTextStyle: NativeTemplateTextStyle(
                textColor: Colors.black,
                backgroundColor: Colors.white,
                style: NativeTemplateFontStyle.normal,
                size: 16.0)));

    await nativeAd.load();
    notifyListeners();
  }
}
