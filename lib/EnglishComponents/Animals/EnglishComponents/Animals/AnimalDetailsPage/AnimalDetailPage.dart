import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimalDetailPage extends StatefulWidget {
  final String name;
  final String imageUrl;

  const AnimalDetailPage({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);



  @override
  State<AnimalDetailPage> createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
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
