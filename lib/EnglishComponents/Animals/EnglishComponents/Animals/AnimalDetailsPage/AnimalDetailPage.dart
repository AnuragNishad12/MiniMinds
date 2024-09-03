import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/AnimalsPage/Bears.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/AnimalsPage/BrownBear.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/AnimalsPage/Panda.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/AnimalsPage/PolarBear.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/AnimalsPage/Sloth.dart';

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
  final List<Map<String, String>> animals = [
    {'name': 'Black Bear', 'imagePath': 'Animals/Bears/blackBears.jpeg'},
    {'name': 'Brown Bear', 'imagePath': 'Animals/Bears/brownBears.jpeg'},
    {'name': 'Panda', 'imagePath': 'Animals/Bears/panda.jpeg'},
    {'name': 'Polar Bear', 'imagePath': 'Animals/Bears/polarBear.jpeg'},
    {'name': 'Sloth', 'imagePath': 'Animals/Bears/sloth.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd95e22),
        centerTitle: true,
        title: Text(
          widget.name,
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
                  if (name == 'Brown Bear') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrownBear(
                          // name: name,
                          // imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'Black Bear') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlackBears(
                          // name: name,
                          // imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'Panda') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Panda(
                          name: name,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'Polar Bear') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PolarBear(
                          name: name,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'Sloth') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SlothPage(
                          name: name,
                          imageUrl: imageUrl,
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
                              textStyle: TextStyle(fontSize: 27.0),
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
