class ScheduleEntity {
  final String id;
  final String status;
  final String imageUrl;
  final String startTime;
  final String endTime;
  final String serviceName;
  final String personName;
  final String address;
  final bool isSigned;
  final bool isPaymentCompleted;
  final bool isUploaded;
  final bool isPublished;

  const ScheduleEntity({
    required this.id,
    required this.status,
    required this.imageUrl,
    required this.startTime,
    required this.endTime,
    required this.serviceName,
    required this.personName,
    required this.address,
    required this.isSigned,
    required this.isPaymentCompleted,
    required this.isUploaded,
    required this.isPublished,
  });
}
