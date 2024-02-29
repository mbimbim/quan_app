import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdds {
  bool isBannerLoad = false;
  BannerAd? _bannerAd;
  //late BannerAd _bannerAd;

  createBannerAd() {
     _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isBannerLoad = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          isBannerLoad = false;
          print('Ad failed toxx load: $error');
        },
      ),
    );
    _bannerAd!.load();
  }
}
