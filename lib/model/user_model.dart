class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final DateTime lastActive;
  final bool isOnline;
  final String role;
  final String speciality;
  final String about;
  final String fcmToken;

  const UserModel({
    required this.name,
    required this.image,
    required this.lastActive,
    required this.uid,
    required this.email,
    this.isOnline = false,
    required this.role,
    this.speciality = "",
    this.about = "",
    this.fcmToken = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        uid: json['uid'],
        name: json['name'],
        image: json['image'],
        email: json['email'],
        role: json['role'],
        speciality: json['speciality'] ?? '',
        about: json['about'] ?? '',
        fcmToken: json['fcmToken'] ?? '',
        isOnline: json['isOnline'] ?? false,
        lastActive: json['lastActive'].toDate(),
      );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'image': image,
    'email': email,
    'role': role,
    'isOnline': isOnline,
    'lastActive': lastActive,
    'speciality': speciality,
    'about': about,
    'fcmToken': fcmToken,
  };
}
