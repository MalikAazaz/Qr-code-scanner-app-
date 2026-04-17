import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'generate_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _zoom = 0.5;

  final MobileScannerController controller = MobileScannerController();

  bool flashOn = false;
  bool isScanning = false;

  XFile? selectedImage;

  // ================= OPEN LINK =================
  Future<void> openLink(String data) async {
    try {
      String url = data.trim();

      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }

      final Uri uri = Uri.parse(url);

      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("OPEN ERROR: $e");
    }
  }

  // ================= QR SCAN =================
  void onDetect(BarcodeCapture capture) async {
    if (isScanning) return;

    final barcodes = capture.barcodes;

    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;

      if (code != null) {
        isScanning = true;

        controller.stop();

        await openLink(code);

        await Future.delayed(const Duration(seconds: 2));

        controller.start();

        isScanning = false;
      }
    }
  }

  // ================= GALLERY SCAN =================
  Future<void> pickFromGallery() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() => selectedImage = file);

      final result = await controller.analyzeImage(file.path);

      if (result != null && result.barcodes.isNotEmpty) {
        final data = result.barcodes.first.rawValue ?? "";
        await openLink(data);
      }
    }
  }

  // ================= FLASH =================
  void toggleFlash() {
    setState(() => flashOn = !flashOn);
    controller.toggleTorch();
  }

  // ================= CAMERA SWITCH =================
  void switchCamera() {
    controller.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6E6E6E),
      body: Stack(
        children: [
          // ===== TOP BAR =====
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: pickFromGallery,
                    child: const Icon(Icons.image, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: toggleFlash,
                    child: Icon(
                      flashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: switchCamera,
                    child: const Icon(Icons.cameraswitch, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // ===== CAMERA BOX =====
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: selectedImage == null
                            ? MobileScanner(
                                controller: controller,
                                onDetect: onDetect,
                              )
                            : Image.file(
                                File(selectedImage!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),

                    Positioned.fill(
                      child: CustomPaint(painter: CornerPainter()),
                    ),

                    Container(width: 220, height: 3, color: Colors.orange),
                  ],
                ),

                const SizedBox(height: 40),

                // ===== ZOOM =====
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      const Icon(Icons.zoom_out, color: Colors.white),
                      Expanded(
                        child: Slider(
                          value: _zoom,
                          min: 0.0,
                          max: 1.0,
                          activeColor: Colors.orange,
                          inactiveColor: Colors.white30,
                          onChanged: (value) {
                            setState(() {
                              _zoom = value;
                              controller.setZoomScale(1 + value);
                            });
                          },
                        ),
                      ),
                      const Icon(Icons.zoom_in, color: Colors.white),
                    ],
                  ),
                ),

                Text(
                  "Zoom: ${(_zoom * 100).toInt()}%",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          // ===== BOTTOM NAV =====
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GenerateQRScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.qr_code, color: Colors.white),
                  ),

                  const Icon(Icons.qr_code_scanner, color: Colors.orange),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HistoryScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.history, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= CORNER PAINTER =================
class CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    const c = 30.0;

    canvas.drawLine(Offset(0, 0), const Offset(c, 0), paint);
    canvas.drawLine(Offset(0, 0), const Offset(0, c), paint);

    canvas.drawLine(Offset(size.width, 0), Offset(size.width - c, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, c), paint);

    canvas.drawLine(Offset(0, size.height), Offset(c, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - c), paint);

    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - c, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - c),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
