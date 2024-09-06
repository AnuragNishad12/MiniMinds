import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Bears.dart';

class AsianElephant extends StatefulWidget {
  const AsianElephant({super.key});

  @override
  State<AsianElephant> createState() => _AsianElephantState();
}

class _AsianElephantState extends State<AsianElephant> {
  List<String> _imageUrls = [];
  bool _isLoading = false;

  Future<void> _showImageSlider() async {
    setState(() {
      _isLoading = true;
    });

    _imageUrls = await _getImageUrls();

    setState(() {
      _isLoading = false;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 400.0, // Specify a height for the image slider
            width: MediaQuery.of(context).size.width * 0.8, // Specify a width for the image slider
            child: ImageSlider(imageUrls: _imageUrls),
          ),
        );
      },
    );
  }

  Future<List<String>> _getImageUrls() async {
    ListResult result = await FirebaseStorage.instance
        .ref()
        .child('Animals/Elephents/AsianElephant')
        .listAll();
    List<String> imageUrls = [];

    for (var ref in result.items) {
      String url = await ref.getDownloadURL();
      imageUrls.add(url);
    }

    return imageUrls;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd95e22),
        centerTitle: true,
        title: Text(
          "Asian Elephant",
          style: GoogleFonts.luckiestGuy(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 4,
              decorationStyle: TextDecorationStyle.dashed,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: _showImageSlider,
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
                          mainAxisSize: MainAxisSize.min,
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
                      ),
                    ),
                  ),
                ],
              ),
              if (_isLoading)
                CircularProgressIndicator(),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child:InkWell(
              onTap: (){

              },
              child: Container(
                  width: 100.0,
                  height: 100.0,
                  padding: EdgeInsets.all(8.0), // Add padding inside the container
                  decoration: BoxDecoration(
                    color: Color(0x80BEBEBE), // 50% transparent grey background
                    borderRadius: BorderRadius.circular(15.0), // Add border radius
                    border: Border.all(
                      color: Colors.orange, // Orange border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/ArGlass.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                      Text("Ar View",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
