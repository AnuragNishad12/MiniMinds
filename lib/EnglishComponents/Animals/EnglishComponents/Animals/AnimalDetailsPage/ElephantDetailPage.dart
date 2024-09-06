import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/AnimalsPage/AsianElephant.dart';
import 'AnimalsPage/AfricanForestElephant.dart';
import 'AnimalsPage/AfricanSavanna.dart';

class ElephantDetailPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  const ElephantDetailPage({Key? key, required this.name, required this.imageUrl}) : super(key: key);

  @override
  State<ElephantDetailPage> createState() => _ElephantDetailPageState();
}

class _ElephantDetailPageState extends State<ElephantDetailPage> {
  final List<Map<String, String>> animals = [
    {'name': 'AfricanSavannaElephant', 'imagePath': 'Animals/Elephents/African Savanna Elephant.jpeg'},
    {'name': 'AfricanForestElephant', 'imagePath': 'Animals/Elephents/African Forest Elephant.jpeg'},
    {'name': 'AsianElephant', 'imagePath': 'Animals/Elephents/Asian Elephant.jpeg'},
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
                  if (name == 'AfricanSavannaElephant') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AfricanSavannaElephant(
                          // name: name,
                          // imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'AfricanForestElephant') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AfricanForestElephant(
                          // name: name,
                          // imageUrl: imageUrl,
                        ),
                      ),
                    );
                  }else if (name == 'AsianElephant') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AsianElephant(
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
}
