import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlackBears extends StatefulWidget {
  const BlackBears({super.key});





  @override
  State<BlackBears> createState() => _BlackBearsState();
}

class _BlackBearsState extends State<BlackBears> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFd95e22),
          centerTitle: true,
          title: Text(
            "Black Bears",
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
        ),
      // body: ,
    );
  }
}
