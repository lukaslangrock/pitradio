
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({
    Key? key,
    required this.current,
    required this.end,
  }) : super(key: key);

  final String current;
  final String end;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(
        current,
        style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
      ),
      Text(
        "/",
        style: GoogleFonts.robotoMono(),
      ),
      Text(
        end,
        style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
