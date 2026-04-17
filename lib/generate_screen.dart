import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'home_screen.dart';
import 'history_screen.dart';
import 'setting_screen.dart';
import 'qr_storage.dart';

// ================== MAIN SCREEN ==================

class GenerateQRScreen extends StatefulWidget {
  const GenerateQRScreen({super.key});

  @override
  State<GenerateQRScreen> createState() => _GenerateQRScreenState();
}

class _GenerateQRScreenState extends State<GenerateQRScreen> {
  String qrData = "";
  String selectedType = "Text";

  // ================= CONTROLLERS =================
  final textController = TextEditingController();
  final websiteController = TextEditingController();

  final wifiNameController = TextEditingController();
  final wifiPassController = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final usernameController = TextEditingController();

  // ================= QR GENERATOR =================
  void generateQR() {
    String result = "";

    switch (selectedType) {
      case "Text":
        result = textController.text;
        break;

      case "Website":
        result = websiteController.text;
        break;

      case "Wi-Fi":
        result =
            "WIFI:T:WPA;S:${wifiNameController.text};P:${wifiPassController.text};;";
        break;

      case "WhatsApp":
        result = "https://wa.me/${phoneController.text}";
        break;

      case "Email":
        result = "mailto:${emailController.text}";
        break;

      case "Twitter":
        result = "https://twitter.com/${usernameController.text}";
        break;

      case "Instagram":
        result = "https://instagram.com/${usernameController.text}";
        break;

      case "Telephone":
        result = "tel:${phoneController.text}";
        break;

      case "Contact":
        result =
            "BEGIN:VCARD\nVERSION:3.0\nFN:${firstNameController.text} ${lastNameController.text}\nTEL:${phoneController.text}\nEMAIL:${emailController.text}\nEND:VCARD";
        break;
    }

    setState(() {
      qrData = result;
    });
  }

  // ================= INPUT WIDGET =================
  Widget input(TextEditingController c, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
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

  // ================= FORM =================
  Widget buildForm() {
    switch (selectedType) {
      case "Text":
        return input(textController, "Enter Text");

      case "Website":
        return input(websiteController, "Enter URL");

      case "Wi-Fi":
        return Column(
          children: [
            input(wifiNameController, "WiFi Name"),
            input(wifiPassController, "Password"),
          ],
        );

      case "WhatsApp":
      case "Telephone":
        return input(phoneController, "Phone Number");

      case "Email":
        return input(emailController, "Email Address");

      case "Twitter":
      case "Instagram":
        return input(usernameController, "Username");

      case "Contact":
        return Column(
          children: [
            input(firstNameController, "First Name"),
            input(lastNameController, "Last Name"),
            input(phoneController, "Phone"),
            input(emailController, "Email"),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Column(
          children: [
            // 🔝 TOP BAR (SAME UI)
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

            // 📌 FORM
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildForm(),
            ),

            // 🔘 GENERATE BUTTON
            ElevatedButton(
              onPressed: generateQR,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
              child: const Text("Generate QR Code"),
            ),

            const SizedBox(height: 10),

            // 📦 QR RESULT
            if (qrData.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: QrImageView(data: qrData, size: 180),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  QRStorage.addGenerated(qrData);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved to History')),
                  );
                },
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
            ],

            // 📦 GRID (SAME UI)
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(12),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  gridItem("Text"),
                  gridItem("Website"),
                  gridItem("Wi-Fi"),
                  gridItem("Contact"),
                  gridItem("WhatsApp"),
                  gridItem("Email"),
                  gridItem("Twitter"),
                  gridItem("Instagram"),
                  gridItem("Telephone"),
                ],
              ),
            ),

            // 🔘 BOTTOM NAV (SAME UI)
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
                  const Icon(Icons.qr_code, color: Colors.amber),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
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
                          builder: (_) => const HistoryScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.history, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= GRID ITEM =================
  Widget gridItem(String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
          qrData = "";
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.amber, width: 2),
        ),
        child: Center(
          child: Text(
            type,
            style: const TextStyle(color: Colors.amber, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
