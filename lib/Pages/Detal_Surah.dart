// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Providers/Provider.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'Detail_Surah2.dart';

class DetailSurah extends ConsumerStatefulWidget {
  String nomorSurah;
  String namaSurah;
  bool terakhir_baca;
  DetailSurah(
      {Key? key,
      required this.nomorSurah,
      required this.namaSurah,
      required this.terakhir_baca})
      : super(key: key);

  @override
  DetailSurahState createState() => DetailSurahState();
}

class DetailSurahState extends ConsumerState<DetailSurah> {
  bool isPlaying = false;
  final ScrollController _controller = ScrollController();

  int surah_baca = 5;

  final itemKey = GlobalKey();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final ScrollController cobaaja = ScrollController();

  Future scrollItem() async {
    final contextss = itemKey.currentContext!;
    await Scrollable.ensureVisible(contextss);
  }
  //final coba = Providersss();
  // Stream duration = Duration.zero;
  // Duration position = Duration.zero;

  @override
  void initState() {
    // _scrollToItem(6); // fokus pada item nomor 7
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
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getDataObjek = ref.watch(tembakApi);
    final getDetailSurah =
        ref.watch(ApiProviderDetailSurah(int.parse(widget.nomorSurah)));

    final play_audio = ref.watch(authControllerProvider);
    //final audioPlayer = ref.watch(audioPlayerProvider.notifier);
    //   play_audio.seek(Duration(seconds: 0));
    play_audio.sss();

    return WillPopScope(
      onWillPop: () {
        play_audio.stop();
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
                play_audio.stop();
                Navigator.of(context).pop();
                return Future.value(true);
              }),
          title: Text(
            widget.namaSurah + " " + widget.nomorSurah,
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
                      widget.terakhir_baca == true
                          ? GestureDetector(
                              onTap: () {
                                itemScrollController.scrollTo(
                                    index: play_audio.lastVerse - 1,
                                    duration: const Duration(seconds: 1));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorUtils.warna_icon,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: ColorUtils.secondaryColor)),
                                child: Text(
                                  'Pergi ke terakhir baca',
                                  style: GoogleFonts.poppins().copyWith(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          return Row(
                            children: [
                              // IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(
                              //       Icons.share,
                              //       color: ColorUtils.warna_icon,
                              //     )),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    // play_audio.play(
                                    //     'https://equran.nos.wjv-1.neo.id/audio-full/Misyari-Rasyid-Al-Afasi/001.mp3');

                                    play_audio.togglePlayStop(
                                        getDataObjek.audio_objek);
                                    // audioPlayer.togglePlayStop(
                                    //     getDataObjek.audio_objek);
                                    // setState(() {
                                    //   audioPlayer.satatusplay();
                                    //   isPlaying = audioPlayer.satatusplay();
                                    // });
                                    // await audioPlayer.play(
                                    //     'https://equran.nos.wjv-1.neo.id/audio-full/Misyari-Rasyid-Al-Afasi/001.mp3');
                                    // play_audio.awal();
                                    // play_audio.changeIsPlaying();
                                  },
                                  // final audioPlayer = ref.watch(audioPlayerProvider.notifier);
                                  icon: Icon(
                                    play_audio.isPlaying
                                        ? Icons.pause
                                        : Icons.play_circle_fill_outlined,
                                    color: ColorUtils.warna_icon,
                                    size: 40,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              // IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(Icons.bookmark_add,
                              //         color: ColorUtils.warna_icon)),
                            ],
                          );
                        },
                      ),

                      // Consumer(
                      //   builder: (context, watch, child) {
                      //     final position =
                      //         watch.watch(audioPlayerPositionProvider);
                      //     final duration =
                      //         watch.watch(audioPlayerDurationProvider);
                      //     return Slider(
                      //       activeColor: ColorUtils.warna_text_judul,
                      //       inactiveColor: Colors.grey,
                      //       //thumbColor: Color.black38,
                      //       value: position.when(
                      //         data: (value) => value.inSeconds.toDouble(),
                      //         loading: () => 0.0,
                      //         error: (_, __) => 0.0,
                      //       ),
                      //       min: 0.0,
                      //       max: duration.when(
                      //         data: (value) => value.inSeconds.toDouble(),
                      //         loading: () => 0.0,
                      //         error: (_, __) => 0.0,
                      //       ),
                      //       onChanged: (double value) {
                      //         audioPlayer
                      //             .seek(Duration(seconds: value.toInt()));
                      //       },
                      //     );
                      //   },
                      // ),
                      Slider(
                          activeColor: ColorUtils.warna_text_judul,
                          inactiveColor: Colors.grey,
                          min: 0,
                          max: play_audio.duration.inSeconds.toDouble(),
                          value: play_audio.position.inSeconds.toDouble(),
                          onChanged: (value) {
                            final position = Duration(seconds: value.toInt());
                            play_audio.audioPlayer.seek(position);
                            //    play_audio.audioPlayer.resume();
                          })
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: getDetailSurah.when(
                data: (data) {
                  return ScrollablePositionedList.builder(
                    addAutomaticKeepAlives: true,
                    addSemanticIndexes: true,
                    addRepaintBoundaries: true,
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Detail_surah2(
                        indexx: index + 1,
                        nomor_surah: int.parse(widget.nomorSurah),
                        surah: widget.namaSurah,
                        ref: ref,
                        ayat: data[index].ar!,
                        ayat_indo: data[index].tr!,
                        artinya: data[index].idn!,
                        no: data[index].nomor!,
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error: $err'),
              ),
            )
          ],
        ),

        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   itemScrollController.scrollTo(
        //       index: play_audio.lastVerse,
        //       duration: Duration(microseconds: 2000));
        // }),
      ),
    );
  }
}
