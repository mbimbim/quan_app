// ignore_for_file: unused_local_variable, unused_field

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_app/Models/Model_Doa.dart';
import 'package:quran_app/Models/Model_Surah.dart';
import 'package:quran_app/Pages/Doa.dart';
import 'package:quran_app/Pages/surah.dart';
import 'package:quran_app/Providers/Provider.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Providers/Providers_android.dart';
import 'Detal_Surah.dart';

class HomePage extends ConsumerStatefulWidget {
  String nowa;
  HomePage({Key? key, required this.nowa}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  bool isBannerLoad = false;
  late BannerAd _bannerAd;
  late InterstitialAd mInterstitialAd;


  loadBannerPenuh(){
   InterstitialAd.load(
  adUnitId: 'ca-app-pub-2517022731205460/8932069235',
  request: AdRequest(),
  adLoadCallback: InterstitialAdLoadCallback(
    onAdLoaded: (InterstitialAd ad) {
      // Keep a reference to the ad so you can show it later.
      mInterstitialAd = ad;
    },
    onAdFailedToLoad: (LoadAdError error) {
      print('InterstitialAd failed to load: $error');
    },
  ),
);
  }

  loadBanner(){
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-2517022731205460/8009869801',
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            isBannerLoad = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          isBannerLoad = false;
          print('Ad failed toxx load: $error');
        },
      ),
    );
    _bannerAd.load();
  }



  late Future<List<Model_Surah>> _surahListFuture;
  String _searchQuery = '';
