// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/Models/Model_Surah.dart';
import 'package:quran_app/Providers/Provider.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';

import 'Detal_Surah.dart';

class Surah extends ConsumerWidget {
  final String nomorSurah;
  final String nama;
  final String nama_latin;
  final String nama_latin_no;
  final int jumlah_ayat;
  final String tempat_turun;
  const Surah(
      {Key? key,
      required this.nomorSurah,
      required this.nama,
      required this.nama_latin,
      required this.jumlah_ayat,
      required this.tempat_turun,
      required this.nama_latin_no})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailSurah(
                      terakhir_baca: false,
                      nomorSurah: nomorSurah,
                      namaSurah: nama_latin,
                      namaSurah_no: nama_latin_no,
                    )));
      },
      child: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    nama_latin_no,
                    style: TextUtils.text_14_2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Jumlah Ayat : $jumlah_ayat',
                    style: TextUtils.text_11,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Turun di : $tempat_turun',
                    style: TextUtils.text_11,
                  ),
                ],
              ),
              Text(
                nama,
                style: TextUtils.ayat,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 2,
            color: ColorUtils.secondaryColor,
          )
        ],
      )),
    );
  }
}
