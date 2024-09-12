import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PuzzelsScreen extends StatefulWidget {
  const PuzzelsScreen({super.key});

  @override
  State<PuzzelsScreen> createState() => _PuzzelsScreenState();
}

class _PuzzelsScreenState extends State<PuzzelsScreen> {
  String correctLetter = '';
  String imageUrl = '';
  @override
  void initState() {
    super.initState();
    loadImage(); // Fetch image from Firebase Storage
  }

  Future<void> loadImage() async {
    // Replace 'images/apple.png' with the path of your image in Firebase Storage
    String downloadUrl = await FirebaseStorage.instance
        .ref('AtoZ/apple.jpeg')
        .getDownloadURL();

    setState(() {
      imageUrl = downloadUrl; // Set the fetched URL to the imageUrl state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alphabet Puzzle"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageUrl.isNotEmpty
              ? ClipRRect(
            borderRadius: BorderRadius.circular(20), // Rounded corners
            child: Image.network(
              imageUrl,
              height: 150,
              fit: BoxFit.cover, // Ensure image fits nicely in the box
            ),
          )
              : CircularProgressIndicator(), // Show loader until image is fetche
          SizedBox(height: 20),
          Text(
            'Drag the correct letter to complete the word: "A_P_L_E"',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),

          // DragTarget to drop letter A
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DragTarget<String>(
                onAccept: (data) {
                  if (data == "A") {
                    setState(() {
                      correctLetter = data;
                    });
                  }
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    color: correctLetter == "A" ? Colors.green : Colors.grey,
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Text(
                        correctLetter == "A" ? "A" : "Drop A",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 10),
              Text("_P_L_E", style: TextStyle(fontSize: 24)),
            ],
          ),
          SizedBox(height: 40),

          // Draggable letters
          Wrap(
            spacing: 20,
            children: [
              Draggable<String>(
                data: "A",
                feedback: LetterTile(letter: "A"),
                childWhenDragging: LetterTile(letter: ""),
                child: LetterTile(letter: "A"),
              ),
              Draggable<String>(
                data: "B",
                feedback: LetterTile(letter: "B"),
                childWhenDragging: LetterTile(letter: ""),
                child: LetterTile(letter: "B"),
              ),
              Draggable<String>(
                data: "C",
                feedback: LetterTile(letter: "C"),
                childWhenDragging: LetterTile(letter: ""),
                child: LetterTile(letter: "C"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LetterTile extends StatelessWidget {
  final String letter;

  LetterTile({required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    );
  }
}