import '../models/post.dart';

////
abstract class PostsRepository {
  Future<List<Post>> getAllPosts();

  /// add rest of functions
  ///
}
