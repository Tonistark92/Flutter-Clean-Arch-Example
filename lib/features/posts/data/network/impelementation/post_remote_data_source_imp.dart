import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:my_clean/api/api_consumer.dart';
import 'package:my_clean/core/util/error/exceptions.dart';

import '../../../domain/models/detail_post.dart';
import '../../../domain/models/post.dart';
import '../abstraction/post_remote_data_source.dart';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final ApiConsumer client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<Post>> getAllPosts() async {
    final response = await client.get("posts/");
    final dynamic decodedJson = response;
    final List<Post> postModels = decodedJson
        .map<Post>((jsonPostModel) => Post.fromJson(jsonPostModel))
        .toList();
    if (kDebugMode) {
      print("${postModels[0]} ++++++++++++++++++ data source");
    }
    return postModels;
  }

  @override
  Future<Unit> addPost(Post postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response = await client.post("posts/", body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete("/posts/${postId.toString()}");

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(Post postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };

    final response = await client.patch(
      "/posts/$postId",
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailPost> getPost(int id) async {
    final response = await client.get("posts/$id");

    return DetailPost.fromJson(response);
  }
}
