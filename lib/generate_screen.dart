import 'package:flutter/material.dart';
import 'package:qr_code_scanner/history_screen.dart';
import 'package:qr_code_scanner/home_screen.dart';
import 'package:qr_code_scanner/setting_screen.dart';

// ================== MAIN SCREEN ==================

class GenerateQRScreen extends StatelessWidget {
  const GenerateQRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Column(
          children: [
            // 🔝 TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Generate QR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.menu, color: Colors.white),
                  ),
                ],
              ),
            ),

            // 📦 GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: const [
                    QRItem("Text", Icons.text_fields),
                    QRItem("Website", Icons.language),
                    QRItem("Wi-Fi", Icons.wifi),
                    QRItem("Event", Icons.event),
                    QRItem("Contact", Icons.person),
                    QRItem("Business", Icons.business),
                    QRItem("Location", Icons.location_on),
                    QRItem("WhatsApp", Icons.chat),
                    QRItem("Email", Icons.email),
                    QRItem("Twitter", Icons.alternate_email),
                    QRItem("Instagram", Icons.camera_alt),
                    QRItem("Telephone", Icons.phone),
                  ],
                ),
              ),
            ),

            // 🔘 BOTTOM NAV
            Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF151515),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.qr_code, color: Colors.amber),
                      Text(
                        "Generate",
                        style: TextStyle(color: Colors.amber, fontSize: 12),
                      ),
                    ],
                  ),

                  // CENTER BUTTON
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.qr_code_2, color: Colors.black),
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
          ],
        ),
      ),
    );
  }
}

// ================== GRID ITEM ==================

class QRItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const QRItem(this.title, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => QRFormScreen(type: title)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.amber, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.amber, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(color: Colors.amber, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// ================== FORM SCREEN ==================

class QRFormScreen extends StatelessWidget {
  final String type;

  const QRFormScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(backgroundColor: Colors.transparent, title: Text(type)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...getFields(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
              child: const Text("Generate QR Code"),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getFields() {
    switch (type) {
      case "Text":
        return [input("Enter Text")];

      case "Website":
        return [input("Enter URL")];

      case "Wi-Fi":
        return [input("Network"), input("Password")];

      case "Event":
        return [
          input("Event Name"),
          input("Start Date"),
          input("End Date"),
          input("Location"),
        ];

      case "Contact":
        return [
          input("First Name"),
          input("Last Name"),
          input("Phone"),
          input("Email"),
        ];

      case "Business":
        return [
          input("Company Name"),
          input("Industry"),
          input("Phone"),
          input("Website"),
        ];

      case "Location":
        return [input("Latitude"), input("Longitude")];

      case "WhatsApp":
        return [input("Phone Number")];

      case "Email":
        return [input("Email Address")];

      case "Twitter":
        return [input("Username")];

      case "Instagram":
        return [input("Username")];

      case "Telephone":
        return [input("Phone Number")];

      default:
        return [];
    }
  }

  Widget input(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.black45,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
