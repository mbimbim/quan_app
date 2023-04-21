// ignore_for_file: unused_local_variable, unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quran_app/Models/Model_Doa.dart';
import 'package:quran_app/Models/Model_Surah.dart';
import 'package:quran_app/Pages/Doa.dart';
import 'package:quran_app/Pages/surah.dart';
import 'package:quran_app/Providers/Provider.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  late Future<List<Model_Surah>> _surahListFuture;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    //   aaa.getdataDoa();
    final getProviderss = ref.watch(authControllerProvider);
    // final getProviderSurah = ref.watch(ApiProviderSurah(""));
    final getProviderDoa = ref.watch(ApiProviderDoa);
    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      appBar: AppBar(
        elevation: 0,
        //toolbarHeight: 100,
        //create CircleImage and NameW
        title: Row(
          children: [
            Image.asset(
              'assets/images/icon_slide.png',
              width: 21,
              height: 15,
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
              height: 30,
              decoration: BoxDecoration(
                color: ColorUtils.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Terakhir dibaca',
                            style: TextUtils.text_13_2,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Al - Fatiha',
                        style: TextUtils.text_14_2,
                      ),
                      Text(
                        'Ayat no. 1',
                        style: TextUtils.text_11,
                      ),
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
      print('selectednya $selected');
    }

    return Row(
      children: tabss,
    );
  }
}
