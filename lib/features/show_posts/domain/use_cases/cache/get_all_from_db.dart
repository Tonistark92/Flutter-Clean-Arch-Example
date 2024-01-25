import '../../../data/cache/abstraction/cache_data_source.dart';
import '../../models/post.dart';

class GetAllFromDbUsecase {
  final PostLocalDataSource repository;

  GetAllFromDbUsecase(this.repository);

  Future<List<Post>> call(String sql) async {
    return await repository.readData(sql);
  }
}
