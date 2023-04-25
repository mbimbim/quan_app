// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/Models/Model_DetailSurah.dart';
import 'package:quran_app/Models/Model_ObjekDetaialSurah.dart';
import 'package:quran_app/Models/Model_Surah.dart';
import 'package:quran_app/Providers/Provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../Models/Model_Android.dart';
import '../Models/Model_Doa.dart';
import 'LinkApi.dart';
import 'package:http/http.dart' as http;

class ApiServices_new {
  List<Model_Doa> doa_model = [];
  List<Model_Surah> surah_model = [];
  List<Model_DetailSurah> detailsurah_model = [];

  String jumlah_ayat_objek = "";
  String nomor_objek = "";
  String nama_objek = "";
  String nama_latin_objek = "";
  String tempat_turun_objek = "";
  String audio_objek = "";

  String nama_doa = "";
  String arab_doa = "";
  String latin_doa = "";
  String idn_Doa = "";
  String tentang_doa = "";

  getDetailDoa(int id) async {
    var url = Uri.parse("${LinkApi.Link}doa/$id");
    var response = await http.get(url);

    var datdoa = json.decode(response.body);
    List data = json.decode(response.body)["ayat"];
    if (response.statusCode == 200) {
      nama_doa = datdoa["nama"].toString();
      arab_doa = datdoa["ar"].toString();
      latin_doa = datdoa["tr"].toString();
      idn_Doa = datdoa["idn"].toString();
      tentang_doa = datdoa["tentang"].toString();
    } else {
      print("gagal");
    }
  }

  Future<List<Model_DetailSurah>> getDetailSurah(int id) async {
    final test = Providersss();
    var url = Uri.parse("${LinkApi.Link}surat/$id");
    var response = await http.get(url);

    var dataobjek = json.decode(response.body);
    List data = json.decode(response.body)["ayat"];
    if (response.statusCode == 200) {
      jumlah_ayat_objek = dataobjek["jumlah_ayat"].toString();
      nomor_objek = dataobjek["nomor"].toString();
      nama_objek = dataobjek["nama"].toString();
      nama_latin_objek = dataobjek["nama_latin"].toString();
      tempat_turun_objek = dataobjek["tempat_turun"].toString();
      audio_objek = dataobjek["audio"].toString();

      detailsurah_model =
          (data).map((e) => Model_DetailSurah.fromJson(e)).toList();

      test.testjuga2();
      return detailsurah_model;
    } else {
      print("gagal");

      return [];
    }
  }

  Future<List<Model_Doa>> getdataDoa() async {
    var url = Uri.parse("${LinkApi.Link}doa");
    var response = await http.get(url);
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    List data = json.decode(response.body);

    if (response.statusCode == 200) {
      doa_model = (data).map((e) => Model_Doa.fromJson(e)).toList();

      //  print('namasurat :  ${surah_model[0].nama}');

      return doa_model;
    } else {
      print("gagal");

      return [];
    }
  }

  Future<List<Model_Surah>> getDataSurah(String query) async {
    print("okeee");
    var url = Uri.parse("${LinkApi.Link}surat");
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    List data = json.decode(response.body);

    if (response.statusCode == 200) {
      // surah_model = (data).map((e) => Model_Surah.fromJson(e)).toList();
      // return surah_model;

      return surah_model =
          (data).map((e) => Model_Surah.fromJson(e)).where((element) {
        final namasurah = element.namaLatin!.toLowerCase();
        final input = query.toLowerCase();

        return namasurah.contains(input);
      }).toList();
    } else {
      print("gagal");

      return [];
    }
  }

  Future<List<Model_Surah>> test(String query) async {
    // print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    final ss = surah_model.where((element) {
      final booktitle = element.namaLatin!.toLowerCase();
      final input = query.toLowerCase();
      return booktitle.contains(input);
    }).toList();

    print('filter : $ss');

    return ss;
  }
}
