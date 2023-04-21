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
  List<Model_Doa> doa_model = [];
  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String nama_doa = "";
  String arab_doa = "";
  String latin_doa = "";
  String idn_Doa = "";
  String tentang_doa = "";

  var counter = 1;

  void reverseLogic() {
    if (counter == 1) {
      counter = 2;
    } else {
      counter = 1;
    }
    notifyListeners();
  }

  void changeIsPlaying() async {
    if (isPlaying == false) {
      await audioPlayer.play(
          "https://equran.nos.wjv-1.neo.id/audio-full/Misyari-Rasyid-Al-Afasi/001.mp3");
      isPlaying = true;
    } else {
      await audioPlayer.stop();
      isPlaying = false;
    }

    print('isplying $isPlaying');

    notifyListeners();
  }

  void changeDuration() {
    audioPlayer.onAudioPositionChanged.listen((event) {
      duration = event;
    });
    notifyListeners();
  }

  void changePosition() {
    audioPlayer.onAudioPositionChanged.listen((event) {
      position = event;
    });
    notifyListeners();
  }

  List<Tab> tabs = [
    Tab('Surah', Icons.local_shipping_outlined),
    Tab('Kumpulan Doa', Icons.payment),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
    pageController.dispose(); // Dis
  }
}
