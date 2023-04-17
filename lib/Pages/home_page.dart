import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';
import 'package:quran_app/Utils/TextUtils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.primaryColor,
      appBar: AppBar(
        elevation: 0,
        //toolbarHeight: 100,
        //create CircleImage and NameW
        title: Row(
          children: [
            Image.asset(
              'assets/images/icon_slide.png',
              width: 21,
              height: 15,
            ),
            const SizedBox(width: 20),
            //RichText
            Text(
              "Al-Qur'an",
              style: TextUtils.text_judul,
            ),

            //Create Menu left
            const Spacer(),

            //Create menu
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 30,
              decoration: BoxDecoration(
                color: ColorUtils.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Cari",
                  hintStyle: TextUtils.text_11,
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorUtils.warna_text_judul,
                  ),
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Asslamualaikum',
              style: TextUtils.text_14,
            ),
            Text('Bima Pratama', style: TextUtils.text_judul
                // TextStyle(
                //   fontSize: 24,
                //   color: ColorUtils.warna_text_judul,
                //   fontWeight: FontWeight.bold,
                //),
                ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorUtils.secondaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/last_read.png',
                            width: 16,
                            height: 13,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Terakhir dibaca',
                            style: TextUtils.text_13_2,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Al - Fatiha',
                        style: TextUtils.text_14_2,
                      ),
                      Text(
                        'Ayat no. 1',
                        style: TextUtils.text_11,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/icon_quran.png',
                    width: 74,
                    height: 84,
                  )
                ],
              ),
            )

            //Create menu list horizonal
          ],
        ),
      ),
    );
  }
}
