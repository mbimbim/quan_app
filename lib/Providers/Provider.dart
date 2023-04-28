// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/Models/Model_Doa.dart';
import 'package:quran_app/Pages/surah.dart';
import 'package:quran_app/Providers/LinkApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Model_Android.dart';
import '../Models/Model_DetailSurah.dart';
import '../Models/Model_Surah.dart';
import 'ApiProvider.dart';

class Tab {
  String name;
  IconData iconData;

  Tab(this.name, this.iconData);
}

final tembakApi = Provider.autoDispose<ApiServices_new>((ref) {
  return ApiServices_new(); // declared elsewhere
});

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences;
});

final ApiProviderTerakhirDibacas = FutureProvider<String>((ref) {
  // get repository from the provider below
  final tembakApiRepository = ref.read(authControllerProvider);

  return tembakApiRepository.getLastReadsVerse();
});

// final ApiProviderTerakhirDibaca =
//     ChangeNotifierProvider<Provider_terakhirBaca>((ref) {
//   return Provider_terakhirBaca();
// });

final ApiProviderCekAndroid = FutureProvider.autoDispose<Data_Android>((ref) {
  // get repository from the provider below
  final tembakApiRepository = ref.watch(authControllerProvider);

  return tembakApiRepository.getDataFromAPI();
});

final ApiProviderDetailSurah = FutureProvider.family
    .autoDispose<List<Model_DetailSurah>, int>((ref, query) {
  // get repository from the provider below
  final tembakApiRepository = ref.watch(tembakApi);

  return tembakApiRepository.getDetailSurah(query);
});

final ApiProviderDoa = FutureProvider.autoDispose<List<Model_Doa>>((ref) {
  // get repository from the provider below
  final tembakApiRepository = ref.watch(tembakApi);

  return tembakApiRepository.getdataDoa();
});

final ApiProviderSurah =
    FutureProvider.family.autoDispose<List<Model_Surah>, String>((ref, query) {
  // get repository from the provider below
  final tembakApiRepository = ref.watch(tembakApi);

  return tembakApiRepository.getDataSurah(query);
});

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerProvider, AudioPlayer>((ref) {
  return AudioPlayerProvider();
});

final audioPlayerPositionProvider = StreamProvider<Duration>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);
  return audioPlayer.onAudioPositionChanged;
});

final audioPlayerDurationProvider = StreamProvider<Duration>((ref) {
  final audioPlayer = ref.watch(audioPlayerProvider);

  return audioPlayer.onDurationChanged;
});

class AudioPlayerProvider extends StateNotifier<AudioPlayer> {
  AudioPlayerProvider() : super(AudioPlayer()) {
    _audioPlayer = state;
    _audioPlayer.onPlayerCompletion.listen((event) {
      _audioPlayer.seek(Duration.zero);
      // print("selseai");

      playing = false;
      _audioPlayer.stop();

      state = AudioPlayer();
    });
  }

  late final AudioPlayer _audioPlayer;

  bool playing = false;
  IconData get playStopIcon => playing ? Icons.stop : Icons.play_arrow;
  bool satatusplay() {
    return playing;
  }

  void _stop() {
    playing = false;
    state = _audioPlayer;
  }

  void togglePlayStop(String url) {
    if (playing == false) {
      play(url);
      playing = true;
    } else {
      pause();
      playing = false;
    }

    print('statusplay $playing');
  }

  Future<void> play(String url) async {
    await _audioPlayer.play(url).then((value) => playing);

    state = _audioPlayer;
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    playing = false;
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}

final authControllerProvider = ChangeNotifierProvider<Providersss>((ref) {
  return Providersss();
});

class Providersss extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  int numPages = 0;
  String okepunya = "Mantap";
  List<Model_Surah> surah_model = [];
  late Data_Android data_android_model;
  List<Model_Doa> doa_model = [];
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  int testjuga = 0;

  String nama_doa = "";
  String arab_doa = "";
  String latin_doa = "";
  String idn_Doa = "";
  String tentang_doa = "";

  int lastVerse = 0;
  String nama_surah = "";
  int nomor_surah = 0;
  var counter = 1;

  void testjuga2() {
    testjuga = 1;
    notifyListeners();
  }

