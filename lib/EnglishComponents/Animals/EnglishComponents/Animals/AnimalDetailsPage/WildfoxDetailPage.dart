import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Fox/ArcticFox.dart';
import '../../../Fox/BengalFox.dart';
import '../../../Fox/FuFox.dart';
import '../../../Fox/GrayFox.dart';
import '../../../Fox/RedFox.dart';

class WildfoxDetailPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  const WildfoxDetailPage({Key? key, required this.name, required this.imageUrl}) : super(key: key);

  @override
  State<WildfoxDetailPage> createState() => _WildfoxDetailPageState();
}

class _WildfoxDetailPageState extends State<WildfoxDetailPage> {
  final List<Map<String, String>> animals = [
    {'name': 'Red Fox', 'imagePath': 'Animals/Fox/Red Fox.jpeg'},
    {'name': 'Arctic Fox', 'imagePath': 'Animals/Fox/Arctic Fox.jpeg'},
    {'name': 'Fennec Fox', 'imagePath': 'Animals/Fox/Fennec Fox.jpeg'},
    {'name': 'Gray Fox', 'imagePath': 'Animals/Fox/Gray Fox.jpeg'},
    {'name': 'Bengal Fox', 'imagePath': 'Animals/Fox/Bengal Fox.jpeg'},
  ];



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
        ),
      body: ListView.builder(
        itemCount: animals.length,
        itemBuilder: (context, index) {
          final animal = animals[index];
          final name = animal['name']!;
          final imagePath = animal['imagePath']!;

          return FutureBuilder<String>(
            future: _getImageUrl(imagePath),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.error),
                    title: Text('Error loading image'),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.image_not_supported),
                    title: Text('No image available'),
                  ),
                );
              }

              final imageUrl = snapshot.data!;

              return GestureDetector(
                onTap: () {
                  // Navigate to the appropriate detail page based on the animal's name
                  if (name == 'Red Fox') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        RedFox(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  } else if (name == 'Arctic Fox') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        ArcticFox(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  } else if (name == 'Fennec Fox') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        FennecFox(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Gray Fox') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        GrayFox(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Bengal Fox') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        BengalFox(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }
                },
                child: Card(
                  child: Container(
                    width: double.infinity,
                    height: 100.0,
                    child: Row(
                      children: [
                        Image.network(
                          imageUrl,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Text(
                            name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pacifico(
                              textStyle: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<String> _getImageUrl(String imagePath) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(imagePath);
    final url = await ref.getDownloadURL();
    return url;
  } catch (e) {
    print('Error fetching image URL: $e');
    return '';
  }
}


