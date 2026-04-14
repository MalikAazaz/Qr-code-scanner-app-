import 'package:flutter/material.dart';
import 'package:qr_code_scanner/generate_screen.dart';
import 'package:qr_code_scanner/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _zoom = 0.5;

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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.image, color: Colors.white),
                  Icon(Icons.flash_on, color: Colors.white),
                  Icon(Icons.cameraswitch, color: Colors.white),
                ],
              ),
            ),
          ),

          // ===== CENTER =====
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
                        color: Colors.white,
                      ),
                      child: Transform.scale(
                        scale: 1 + _zoom,
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Image.asset(
                            'assets/qr.png',
                            fit: BoxFit.contain,
                          ),
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

                // ===== ZOOM SLIDER =====
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
                  // GENERATE BUTTON (CLICKABLE)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GenerateQRScreen(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.qr_code, color: Colors.white),
                        SizedBox(height: 4),
                        Text(
                          "Generate",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryScreen(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.qr_code, color: Colors.white),
                        SizedBox(height: 4),
                        Text(
                          "history",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
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

// ===== CORNER PAINTER =====
class CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    const cornerLength = 30.0;

    canvas.drawLine(Offset(0, 0), const Offset(cornerLength, 0), paint);
    canvas.drawLine(Offset(0, 0), const Offset(0, cornerLength), paint);

    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, cornerLength),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height),
      Offset(cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - cornerLength),
      paint,
    );

    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
