class CurrentTime {
  static String getCurrentTime() {
    DateTime now = DateTime.now();
    return '${now.hour}h ${now.minute}min';
  }
}
