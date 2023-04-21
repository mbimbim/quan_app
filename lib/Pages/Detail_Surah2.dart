import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';

class Detail_surah2 extends StatelessWidget {
  int no;
  String ayat;
  String ayat_indo;
  String artinya;
  Detail_surah2(
      {Key? key,
      required this.no,
      required this.ayat,
      required this.ayat_indo,
      required this.artinya})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ),
              child: Text(
                "Ayat $no",
                textAlign: TextAlign.right,
                style: GoogleFonts.lateef().copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.warna_icon),
              ),
            ),
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
                    fontSize: 24,
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
