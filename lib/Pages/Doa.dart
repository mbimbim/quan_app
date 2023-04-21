import 'package:flutter/material.dart';
import 'package:quran_app/Utils/ColorsUtils.dart';

import '../Utils/TextUtils.dart';
import 'Detail_Doa.dart';

class ListDoa extends StatelessWidget {
  String no;
  String nama;
  String tentang;
  ListDoa(
      {Key? key, required this.no, required this.nama, required this.tentang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detail_Doa(id: int.parse(no))));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            Row(children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    child: Text(
                      'No. $no',
                      style: TextUtils.text_14_2,
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text(nama, style: TextUtils.text_14_2)),
                ],
              ),
              //const Spacer(),

              //Create menu
              //Text(tentang)
            ]),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: ColorUtils.warna_text,
            )
          ],
        ),
      ),
    );
  }
}
