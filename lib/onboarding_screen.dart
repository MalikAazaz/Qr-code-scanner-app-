import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int currentIndex = 0;

  List<Map<String, String>> pages = [
    {"title": "Scan QR Code", "desc": "Scan any QR code easily"},
    {"title": "Generate QR", "desc": "Create your own QR codes"},
    {"title": "Save History", "desc": "Access previous scans anytime"},
  ];

  void nextPage() async {
    if (currentIndex == pages.length - 1) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("seenOnboarding", true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (i) => setState(() => currentIndex = i),
              itemCount: pages.length,
              itemBuilder: (_, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.qr_code, size: 100, color: Colors.amber),
                    const SizedBox(height: 20),
                    Text(
                      pages[i]["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      pages[i]["desc"]!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // BUTTON
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(currentIndex == pages.length - 1 ? "Start" : "Next"),
            ),
          ),
        ],
      ),
    );
  }
}
