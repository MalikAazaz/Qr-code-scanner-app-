import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  final String data;

  const QRScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("QR Code"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: QrImageView(data: data, size: 200),
          ),
        ],
      ),
    );
  }
}
