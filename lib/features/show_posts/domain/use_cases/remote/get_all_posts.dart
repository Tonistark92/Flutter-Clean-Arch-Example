import '../../models/post.dart';
import '../../repo/posts_repository.dart';

class GetAllPostsUsecase {
  final PostsRepository repo;
  GetAllPostsUsecase(this.repo);

  Future<List<Post>> call() async {
    return await repo.getAllPosts();
  }
}

// class RetriveAllPostsParams {
//   final int page;
//   ///////
//   const RetriveAllPostsParams({required this.page});
// }
