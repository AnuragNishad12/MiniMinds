import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/AnimalDetailPage.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/ElephantDetailPage.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/WolfDetailPage.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/WildfoxDetailPage.dart';
import 'package:mini_minds/EnglishComponents/Animals/EnglishComponents/Animals/AnimalDetailsPage/WildcatDetailPage.dart';




class AnimalsList extends StatefulWidget {
  @override
  _AnimalsListState createState() => _AnimalsListState();
}

class _AnimalsListState extends State<AnimalsList> {
  final List<Map<String, String>> animals = [
    {'name': 'Bears', 'imagePath': 'Animals/bears.jpeg'},
    {'name': 'Elephants', 'imagePath': 'Animals/elephents.jpeg'},
    {'name': 'Wildcats', 'imagePath': 'Animals/wildcats.jpeg'},
    {'name': 'Wildfoxs', 'imagePath': 'Animals/wildfox.jpeg'},
    {'name': 'Wolves', 'imagePath': 'Animals/wolfs.jpeg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animals List'),
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
                  if (name == 'Bears') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimalDetailPage(
                          name: name,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'Elephants') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ElephantDetailPage(
                          name: name,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'Wildcats') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WildcatDetailPage(
                          name: name,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'Wildfoxs') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WildfoxDetailPage(
                          name: name,
                          imageUrl: imageUrl,
                        ),
                      ),
                    );
                  } else if (name == 'Wolves') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WolfDetailPage(
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


