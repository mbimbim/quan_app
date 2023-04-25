import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import '../Providers/Provider.dart';
import '../Utils/ColorsUtils.dart';
import '../Utils/TextUtils.dart';

class Detail_Doa extends ConsumerWidget {
  int id;
  Detail_Doa({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var share_namadoa,
        share_arab,
        share_arab_indo,
        share_artinya,
        share_tentang;

    var bismillah = "بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ";
    final getDoa = ref.watch(authControllerProvider);
    getDoa.getDetailDoa(id);
    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: ColorUtils.warna_icon,
              ),
            ),
            //RichText

            Container(
              width: 200,
              child: Text(
                bismillah,
                textAlign: TextAlign.center,
                style: TextUtils.text_judul,
              ),
            ),

            //  const Spacer(),

            //Create Menu left

            //Create menu
            GestureDetector(
              onTap: () {
                Share.share(
                    "$bismillah\n\n$share_namadoa\n\n$share_arab\n\n$share_arab_indo\n\nartinya :\n$share_artinya\n\nTentang : \n$share_tentang");
              },
              child: Icon(
                Icons.share_rounded,
                color: ColorUtils.warna_icon,
              ),
            )
          ],
        ),
        // IconButton(
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: ColorUtils.warna_icon,
        //     ),
        //     onPressed: () async {
        //       Navigator.of(context).pop();
        //     }),
        // title: Center(
        //   child: Container(
        //     width: 300,
        //     child: Text(
        //       "بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
        //       textAlign: TextAlign.center,
        //       style: TextUtils.text_judul,
        //     ),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getDoa.getDetailDoa(id),
          builder: (context, snapshot) {
            share_arab = getDoa.arab_doa;
            share_arab_indo = getDoa.latin_doa;
            share_artinya = getDoa.idn_Doa;
            share_tentang = getDoa.tentang_doa;
            share_namadoa = getDoa.nama_doa;
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorUtils.warna_icon),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            getDoa.nama_doa,
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
                            getDoa.arab_doa,
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
                            getDoa.latin_doa,
                            style: TextUtils.text_13_2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Artinya :",
                      textAlign: TextAlign.left,
                      style: TextUtils.text_13_miring,
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
                            getDoa.idn_Doa,
                            style: TextUtils.text_13_miring,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Keterangan :",
                      textAlign: TextAlign.left,
                      style: TextUtils.text_13_miring,
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
                            getDoa.tentang_doa,
                            style: TextUtils.text_13_miring,
                          ),
                        ),
                      ],
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
