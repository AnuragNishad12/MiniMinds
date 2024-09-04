import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlackBears extends StatefulWidget {
  const BlackBears({super.key});

  @override
  State<BlackBears> createState() => _BlackBearsState();
}

class _BlackBearsState extends State<BlackBears> {
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
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8, // Specify a width for the image slider
            child: ImageSlider(imageUrls: _imageUrls),
          ),
        );
      },
    );
  }

  Future<List<String>> _getImageUrls() async {
    ListResult result = await FirebaseStorage.instance.ref().child(
        'Animals/Bears/BearsSlider').listAll();
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: _showImageSlider,
                  // Call the method to show the image slider
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
          // Show a loading indicator while fetching images
        ],
      ),
    );
  }
}


  class ImageSlider extends StatelessWidget {
  final List<String> imageUrls;

  ImageSlider({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
  return CarouselSlider(
  options: CarouselOptions(
  height: 300.0, // Ensure a fixed height for each image in the slider
  viewportFraction: 1.0, // Adjust this to change the image size in the viewport
  ),
  items: imageUrls.map((url) {
  return Builder(
  builder: (BuildContext context) {
  return Container(
  width: MediaQuery.of(context).size.width,
  margin: EdgeInsets.symmetric(horizontal: 5.0),
  decoration: BoxDecoration(
  // color: Colors.amber,
  ),
  child: Image.network(url, fit: BoxFit.cover),
  );
  },
  );
  }).toList(),
  );
  }
  }
