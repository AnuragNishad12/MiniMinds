import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElephantDetailPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  const ElephantDetailPage({Key? key, required this.name, required this.imageUrl}) : super(key: key);

  @override
  State<ElephantDetailPage> createState() => _ElephantDetailPageState();
}

class _ElephantDetailPageState extends State<ElephantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFd95e22),
          centerTitle: true,
          title: Text(widget.name,style:GoogleFonts.luckiestGuy(
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