  void togglePlayStop(String url) {
    if (isPlaying == false) {
      play(url);
      isPlaying = true;
    } else {
      pause();
      isPlaying = false;
    }
    notifyListeners();
  }

  Future<void> play(String url) async {
    await audioPlayer.play(url).then((value) => isPlaying);
    notifyListeners();
  }

  Future<void> pause() async {
    await audioPlayer.pause();
    notifyListeners();
  }

  Future<void> resume() async {
    await audioPlayer.resume();
    notifyListeners();
  }

  Future<void> stop() async {
    await audioPlayer.stop();
    audioPlayer.seek(Duration.zero);
    isPlaying = false;
    notifyListeners();
  }

  Future<void> seek(Duration position) async {
    await audioPlayer.seek(position);
    notifyListeners();
  }

  void slidergerak() async {
    await audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying = event == PlayerState.PLAYING;
      print("value isssplaying $isPlaying");
      if (event == PlayerState.PLAYING) {
        isPlaying = true;
      } else {
        isPlaying = false;
      }
      notifyListeners();
    });

    await audioPlayer.onDurationChanged.listen((event) {
      duration = event;
      notifyListeners();
    });

    await audioPlayer.onAudioPositionChanged.listen((event) {
      position = event;
      notifyListeners();
    });

    await audioPlayer.onPlayerCompletion.listen((event) {
      audioPlayer.seek(Duration.zero);
      // print("selseai");

      isPlaying = false;
      audioPlayer.stop();
      notifyListeners();
    });
  }

  List<Tab> tabs = [
    Tab('Surah', Icons.local_shipping_outlined),
    Tab('Doa', Icons.payment),
  ];

  nextPage() async {
    // print("nomopage $numPages");
    if (currentPage == numPages) {
      /*   Navigator.push(
          context, MaterialPageRoute(builder: (context) => FullApp()));*/
    } else {
      currentPage = numPages;
      await pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
      // print("current " + currentPage.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  getDetailDoa(int id) async {
    var url = Uri.parse("${LinkApi.Link}doa/$id");
    var response = await http.get(url);

    var datdoa = json.decode(response.body);

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

  Future<List<Model_Surah>> getDataSurah() async {
    var url = Uri.parse("${LinkApi.Link}surat");
    var response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');

    List data = json.decode(response.body);

    if (response.statusCode == 200) {
      surah_model = (data).map((e) => Model_Surah.fromJson(e)).toList();
      print("okeeesurah " + data.toString());
      return surah_model;

      // return surah_model =
      //     (data).map((e) => Model_Surah.fromJson(e)).where((element) {
      //   final namasurah = element.namaLatin!.toLowerCase();
      //   final input = query.toLowerCase();

      //   return namasurah.contains(input);
      // }).toList();
    } else {
      print("gagal");

      return [];
    }
  }

  Future<Data_Android> getDataFromAPI() async {
    final response = await http
        .post(Uri.parse('https://alquran.gadroen.com/cek_android.php'));
    if (response.statusCode == 200) {
      print("okokokoko");
      var jsonData = jsonDecode(response.body);
      Data_Android asda = Data_Android();
      asda = Data_Android.fromJson(jsonData);
      print("bbbbb " + asda.versiAndroid.toString());
      notifyListeners();
      return Data_Android.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  getLastReadsVerse() async {
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

  saveLastReadVerse(
      String nama_surahs, int verseNumber, int nomor_surahs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('nama_surah', nama_surahs);
    await prefs.setInt('last_verse', verseNumber);
    await prefs.setInt('nomor_surah', nomor_surahs);
    lastVerse = prefs.getInt('last_verse') ?? 0;
    nomor_surah = prefs.getInt('nomor_surah') ?? 0;
    nama_surah = prefs.getString('nama_surah') ?? "";

    // getLastReadsVerse();
    notifyListeners();
  }

  Remove() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('last_verse');
      prefs.remove('nama_surah');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
    pageController.dispose(); // Dis
  }
}

class Provider_terakhirBaca extends ChangeNotifier {
  int lastVerse = 0;
  String nama_surah = "";
  int nomor_surah = 0;

  getLastReadsVerse() async {
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
}
