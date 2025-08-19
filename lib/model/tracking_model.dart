class TrackingModel {
  final String uid;
  final String status;
  final DateTime dateTime;

  const TrackingModel({
    required this.uid,
    required this.dateTime,
    required this.status,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) =>
      TrackingModel(
        uid: json['uid'],
        status: json['status'],
        dateTime: json['dateTime'].toDate(),
      );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'status': status,
    'dateTime': dateTime,
  };
}
