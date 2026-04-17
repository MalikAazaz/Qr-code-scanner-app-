class QRStorage {
  static List<Map<String, String>> history = [];

  static void addGenerated(String data) {
    history.insert(0, {
      "data": data,
      "type": "generated",
      "time": DateTime.now().toString(),
    });
  }

  static void addScanned(String data) {
    history.insert(0, {
      "data": data,
      "type": "scanned",
      "time": DateTime.now().toString(),
    });
  }
}
