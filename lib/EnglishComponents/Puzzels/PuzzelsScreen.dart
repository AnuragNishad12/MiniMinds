import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PuzzelsScreen extends StatefulWidget {
  const PuzzelsScreen({super.key});

  @override
  State<PuzzelsScreen> createState() => _PuzzelsScreenState();
}

class _PuzzelsScreenState extends State<PuzzelsScreen> {
  String correctLetter = '';
  String imageUrl = '';
  bool isCompleted = false;

  @override
  void initState() {
    super.initState();
    _checkCompletion(); // Check if puzzle is completed
    _loadImageFromPrefs(); // Fetch image from SharedPreferences
  }

  Future<void> loadImage() async {
    try {
      String downloadUrl = await FirebaseStorage.instance
          .ref('AtoZ/apple.jpeg')
          .getDownloadURL();

      // Save the image URL to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('imageUrl', downloadUrl);

      setState(() {
        imageUrl = downloadUrl; // Set the fetched URL to the imageUrl state
      });
    } catch (e) {
      print('Error fetching image URL: $e');
    }
  }

  Future<void> _loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedImageUrl = prefs.getString('imageUrl');

    if (savedImageUrl != null) {
      setState(() {
        imageUrl = savedImageUrl;
      });
    } else {
      loadImage(); // Fetch image from Firebase Storage if not in prefs
    }
  }

  Future<void> _checkCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? completed = prefs.getBool('puzzleCompleted');

    if (completed == true) {
      setState(() {
        isCompleted = true;
      });
    } else {
      setState(() {
        isCompleted = false;
      });
    }
  }

  Future<void> _onPuzzleComplete() async {
    // Save completion status to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('puzzleCompleted', true);

    // Navigate to the next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NextScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alphabet Puzzle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                height: 150,
                fit: BoxFit.cover,
              ),
            )
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Drag the correct letter to complete the word: "A_P_L_E"',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DragTarget<String>(
                  onAccept: (data) {
                    if (data == "A") {
                      setState(() {
                        correctLetter = data;
                        if (correctLetter == "A") {
                          _onPuzzleComplete(); // Mark puzzle as completed
                        }
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
            ),
            SizedBox(height: 40),
            isCompleted
                ? Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 50),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Reset completion status and navigate to next page
                    SharedPreferences.getInstance().then((prefs) {
                      prefs.setBool('puzzleCompleted', false);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => NextScreen()),
                      );
                    });
                  },
                  child: Text("Next"),
                ),
              ],
            )
                : Container(),
          ],
        ),
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

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Screen"),
      ),
      body: Center(
        child: Text("This is the next screen"),
      ),
    );
  }
}
