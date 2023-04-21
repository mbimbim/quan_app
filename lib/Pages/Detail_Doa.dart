import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Providers/Provider.dart';
import '../Utils/ColorsUtils.dart';
import '../Utils/TextUtils.dart';

class Detail_Doa extends ConsumerWidget {
  int id;
  Detail_Doa({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getDoa = ref.watch(authControllerProvider);
    getDoa.getDetailDoa(id);
    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.primaryColor,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ColorUtils.warna_icon,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
            }),
        title: Center(
          child: Container(
            width: 300,
            child: Text(
              "بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
              textAlign: TextAlign.center,
              style: TextUtils.text_judul,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getDoa.getDetailDoa(id),
          builder: (context, snapshot) {
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
