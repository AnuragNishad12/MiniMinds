import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_minds/EnglishComponents/Animals/AnimalsList.dart';
import 'package:mini_minds/EnglishComponents/AtoZScreen/AZScreen.dart';

class FrontEnglishPage extends StatefulWidget {
  const FrontEnglishPage({super.key});

  @override
  State<FrontEnglishPage> createState() => _FrontEnglishPageState();
}

class _FrontEnglishPageState extends State<FrontEnglishPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd95e22),
        centerTitle: true,
        title: Text("Learning English",style:GoogleFonts.luckiestGuy(
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
          child:
          Padding(
            padding: const EdgeInsets.all(8.0), // Adjust padding as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap:  () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AZScreen()),
          );
    },
                  child:
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFf0ca83),
                    borderRadius: BorderRadius.circular(20.0), // Adjust radius as needed
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("A To Z",style:GoogleFonts.rubikSprayPaint(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        wordSpacing: 4,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                    ),
                  ),
                ),
          ),
      InkWell(
        onTap:  () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnimalsList()),
          );
        },child:
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFf0ca83),
                    borderRadius: BorderRadius.circular(20.0), // Adjust radius as needed
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Animals",style:GoogleFonts.rubikSprayPaint(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        wordSpacing: 4,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                    ),
                  ),
                ),
      )
              ],
            ),
          ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child:
            Padding(
              padding: const EdgeInsets.all(8.0), // Adjust padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFf0ca83),
                      borderRadius: BorderRadius.circular(20.0), // Adjust radius as needed
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Fishes",style:GoogleFonts.rubikSprayPaint(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          wordSpacing: 4,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFf0ca83),
                      borderRadius: BorderRadius.circular(20.0), // Adjust radius as needed
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Puzzels",style:GoogleFonts.rubikSprayPaint(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          wordSpacing: 4,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


