// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/Model_Android.dart';

class Providers2 extends ChangeNotifier {
  String versi_adnroid = "";
  String package = "";
  String keterangan = "";
  String status = "";
  String link_update = "";
  String nowa = "";
  String versi = "";
  bool status_mulai = false;

  int lastVerse = 0;
  String nama_surah = "";
  int nomor_surah = 0;
  void versss() async {
    WidgetsFlutterBinding.ensureInitialized();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versi = packageInfo.version;
    print(versi);
    notifyListeners();
    // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //   versi = packageInfo.version;
    //   notifyListeners();
    //   print(versi);
    // });
  }

  Future getLastReadsVerse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lastVerse = prefs.getInt('last_verse') ?? 0;
    nama_surah = prefs.getString('nama_surah') ?? "";
    nomor_surah = prefs.getInt('nomor_surah') ?? 0;

    // ignore: prefer_interpolation_to_compose_strings
    print("namasurah1 " + nama_surah);
    print("nomor_surah1 " + nomor_surah.toString());
    print("lastVerse1 " + lastVerse.toString());
    // lastVerse = 122;
    // nama_surah = "cobaaa";
    notifyListeners();
  }

  Future<Data_Android> getDataFromAPI(BuildContext context) async {
    versss();
    final response = await http
        .post(Uri.parse('https://alquran.gadroen.com/cek_android.php'));
    if (response.statusCode == 200) {
      print("okokokoko");
      var jsonData = jsonDecode(response.body);

      versi_adnroid = jsonData["versi_android"];
      package = jsonData["packagename"];
      keterangan = jsonData["keterangan"];
      status = jsonData["status"];
      link_update = jsonData["link_update"];
      nowa = jsonData["nowa"];

      status_mulai = true;

      print("nowaaaa " + nowa);

      if (versi_adnroid != versi) {
        Modal_Update(context, keterangan, versi_adnroid, link_update);
        status_mulai = false;
      } else if (status == "2") {
        Modal_Maintenance(context, keterangan);
        status_mulai = false;
      } else {
        status_mulai = true;
      }

      notifyListeners();
      return Data_Android.fromJson(jsonData);
    } else {
      status_mulai = false;
      Modal_Maintenance(context, "Failed to load data");
      throw Exception('Failed to load data');
    }
  }

  Future<void> Modal_Update(BuildContext context, String keterangan,
      String versi, String link_update) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          //   Navigator.of(context).pop(hide);

          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/image/logo.jpg',
                    //   width: 110,
                    //   height: 60,
                    //   fit: BoxFit.fill,
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    SpinKitFadingCircle(
                      size: 60,
                      itemBuilder: (context, index) {
                        final colors = [Colors.white, Colors.red];
                        final color = colors[index % colors.length];

                        return DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                color: color));
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      keterangan + "\n" + "ke " + versi,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins()
                          .copyWith(fontSize: 15, color: Colors.black),
                    ),

                    ElevatedButton(
                        onPressed: () {
                          //  Navigator.of(context).pop();
                          launchUrl(Uri.parse(link_update));
                          SystemNavigator.pop();
                        },
                        child: Text("OKE"))
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> Modal_Maintenance(
      BuildContext context, String keterangan) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          //   Navigator.of(context).pop(hide);

          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              content: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/image/logo.jpg',
                    //   width: 110,
                    //   height: 60,
                    //   fit: BoxFit.fill,
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    SpinKitFoldingCube(
                      size: 60,
                      itemBuilder: (context, index) {
                        final colors = [Colors.white, Colors.red];
                        final color = colors[index % colors.length];

                        return DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                color: color));
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      keterangan,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins()
                          .copyWith(fontSize: 15, color: Colors.black),
                    ),

                    ElevatedButton(
                        onPressed: () {
                          //  Navigator.of(context).pop();
                          SystemNavigator.pop();
                        },
                        child: Text("OKE"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
