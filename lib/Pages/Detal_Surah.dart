// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/Providers/Provider.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';
import 'package:audioplayers/audioplayers.dart';

import 'Detail_Surah2.dart';

class DetailSurah extends ConsumerStatefulWidget {
  String nomorSurah;
  String namaSurah;
  DetailSurah({Key? key, required this.nomorSurah, required this.namaSurah})
      : super(key: key);

  @override
  DetailSurahState createState() => DetailSurahState();
}

class DetailSurahState extends ConsumerState<DetailSurah> {
  bool isPlaying = false;
  // Stream duration = Duration.zero;
  // Duration position = Duration.zero;

  @override
  void initState() {
    // audioPlayer.onPlayerStateChanged.listen((event) {
    //   setState(() {
    //     isPlaying = event == PlayerState.PLAYING;
    //   });

    //   audioPlayer.onDurationChanged.listen((event) {
    //     setState(() {
    //       duration = event;
    //     });
    //   });

    //   audioPlayer.onAudioPositionChanged.listen((event) {
    //     setState(() {
    //       position = event;
    //     });
    //   });
    // });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getDataObjek = ref.watch(tembakApi);
    final getDetailSurah =
        ref.watch(ApiProviderDetailSurah(int.parse(widget.nomorSurah)));

    final play_audio = ref.watch(authControllerProvider);
    final audioPlayer = ref.watch(audioPlayerProvider.notifier);
    audioPlayer.seek(Duration(seconds: 0));

    return WillPopScope(
      onWillPop: () {
        audioPlayer.stop();
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: ColorUtils.primaryColor,
          appBar: AppBar(
            backgroundColor: ColorUtils.primaryColor,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorUtils.warna_icon,
                ),
                onPressed: () async {
                  audioPlayer.stop();
                  Navigator.of(context).pop();
                  return Future.value(true);
                }),
            title: Text(
              widget.namaSurah,
              style: TextUtils.text_judul,
            ),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                //color: Colors.amber,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.namaSurah,
                          style: TextUtils.text_14_2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Jumlah Ayat : ${getDataObjek.jumlah_ayat_objek}',
                          style: TextUtils.text_11,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Turun di : ${getDataObjek.tempat_turun_objek}',
                          style: TextUtils.text_11,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            return Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share,
                                      color: ColorUtils.warna_icon,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      audioPlayer.togglePlayStop(
                                          getDataObjek.audio_objek);
                                      setState(() {
                                        audioPlayer.satatusplay();
                                        isPlaying = audioPlayer.satatusplay();
                                      });
                                      // await audioPlayer.play(
                                      //     'https://equran.nos.wjv-1.neo.id/audio-full/Misyari-Rasyid-Al-Afasi/001.mp3');
                                      // play_audio.awal();
                                      // play_audio.changeIsPlaying();
                                    },
                                    // final audioPlayer = ref.watch(audioPlayerProvider.notifier);
                                    icon: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: ColorUtils.warna_icon)),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.bookmark_add,
                                        color: ColorUtils.warna_icon)),
                              ],
                            );
                          },
                        ),
                        Consumer(
                          builder: (context, watch, child) {
                            final position =
                                watch.watch(audioPlayerPositionProvider);
                            final duration =
                                watch.watch(audioPlayerDurationProvider);
                            return Slider(
                              activeColor: ColorUtils.warna_text_judul,
                              inactiveColor: Colors.grey,
                              //thumbColor: Color.black38,
                              value: position.when(
                                data: (value) => value.inSeconds.toDouble(),
                                loading: () => 0.0,
                                error: (_, __) => 0.0,
                              ),
                              min: 0.0,
                              max: duration.when(
                                data: (value) => value.inSeconds.toDouble(),
                                loading: () => 0.0,
                                error: (_, __) => 0.0,
                              ),
                              onChanged: (double value) {
                                audioPlayer
                                    .seek(Duration(seconds: value.toInt()));
                              },
                            );
                          },
                        ),
                        // Slider(
                        //     min: 0,
                        //     max: play_audio.duration.inSeconds.toDouble(),
                        //     value: play_audio.position.inSeconds.toDouble(),
                        //     onChanged: (value) {
                        //       final position = Duration(seconds: value.toInt());
                        //       play_audio.audioPlayer.seek(position);
                        //       play_audio.audioPlayer.resume();
                        //     })
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: getDetailSurah.when(
                  data: (data) {
                    return Scrollbar(
                      isAlwaysShown: true,
                      hoverThickness: 10,
                      showTrackOnHover: true,
                      trackVisibility: true,
                      thickness: 5,
                      radius: Radius.circular(20),
                      interactive: true,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Detail_surah2(
                            ayat: data[index].ar!,
                            ayat_indo: data[index].tr!,
                            artinya: data[index].idn!,
                            no: data[index].nomor!,
                          );
                        },
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Text('Error: $err'),
                ),
              )
            ],
          )),
    );
  }

  // loading(BuildContext context, String url, WidgetRef sss) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         //   Navigator.of(context).pop(hide);

  //         return AlertDialog(
  //           content: SizedBox(
  //             width: 200,
  //             height: 130,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 IconButton(
  //                     onPressed: () async {
  //                       if (sss.watch(authControllerProvider).isPlaying) {
  //                         await sss
  //                             .watch(authControllerProvider)
  //                             .audioPlayer
  //                             .pause();
  //                       } else {
  // await sss.watch(authControllerProvider).audioPlayer.play(
  //     "https://equran.nos.wjv-1.neo.id/audio-full/Misyari-Rasyid-Al-Afasi/001.mp3");
  //                       }
  //                     },
  //                     icon: Icon(sss.watch(authControllerProvider).isPlaying
  //                         ? Icons.pause
  //                         : Icons.play_arrow)),
  //                 Slider(
  //                     min: 0,
  //                     max: sss
  //                         .watch(authControllerProvider)
  //                         .duration
  //                         .inSeconds
  //                         .toDouble(),
  //                     value: sss
  //                         .watch(authControllerProvider)
  //                         .position
  //                         .inSeconds
  //                         .toDouble(),
  //                     onChanged: ((value) async {
  //                       final positions = Duration(seconds: value.toInt());
  //                       await sss
  //                           .watch(authControllerProvider)
  //                           .audioPlayer
  //                           .seek(positions);
  //                       await sss
  //                           .watch(authControllerProvider)
  //                           .audioPlayer
  //                           .resume();
  //                     }))
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

}
