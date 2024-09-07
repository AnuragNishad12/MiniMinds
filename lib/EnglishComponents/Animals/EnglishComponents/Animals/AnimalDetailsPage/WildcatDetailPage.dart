import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Cheetah.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Cougar.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Jaguar.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Leopard.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Lion.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Lynx.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Ocelot.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Puma.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/SnowLeopard.dart';
import 'package:mini_minds/EnglishComponents/Animals/Cats/Tiger.dart';

class WildcatDetailPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  const WildcatDetailPage({Key? key, required this.name, required this.imageUrl}) : super(key: key);

  @override
  State<WildcatDetailPage> createState() => _WildcatDetailPageState();
}

class _WildcatDetailPageState extends State<WildcatDetailPage> {
  final List<Map<String, String>> animals = [
    {'name': 'Lion', 'imagePath': 'Animals/Cats/Lion.jpeg'},
    {'name': 'Tiger', 'imagePath': 'Animals/Cats/Tiger.jpeg'},
    {'name': 'Leopard', 'imagePath': 'Animals/Cats/Leopard.jpeg'},
    {'name': 'Jaguar', 'imagePath': 'Animals/Cats/Jaguar.jpeg'},
    {'name': 'Snow Leopard', 'imagePath': 'Animals/Cats/Snow Leopard.jpeg'},
    {'name': 'Cougar', 'imagePath': 'Animals/Cats/Cougar.jpeg'},
    {'name': 'Cheetah', 'imagePath': 'Animals/Cats/Cheetah.jpeg'},
    {'name': 'Puma', 'imagePath': 'Animals/Cats/Puma.jpeg'},
    {'name': 'Lynx', 'imagePath': 'Animals/Cats/Lynx.jpeg'},
    {'name': 'Ocelot', 'imagePath': 'Animals/Cats/Ocelot.jpeg'},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd95e22),
        centerTitle: true,
        title: Text(widget.name, style: GoogleFonts.luckiestGuy(
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
                  if (name == 'Lion') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Lion(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  } else if (name == 'Tiger') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Tiger(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  } else if (name == 'Leopard') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Leopard(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Jaguar') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Jaguar(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Snow Leopard') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        SnowLeopard(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Cougar') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Cougar(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Cheetah') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Cheetah(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Puma') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Puma(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Lynx') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Lynx(
                              // name: name,
                              // imageUrl: imageUrl,
                            ),
                      ),
                    );
                  }else if (name == 'Ocelot') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Ocelot(
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

