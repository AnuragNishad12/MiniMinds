import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Wolf/ArcticWolf.dart';
import '../../../Wolf/EasternWolf.dart';
import '../../../Wolf/GrayWolf.dart';
import '../../../Wolf/HimalayanWolf.dart';
import '../../../Wolf/RedWolf.dart';

class WolfDetailPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  const WolfDetailPage({Key? key, required this.name, required this.imageUrl}) : super(key: key);

  @override
  State<WolfDetailPage> createState() => _WolfDetailPageState();
}

class _WolfDetailPageState extends State<WolfDetailPage> {
  final List<Map<String, String>> animals = [
    {'name': 'ArcticWolf', 'imagePath': '/Animals/Wolf/Arctic Wolf.jpeg'},
    {'name': 'Eastern Wolf', 'imagePath': '/Animals/Wolf/Eastern Wolf.jpeg'},
    {'name': 'Gray Wolf', 'imagePath': '/Animals/Wolf/GrayWolf.jpeg'},
    {'name': 'Himalayan Wolf', 'imagePath': '/Animals/Wolf/Himalayan Wolf.jpeg'},
    {'name': 'Red Wolf', 'imagePath': '/Animals/Wolf/Red Wolf.jpeg'},
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
                  if (name == 'Gray Wolf') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        GrayWolf(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  } else if (name == 'ArcticFox') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArcticWolf(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  } else if (name == 'Eastern Wolf') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        EasternWolf(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Himalayan Wolf') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        HimalayanWolf(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Red Wolf') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        RedWolf(
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
