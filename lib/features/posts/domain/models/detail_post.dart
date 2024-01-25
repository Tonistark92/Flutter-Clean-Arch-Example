import 'package:equatable/equatable.dart';

class DetailPost extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  const DetailPost({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory DetailPost.fromJson(Map<String, dynamic> json) {
    return DetailPost(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  @override
  List<Object?> get props => [userId, id, title, body];
}
