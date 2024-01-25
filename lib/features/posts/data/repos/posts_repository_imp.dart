import 'package:flutter/foundation.dart';
import 'package:my_clean/core/util/network/network_info.dart';

import '../../domain/models/detail_post.dart';
import '../../domain/models/post.dart';
import '../../domain/repo/posts_repository.dart';
import '../cache/abstraction/cache_data_source.dart';
import '../network/abstraction/post_remote_data_source.dart';

class PostsRepositoryImp implements PostsRepository {
  final NetworkInfo networkInfo;
  final PostRemoteDataSource postRemoteDataSource;
  final PostLocalDataSource postLocalDataSource;

  PostsRepositoryImp(
      this.networkInfo, this.postRemoteDataSource, this.postLocalDataSource);

  @override
  Future<List<Post>> getAllPosts() async {
    List<Post> posts;
    if (await networkInfo.isConnected) {
      posts = await postRemoteDataSource.getAllPosts();
      _insertIntoDB(posts);
      // posts = await postLocalDataSource.readData("SELECT * FROM posts");

      ///save to cache
    } else {
      posts = await postLocalDataSource.readData("SELECT * FROM posts");
      if (kDebugMode) {
        print("${posts[0]}++++++++++++++============= repo ");
      }
    }

    return posts;
  }

  Future<int> _insertIntoDB(List<Post> posts) async {
    var l = 1;
    for (var element in posts) {
      var l = await postLocalDataSource.insertData(
          "INSERT INTO 'posts' ('id', 'title', 'body') VALUES (${element.id}, '${element.title}', '${element.body}')");
      if (kDebugMode) {
        print("$l" "is inserted in DB ================");
      }
    }
    return l;
  }

  @override
  Future<DetailPost> getPost(int id) {
    return postRemoteDataSource.getPost(id);
  }

  /// add todo to cashe
  ///
  ///
  ///
}