//  int lastVerse = 0;
  final provider2 = Providers2();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBannerPenuh();
    loadBanner();
  }

  @override
  Widget build(BuildContext context) {
    //   aaa.getdataDoa();
    final getProviderss = ref.watch(authControllerProvider.notifier);
    // final getProviderSurah = ref.watch(ApiProviderSurah(""));
    //final getProviderDoa = ref.watch(ApiProviderDoa);
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
DateTime? _lastBackPressTime;
    // print("geett " + getProviderss.lastVerse.toString());
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (_lastBackPressTime == null ||
            now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
          _lastBackPressTime = now;
          final snackBar = SnackBar(content: Text('Tekan lagi untuk keluar'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return Future.value(false);
        }
        SystemNavigator.pop();
        mInterstitialAd.show();
        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: isBannerLoad
            ? Container(
                height: 50,
                child: AdWidget(ad: _bannerAd),
              )
            : const SizedBox(),
        backgroundColor: ColorUtils.primaryColor,
        appBar: AppBar(
          elevation: 0,
          //toolbarHeight: 100,
          //create CircleImage and NameW
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Modal_Credit(context);
                },
                child: Image.asset(
                  'assets/images/icon_slide.png',
                  width: 21,
                  height: 15,
                ),
              ),
              const SizedBox(width: 20),
              //RichText
              Text(
                "Al-Qur'an",
                style: TextUtils.text_judul,
              ),
      
              //Create Menu left
              const Spacer(),
      
              //Create menu
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorUtils.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
      
                    // getProviderss.getLastReadVerse();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Cari",
                    hintStyle: TextUtils.text_11,
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorUtils.warna_text_judul,
                    ),
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Text(
              //   'Asslamualaikum',
              //   style: TextUtils.text_14,
              // ),
              // Text('Bima Pratama', style: TextUtils.text_judul
              //     // TextStyle(
              //     //   fontSize: 24,
              //     //   color: ColorUtils.warna_text_judul,
              //     //   fontWeight: FontWeight.bold,
              //     //),
              //     ),
              // const SizedBox(
              //   height: 30,
              // ),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ColorUtils.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/last_read.png',
                              width: 16,
                              height: 13,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Terakhir dibaca :',
                              style: TextUtils.text_13_2,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
      
                        sharedPreferences.when(
                          data: (data) {
                            // int lastVerse = 0;
                            // String nama_surah = "";
                            // int nomor_surah = 0;
      
                            getProviderss.lastVerse =
                                data.getInt('last_verse') ?? 0;
                            getProviderss.nama_surah =
                                data.getString('nama_surah') ?? "";
                            getProviderss.nomor_surah =
                                data.getInt('nomor_surah') ?? 0;
                            return getProviderss.lastVerse > 0
                                ? GestureDetector(
                                    onTap: () {
                                      // print("antar " +
                                      //     nomor_surah.toString() +
                                      //     nama_surah);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailSurah(
                                                  namaSurah_no: getProviderss
                                                      .nomor_surah
                                                      .toString(),
                                                  terakhir_baca: true,
                                                  nomorSurah: getProviderss
                                                      .nomor_surah
                                                      .toString(),
                                                  namaSurah:
                                                      getProviderss.nama_surah)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              style: BorderStyle.solid,
                                              width: 1,
                                              color: ColorUtils.warna_icon)),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                getProviderss.nama_surah,
                                                style: TextUtils.text_14_2,
                                              ),
                                              Text(
                                                'Ayat ke : ${getProviderss.lastVerse}',
                                                style: TextUtils.text_11,
                                              ),
                                              Text(
                                                'Surah nomor : ${getProviderss.nomor_surah}',
                                                style: TextUtils.text_11,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_circle_right_sharp,
                                            size: 30,
                                            color: ColorUtils.warna_icon,
                                          )
                                        ],
                                      ),
                                    ))
                                : Container();
                          },
                          error: (error, stackTrace) => Text("errror"),
                          loading: () => const CircularProgressIndicator(),
                        )
      
                        // if (snapshot.hasData) {
                        //   print('kkkkkkk $provider2.lastVerse');
                        // getProviderss.lastVerse > 0
                        //     ? GestureDetector(
                        //         onTap: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => DetailSurah(
                        //                       terakhir_baca: true,
                        //                       nomorSurah: getProviderss
                        //                           .nomor_surah
                        //                           .toString(),
                        //                       namaSurah:
                        //                           getProviderss.nama_surah)));
                        //         },
                        //         child: Container(
                        //           padding: const EdgeInsets.all(10),
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(10),
                        //               border: Border.all(
                        //                   style: BorderStyle.solid,
                        //                   width: 1,
                        //                   color: ColorUtils.warna_icon)),
                        //           child: Row(
                        //             children: [
                        //               Column(
                        //                 children: [
                        //                   Text(
                        //                     getProviderss.nama_surah,
                        //                     style: TextUtils.text_14_2,
                        //                   ),
                        //                   Text(
                        //                     'Ayat ke : ' +
                        //                         (getProviderss.lastVerse)
                        //                             .toString(),
                        //                     style: TextUtils.text_11,
                        //                   ),
                        //                   Text(
                        //                     'Surah nommor. ${getProviderss.nomor_surah}',
                        //                     style: TextUtils.text_11,
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(
                        //                 width: 10,
                        //               ),
                        //               Icon(
                        //                 Icons.arrow_circle_right_sharp,
                        //                 size: 30,
                        //                 color: ColorUtils.warna_icon,
                        //               )
                        //             ],
                        //           ),
                        //         ))
                        //     : Container()
                        // } else {
                        //   return Text(
                        //     'Belum ada',
                        //     style: TextUtils.text_13_2,
                        //   );
                        // }
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/icon_quran.png',
                      width: 74,
                      height: 84,
                    )
                  ],
                ),
              ),
              Consumer(
                builder: (context, Ref, child) {
                  return buildTabs(Ref, context);
                },
              ),
              Expanded(
                  child: PageView(
                allowImplicitScrolling: true,
                pageSnapping: true,
      
                //physics: const NeverScrollableScrollPhysics(),
                controller: getProviderss.pageController,
      
                onPageChanged: (int page) {
                  getProviderss.numPages = page;
                  getProviderss.nextPage();
                },
                children: [
                  FutureBuilder<List<Model_Surah>>(
                    future: ref.watch(authControllerProvider).getDataSurah(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final surahList = snapshot.data!
                            .where((surah) => surah.namaLatin!
                                .toLowerCase()
                                .contains(_searchQuery))
                            .toList();
                        return ListView.builder(
                          itemCount: surahList.length,
                          itemBuilder: (context, index) {
                            return Surah(
                              jumlah_ayat: surahList[index].jumlahAyat!,
                              nama: surahList[index].nama!,
                              nama_latin: surahList[index].namaLatin!,
                              nama_latin_no:
                                  "${surahList[index].nomor}. ${surahList[index].namaLatin!}",
                              nomorSurah: surahList[index].nomor.toString(),
                              tempat_turun: surahList[index].tempatTurun!,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
      
                  // getProviderSurah.when(
                  //   data: (data) {
      
                  //     return ListView.builder(
                  //         itemCount: data.length,
                  //         itemBuilder: (context, index) {
                  //           return Surah(
                  //             jumlah_ayat: data[index].jumlahAyat!,
                  //             nama: data[index].nama!,
                  //             nama_latin: data[index].namaLatin!,
                  //             nomorSurah: data[index].nomor.toString(),
                  //             tempat_turun: data[index].tempatTurun!,
                  //           );
                  //         });
                  //   },
                  //   loading: () =>
                  //       const Center(child: CircularProgressIndicator()),
                  //   error: (err, stack) => Text('Error: $err'),
                  // ),
                  FutureBuilder<List<Model_Doa>>(
                    future: ref.watch(authControllerProvider).getdataDoa(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final doaList = snapshot.data!
                            .where((surah) =>
                                surah.nama!.toLowerCase().contains(_searchQuery))
                            .toList();
                        return ListView.builder(
                          itemCount: doaList.length,
                          itemBuilder: (context, index) {
                            return ListDoa(
                              nama: doaList[index].nama!,
                              no: doaList[index].id.toString(),
                              tentang: doaList[index].tag!,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
      
                  // getProviderDoa.when(
                  //   data: (data) {
                  //     return ListView.builder(
                  //       itemCount: data.length,
                  //       itemBuilder: (context, index) {
                  // return ListDoa(
                  //   nama: data[index].nama!,
                  //   no: data[index].id.toString(),
                  //   tentang: data[index].tag!,
                  // );
                  //       },
                  //     );
                  //   },
                  //   loading: () =>
                  //       const Center(child: CircularProgressIndicator()),
                  //   error: (err, stack) => Text('Error: $err'),
                  // )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabs(WidgetRef ref, BuildContext context) {
    final bbbb = ref.watch(authControllerProvider);
    List<Widget> tabss = [];

    for (int i = 0; i < bbbb.tabs.length; i++) {
      bool selected = bbbb.currentPage == i;

      tabss.add(Expanded(
        // flex: selected ? 4 : 3,
        child: Container(
          // onTap: () {
          //   provider_test.onPageChanged(i, fromUser: true);
          // },
          //  color: selected ? Colors.red : Colors.black,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 7),
          decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
          ),
          child: Column(
            children: [
              // Icon(
              //   bbbb.tabs[i].iconData,
              //   size: 20,
              //   color: selected ? Colors.white : Color(0xFF444444),
              // ),
              Text(
                bbbb.tabs[i].name,
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? ColorUtils.warna_text_judul
                      : ColorUtils.warna_text,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 2,
                color:
                    //ColorUtils.warna_text_judul
                    selected
                        ? ColorUtils.warna_text_judul
                        : ColorUtils.warna_text,
              )
            ],
          ),
        ),
      ));
    }

    return Row(
      children: tabss,
    );
  }

  Future<void> Modal_Credit(BuildContext context) async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          //   Navigator.of(context).pop(hide);

          return FadeIn(
            delay: Duration(seconds: 1),
            animate: true,
            child: AlertDialog(
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInUp(
                        delay: Duration(seconds: 2),
                        animate: true,
                        child:  Text("Info Developer !\nVersion ${provider2.versi}")),
                    // Image.asset(
                    //   'assets/image/logo.jpg',
                    //   width: 110,
                    //   height: 60,
                    //   fit: BoxFit.fill,
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                    FadeInLeft(
                      delay: Duration(seconds: 3),
                      animate: true,
                      child: Text(
                        "Nama : Bima Pratama",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins()
                            .copyWith(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    FadeInRight(
                      delay: Duration(seconds: 4),
                      animate: true,
                      child: Text(
                        "email : pratamabima03@gmail.com",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins()
                            .copyWith(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    FadeInDown(
                      delay: Duration(seconds: 5),
                      animate: true,
                      child: Text(
                        "NoHp/Wa : 0${widget.nowa}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins()
                            .copyWith(fontSize: 15, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInDown(
                        delay: Duration(seconds: 5),
                        animate: true,
                        child: ElevatedButton(
                            onPressed: () {
                              _launchURL();
                              Navigator.pop(context);
                            },
                            child: Text("Whatsapp"))),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _launchURL() async {
    final String phoneNumber = widget.nowa; // Ganti dengan nomor telepon tujuan
    final String message =
        'Halo, saya ingin Custom Aplikasi!'; // Teks pesan yang ingin ditambahkan

    final String url =
        'whatsapp://send?phone=+62$phoneNumber&text=${Uri.encodeFull(message)}';

    //  final url = "whatsapp://send?phone=+62$phoneNumber&text=asdadasdadad";

    await launchUrl(Uri.parse(url));
    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
