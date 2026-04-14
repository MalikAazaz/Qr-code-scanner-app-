import 'package:flutter/material.dart';
import 'package:qr_code_scanner/show_qr.dart';

class OpenFileScreen extends StatelessWidget {
  final String data;

  const OpenFileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Data", style: TextStyle(color: Colors.white54)),
                  const SizedBox(height: 10),
                  Text(data, style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),

                  // 👇 IMPORTANT BUTTON
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => QRScreen(data: data)),
                      );
                    },
                    child: const Text(
                      "Show QR Code",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
