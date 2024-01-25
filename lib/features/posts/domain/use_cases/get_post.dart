import 'package:my_clean/core/domain/usecase.dart';

import '../models/detail_post.dart';
import '../models/post.dart';
import '../repo/posts_repository.dart';

class GetPostUsecase implements UseCase<DetailPost, int> {
  final PostsRepository repo;
  GetPostUsecase(this.repo);

  @override
  Future<DetailPost> call(int params) {
    return repo.getPost(params);
  }
}
