import 'package:dartz/dartz.dart';

import '../../../domain/models/detail_post.dart';
import '../../../domain/models/post.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getAllPosts();
  Future<DetailPost> getPost(int id);
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(Post postModel);
  Future<Unit> addPost(Post postModel);
}
