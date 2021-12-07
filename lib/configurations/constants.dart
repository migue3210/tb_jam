extension StringExtension on String {
  String capitalizeIt() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
