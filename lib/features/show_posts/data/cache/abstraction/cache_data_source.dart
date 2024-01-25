import 'package:my_clean/features/show_posts/domain/models/post.dart';

abstract class PostLocalDataSource {
  Future<List<Post>> readData(String sql);
  Future<int> deleteData(String sql);
  Future<int> updateData(String sql);
  Future<int> insertData(String sql);
}
