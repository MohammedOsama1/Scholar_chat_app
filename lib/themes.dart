import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

Color primaryClr = const Color(0xff2B475E);

TextStyle get primaryStyle {
  return GoogleFonts.pattaya(
      fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white);
}

void showToast (msg,color) {

  return Toast.show(msg, duration: 4, gravity:  Toast.center,backgroundColor: color );
}
