import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Panda extends StatefulWidget {
  final String name;
  final String imageUrl;

  const Panda({Key? key, required this.imageUrl,required this.name}):super(key: key);

  @override
  State<Panda> createState() => _PandaState();
}

class _PandaState extends State<Panda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFd95e22),
          centerTitle: true,
          title: Text(
            widget.name,
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
