class BlogModel {
  final String uid;
  final DateTime dateTime;
  final String title;
  final List<String> subtitulos;
  final List<String> parrafos;
  final String image;
  final Map<String, dynamic> data;
  final String content;

  BlogModel({
    required this.uid,
    required this.dateTime,
    required this.title,
    required this.subtitulos,
    required this.parrafos,
    required this.image,
    required this.data,
    required this.content
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      uid: json['uid'],
      title: json['title'],
      subtitulos: List<String>.from(json['subtitulos']),
      parrafos: List<String>.from(json['parrafos']),
      image: json['image'],
      dateTime: json['dateTime'].toDate(),
      data: json, // Guardamos todos los datos en el campo "data"
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'subtitulos': subtitulos,
      'parrafos': parrafos,
      'image': image,
      'dateTime': dateTime,
      'content': content,
    };
  }
}
