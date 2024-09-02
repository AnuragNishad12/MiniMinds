import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AZScreen extends StatefulWidget {
  const AZScreen({super.key});

  @override
  State<AZScreen> createState() => _AZScreenState();
}

class _AZScreenState extends State<AZScreen> {
  final List<String> alphabets = List.generate(26, (index) => String.fromCharCode(index + 65)); // A to Z
  final Map<String, String> soundUrls = {};
  final AudioPlayer audioPlayer = AudioPlayer();
  String? selectedAlphabet;

  @override
  void initState() {
    super.initState();
    preloadSounds();
  }

  Future<void> preloadSounds() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    for (String alphabet in alphabets) {
      try {
        final Reference ref = storage.ref().child('AtoZalphabets/${alphabet}_mm.mp3');
        final String url = await ref.getDownloadURL();
        soundUrls[alphabet] = url;
      } catch (e) {
        print('Error preloading sound for $alphabet: $e');
      }
    }
  }

  Future<void> playSound(String alphabet, {double speed = 1.0}) async {
    try {
      final url = soundUrls[alphabet];
      if (url != null) {
        await audioPlayer.setPlaybackRate(speed);
        await audioPlayer.play(UrlSource(url));
      } else {
        print('No URL found for $alphabet');
      }
    } catch (e) {
      print('Error playing sound for $alphabet: $e');
    }
  }

  void _handleTap(String alphabet) {
    setState(() {
      selectedAlphabet = alphabet;
    });
    playSound(alphabet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd95e22),
        title: Text("A to Z Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
          ),
          itemCount: alphabets.length,
          itemBuilder: (context, index) {
            final alphabet = alphabets[index];
            final isSelected = alphabet == selectedAlphabet;
            return GestureDetector(
              onTap: () => _handleTap(alphabet),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? Colors.red.withOpacity(0.8)
                          : Colors.black.withOpacity(0.5),
                      blurRadius: isSelected ? 10.0 : 6.0,
                      spreadRadius: isSelected ? 4.0 : 2.0,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    alphabet,
                    style: GoogleFonts.anton(
                      textStyle: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}