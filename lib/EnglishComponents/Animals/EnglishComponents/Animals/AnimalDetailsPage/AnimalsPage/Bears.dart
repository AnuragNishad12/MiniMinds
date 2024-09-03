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
      body:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(16.0),
            child:GestureDetector(
              onTap: (){},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange,
                      offset: Offset(4, 4),
                      blurRadius: 10,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Ensure Row's width is just enough for its children
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Click Me!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Comic Sans MS',
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ) ,
            )
    ),
        ],
      )

    );
  }
}
