// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Providers/Provider.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';
import 'package:share/share.dart';
import 'dart:io';

class Detail_surah2 extends StatelessWidget {
  WidgetRef ref;
  int no;
  int indexx;
  int nomor_surah;
  String ayat;
  String ayat_indo;
  String artinya;
  String surah;
  Detail_surah2(
      {Key? key,
      required this.no,
      required this.ayat,
      required this.ayat_indo,
      required this.artinya,
      required this.surah,
      required this.nomor_surah,
      required this.ref,
      required this.indexx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedata = ref.watch(authControllerProvider);

    return Container(
      // color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                border: Border.all(color: ColorUtils.warna_icon),
                borderRadius: BorderRadius.circular(10),
                color: indexx == savedata.lastVerse &&
                        nomor_surah == savedata.nomor_surah
                    ? ColorUtils.warna_icon
                    : Colors.transparent,
              ),
              child: Text(
                "Ayat $no",
                textAlign: TextAlign.right,
                style: GoogleFonts.lateef().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: indexx == savedata.lastVerse &&
                            nomor_surah == savedata.nomor_surah
                        ? Colors.white
                        : ColorUtils.warna_icon),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            indexx == savedata.lastVerse && nomor_surah == savedata.nomor_surah
                ? Text(
                    "Terakhir dibaca",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.lateef().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: ColorUtils.warna_icon),
                  )
                : Container(),
            const Spacer(),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    child: Text('Tandai bacaan'),
                    value: 'menu1',
                  ),
                  PopupMenuItem(
                    child: Text('Bagikan ayat ini'),
                    value: 'menu2',
                  ),
                  // PopupMenuItem(
                  //   child: Text('Tambahkan ke bookmark'),
                  //   value: 'menu3',
                  // ),
                ];
              },
              icon: Icon(
                Icons.more_horiz_rounded,
                color: ColorUtils.warna_icon,
                size: 30,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'menu1':
                    // Action for menu 1
                    print('kamu pilih nomo $surah, $no, $nomor_surah');
                    savedata.saveLastReadVerse(surah, no, nomor_surah);
                    break;
                  case 'menu2':
                    Share.share("$ayat\n\n$ayat_indo\n\nartinya:\n$artinya");
                    print('kamu pilih nomo2 $value');
                    break;
                  // case 'menu3':
                  //   // Action for menu 3
                  //   print('kamu pilih nomo3 $value');
                  //   break;
                }
              },
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                ayat,
                textAlign: TextAlign.right,
                style: GoogleFonts.lateef().copyWith(
                    fontSize: 45,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.warna_text_judul),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                ayat_indo,
                style: TextUtils.text_13_2,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                artinya,
                style: TextUtils.text_13_miring,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
