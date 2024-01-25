import 'package:flutter/foundation.dart';
import 'package:my_clean/core/util/network/network_info.dart';
import 'package:my_clean/features/show_posts/data/network/abstraction/post_api.dart';

import '../../domain/models/post.dart';
import '../../domain/repo/posts_repository.dart';
import '../cache/abstraction/cache_data_source.dart';

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
      await _insertIntoDB(posts);
      posts = await postLocalDataSource.readData("SELECT * FROM posts");

      ///save to cache
    } else {
      posts = await postLocalDataSource.readData("SELECT * FROM posts");
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

  /// add todo to cashe
  ///
  ///
  ///
}
