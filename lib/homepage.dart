import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'detail_page.dart';
import 'ad_helper.dart';

import 'data.dart';

//const int maxFailedLoadAttempts = 3;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //BannerAd _ad;
  //bool isloading;

	InterstitialAd _interstitialAd;
	int num_of_attempt_load = 0;
	void interstitialLoad()async{
	  await InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad){
              this._interstitialAd=ad;
              print('Ad was loaded');
              num_of_attempt_load=0;
            },
            onAdFailedToLoad: (LoadAdError error){
              print('Ad failed to load');
              num_of_attempt_load+1;
              _interstitialAd=null;

              if(num_of_attempt_load<=2){
                    interstitialLoad();
              }
            })
    );
	}

void showInterstitial(){
	  if(_interstitialAd==null){
	    return;
    }
	  _interstitialAd.fullScreenContentCallback=FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad)=>
          print('on ad showed'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) =>
          print('on ad dismissed'),
      onAdFailedToShowFullScreenContent: (InterstitialAd ad,AdError error) {
        print('on ad failed');
        ad.dispose();

      },
      onAdImpression: (InterstitialAd ad) =>

            print('Impression occured'),

    );

	  _interstitialAd.show();

	 // Future.delayed(Duration(milliseconds: 60000),(){
      _interstitialAd=null;
      interstitialLoad();
    //});
	  //_interstitialAd=null;

}









  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();


    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,

      listener: BannerAdListener(

        onAdLoaded: (_) {
          setState(() {
            isloading = true;
          });
        },
        onAdFailedToLoad: (_, error) {
          print('AdFailedToLoad: $error');
        },
      ),
    );

    _ad.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  Widget checkForAd() {
    if (isloading == true) {
      return Center(
        child: Container(
          child: AdWidget(
            ad: _ad,
          ),
          width: _ad.size.width.toDouble(),
          height: 50,
          alignment: Alignment.center,
        ),
      );
    } else {
      return SizedBox(
        height: 50,
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.deepOrange.shade50, Colors.deepOrangeAccent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 0.7],
        )),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 32.0, bottom: 30),
                child: Text(
                  'ගෙවතු වගාව අත්පොත',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 32.0, right: 32.0, bottom: 30.0),
                  child: Container(
//height: 500,
                    child: Swiper(
                        itemCount: piriths.length,
                        itemWidth: MediaQuery.of(context).size.width - 64 * 2,
                        layout: SwiperLayout.STACK,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //interstitial ad

                              if(_interstitialAd==null){
                                interstitialLoad();
                              }
                              else{
                                print('Interstitial present');
                              }
                              showInterstitial();
                              print('button tapped');


                              //interstitial ad
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) =>
                                      DetailPage(pirithInfo: piriths[index]),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Expanded(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ),
                                        elevation: 8,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  width: 120,
                                                ),
                                              ),

/*Expanded(
                                            child: SizedBox(
                                              height: 10,
                                            ),
                                          ),*/
                                              Expanded(
                                                child: Text(
                                                  piriths[index].name,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        const Color(0xff47455f),
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),

/*Expanded(
                                             child: SizedBox(
                                                   height: 10,
                                            ),
                                         ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],

// Image.asset('assets/boleave.png'),
                                ),
                                Image.asset('assets/boleave.png'),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
              //checkForAd(),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
