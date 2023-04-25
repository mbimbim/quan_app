import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ColorsUtils.dart';

class TextUtils {
  static final TextStyle text_judul = GoogleFonts.poppins().copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: ColorUtils.warna_text_judul,
  );

  static final TextStyle text_18 = GoogleFonts.poppins().copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: ColorUtils.warna_text_judul,
  );

  static final TextStyle text_13 = GoogleFonts.poppins().copyWith(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: ColorUtils.warna_text,
  );

  static final TextStyle text_13_miring = GoogleFonts.poppins().copyWith(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: ColorUtils.warna_text,
      fontStyle: FontStyle.italic);

  static final TextStyle text_13_2 = GoogleFonts.amiri().copyWith(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: ColorUtils.warna_text_judul,
  );

  static final TextStyle text_14 = GoogleFonts.poppins().copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorUtils.warna_text,
  );

  static final TextStyle text_14_2 = GoogleFonts.poppins().copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorUtils.warna_text_judul,
  );

  static final TextStyle text_11 = GoogleFonts.poppins().copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: ColorUtils.warna_text_judul,
  );

  static final TextStyle ayat = GoogleFonts.lateef().copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: ColorUtils.warna_text_judul,
  );
}
