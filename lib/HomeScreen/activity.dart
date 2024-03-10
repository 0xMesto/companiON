class Activity {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String location;
  final double latitude;
  final double longitude;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.location,
    required this.latitude,
    required this.longitude,
  });
}