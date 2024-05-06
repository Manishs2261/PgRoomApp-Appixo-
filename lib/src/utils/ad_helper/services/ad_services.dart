import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pgroom/src/utils/ad_helper/google_ad_helper.dart';

class AdProvider with ChangeNotifier{

  bool isDetailsPageLoaded = false;
  late BannerAd detailsPage;


  void initializeDetailsBanner() async{

    detailsPage = BannerAd(
        size: AdSize.banner,
        adUnitId: GoogleAdHelper.productDetailsPageBanner(),
        listener: BannerAdListener(
          onAdLoaded: (ad){
            isDetailsPageLoaded = true;
            print("banner load $isDetailsPageLoaded");
          },
          onAdClosed: (ad){
            isDetailsPageLoaded = false;
            ad.dispose();
          },
          onAdFailedToLoad: (ad,error){
            isDetailsPageLoaded = false;
            print("ad erro $error");
          }
        ),
        request: AdRequest()
    );


    await detailsPage.load();
    notifyListeners();
  }





}
