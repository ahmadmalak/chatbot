import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      required this.label,
      this.fontSize = 18,
      this.color,
      this.fontWeight,
      this.isUnderlined = false}) // Add this line
      : super(key: key);

  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final bool isUnderlined; // Add this line

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.anonymousPro(
        fontSize: fontSize,
        color: color ?? Colors.white,
        fontWeight: fontWeight,
      ),
    );
  }
}
