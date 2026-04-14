import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool vibrate = true;
  bool beep = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔙 Back Button
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.amber),
                ),
              ),

              const SizedBox(height: 20),

              // 🔸 SETTINGS TITLE
              const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // 🔘 Vibrate
              _tile(
                icon: Icons.vibration,
                title: "Vibrate",
                subtitle: "Vibration when scan is done.",
                trailing: Switch(
                  value: vibrate,
                  activeColor: Colors.amber,
                  onChanged: (val) {
                    setState(() => vibrate = val);
                  },
                ),
              ),

              const SizedBox(height: 12),

              // 🔘 Beep
              _tile(
                icon: Icons.notifications,
                title: "Beep",
                subtitle: "Beep when scan is done.",
                trailing: Switch(
                  value: beep,
                  activeColor: Colors.amber,
                  onChanged: (val) {
                    setState(() => beep = val);
                  },
                ),
              ),

              const SizedBox(height: 24),

              // 🔸 SUPPORT TITLE
              const Text(
                "Support",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              _tile(
                icon: Icons.star,
                title: "Rate Us",
                subtitle: "Your best reward to us.",
              ),

              const SizedBox(height: 12),

              _tile(
                icon: Icons.lock,
                title: "Privacy Policy",
                subtitle: "Follow our policies that benefits you.",
              ),

              const SizedBox(height: 12),

              _tile(
                icon: Icons.share,
                title: "Share",
                subtitle: "Share app with others.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 Reusable Tile
  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(14),
        border: const Border(bottom: BorderSide(color: Colors.amber, width: 2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 12),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),

          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
