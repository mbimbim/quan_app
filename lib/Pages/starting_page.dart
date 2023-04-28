// ignore_for_file: unnecessary_const

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_app/Models/Model_Android.dart';
import 'package:quran_app/Pages/home_page.dart';
import 'package:quran_app/Providers/Provider.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';
import 'package:http/http.dart' as http;

import '../Providers/Providers_android.dart';

class StartingPage extends ConsumerStatefulWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  StartingPageState createState() => StartingPageState();
}

class StartingPageState extends ConsumerState<StartingPage> {
  Data_Android asda = Data_Android();

  final provider = Providersss();
  final provider2 = Providers2();
  @override
  void initState() {
    // provider2.getDataFromAPI(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final aaa = ref.watch(ApiProviderTerakhirDibaca);
    //   final aaa = ref.watch(ApiProviderCekAndroid);
    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quran Apps",
              style: TextUtils.text_judul,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Membaca Al-Qur'an menjadi lebih mudah\nSetiap hari",
              style: TextUtils.text_13,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 41,
            ),
            Stack(
              children: [
                // Container(
                //   height: 440,
                //   width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(color: Colors.amber),
                // ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 60, bottom: 40),
                  decoration: BoxDecoration(
                    color: ColorUtils.warna_icon,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Image.asset(
                    'assets/images/mosque.png',
                    width: 270,
                    height: 318,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 80,
                    right: 80,
                    child: FutureBuilder(
                      future: provider2.getDataFromAPI(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  // ignore: prefer_const_constructors
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(nowa: provider2.nowa),
                                  ));
                            },
                            child: Container(
                              height: 51,
                              decoration: BoxDecoration(
                                  color: ColorUtils.warna_text,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Center(
                                child: Text(
                                  'Mulai !',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins().copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0XFFDAD0E1)),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ))
                // provider2.status_mulai == true
                //     ? GestureDetector(
                //         onTap: () {
                //           Navigator.pushReplacement(
                //               // ignore: prefer_const_constructors
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) =>
                //                     HomePage(nowa: provider2.nowa),
                //               ));
                //         },
                //         child: Container(
                //           height: 51,
                //           decoration: BoxDecoration(
                //               color: ColorUtils.warna_text,
                //               borderRadius: BorderRadius.circular(40)),
                //           child: Center(
                //             child: Text(
                //               'Mulai !',
                //               textAlign: TextAlign.center,
                //               style: GoogleFonts.poppins().copyWith(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.w600,
                //                   color: const Color(0XFFDAD0E1)),
                //             ),
                //           ),
                //         ),
                //       )
                //     : const Center(child: CircularProgressIndicator()))
              ],
            )
          ],
        ),
      ),
    );
  }
}
