
class ServiceModel {
  final String id;
  final String title;
  final double totalEarned;
  final int upcomingSchedules;
  final double price;
  final String iconKey;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.totalEarned,
    required this.upcomingSchedules,
    required this.price,
    required this.iconKey,
  });
}
