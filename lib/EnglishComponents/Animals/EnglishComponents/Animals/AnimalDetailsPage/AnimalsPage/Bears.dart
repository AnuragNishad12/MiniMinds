import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_minds/EnglishComponents/Animals/AnimalDetailsPage/AnimalsPage/BlackBearsArView.dart';
import 'package:permission_handler/permission_handler.dart';

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
        .child('Animals/Bears/BearsSlider')
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>BlackBearsArView())
                  );
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



Future<void> checkPermissions() async {
  // Check the current status of the camera permission
  var status = await Permission.camera.status;

  if (status.isDenied) {
    // Request permission if it's not granted
    await Permission.camera.request();
  }

  if (status.isPermanentlyDenied) {
    // Handle the permanently denied case by showing a dialog or redirecting to settings
    // For example, you might want to show a dialog to the user informing them how to enable permissions in settings
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
                // Optional: Add decoration if needed
              ),
              child: Image.network(url, fit: BoxFit.cover),
            );
          },
        );
      }).toList(),
    );
  }
}



