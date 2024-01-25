import '../../../data/cache/abstraction/cache_data_source.dart';

class AddToDbUsecase {
  final PostLocalDataSource repository;

  AddToDbUsecase(this.repository);

  Future<int> call(String sql) async {
    return await repository.insertData(sql);
  }
}
