import '../models/detail_post.dart';
import '../models/post.dart';

////
abstract class PostsRepository {
  Future<List<Post>> getAllPosts();
  Future<DetailPost> getPost(int id);

  /// add rest of functions
  ///
}
