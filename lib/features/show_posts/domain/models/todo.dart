import 'post.dart';

class Todo {
  int id;
  String title;
  String body;

  Todo({required this.id, required this.title, required this.body});

  // Convert a Todo object into a Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  // Create a Todo object from a Map retrieved from the database
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  factory Todo.fromPost(Post post) {
    return Todo(
      id: post.id,
      title: post.title,
      body: post.body,
    );
  }
  // Convert a list of Post objects to a list of Todo objects
  static List<Todo> fromPostList(List<Post> posts) {
    return posts.map((post) => Todo.fromPost(post)).toList();
  }
}
