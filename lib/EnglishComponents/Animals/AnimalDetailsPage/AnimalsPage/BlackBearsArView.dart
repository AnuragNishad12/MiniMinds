import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:permission_handler/permission_handler.dart';

class BlackBearsArView extends StatefulWidget {
  const BlackBearsArView({super.key});

  @override
  State<BlackBearsArView> createState() => _BlackBearsArViewState();
}

class _BlackBearsArViewState extends State<BlackBearsArView> {
  ArCoreController? arCoreController;

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted) {
      print('Camera permission granted');
    } else {
      print('Camera permission denied');
      // Handle the case when permission is denied
    }
  }

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    displayBlackBearImage(arCoreController!);
  }

  // Function to display a flat image without a shape
  Future<void> displayBlackBearImage(ArCoreController coreController) async {
    final ByteData textureBytes = await rootBundle.load("assets/image/blackbear1.png");

    // Create a node with only the image texture
    final node = ArCoreNode(
      image: ArCoreImage(
        bytes: textureBytes.buffer.asUint8List(),
        width: 512,  // Specify the image dimensions
        height: 512,
      ),
      position: vector.Vector3(0, 0, -1.5), // Adjust position as needed
    );

    coreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR System'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: onArCoreViewCreated,
        enableUpdateListener: true, // Enable to listen for changes in AR environment
      ),
    );
  }
}
