import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AnimalsList extends StatefulWidget {
  @override
  _AnimalsListState createState() => _AnimalsListState();
}

class _AnimalsListState extends State<AnimalsList> {
  final List<Map<String, String>> animals = [
    {'name': 'Bears', 'imagePath': 'Animals/bears.jpeg'},
    {'name': 'Elephants', 'imagePath': 'Animals/elephents.jpeg'},
    {'name': 'Wildcats', 'imagePath': 'Animals/wildcats.jpeg'},
    {'name': 'Wildfox', 'imagePath': 'Animals/wildfox.jpeg'},
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

              return Card(
                child: ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(name),
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
