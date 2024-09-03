import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrownBear extends StatefulWidget {


  @override
  State<BrownBear> createState() => _BrownBearState();
}

class _BrownBearState extends State<BrownBear> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFd95e22),
          centerTitle: true,
          title: Text(
            "Brown Bear",
            style: GoogleFonts.luckiestGuy(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                wordSpacing: 4,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
          ),
        )
    );
  }
}
