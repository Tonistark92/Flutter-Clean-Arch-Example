import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_clean/api/api_consumer.dart';
import 'package:my_clean/api/dio_consumer.dart';
import 'package:my_clean/core/util/network/network_info.dart';

import '../features/posts/data/cache/abstraction/cache_data_source.dart';
import '../features/posts/data/cache/impelementation/cache_data_sourceimp.dart';
import '../features/posts/data/network/abstraction/post_remote_data_source.dart';
import '../features/posts/data/network/impelementation/post_remote_data_source_imp.dart';
import '../features/posts/data/repos/posts_repository_imp.dart';
import '../features/posts/domain/repo/posts_repository.dart';
import '../features/posts/domain/use_cases/add_to_db.dart';
import '../features/posts/domain/use_cases/get_all_from_db.dart';
import '../features/posts/domain/use_cases/get_all_posts.dart';
import '../features/posts/domain/use_cases/get_post.dart';
import '../features/posts/presentation/bloc/details/post_details_bloc.dart';
import '../features/posts/presentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
//! Features - posts

// api consumer
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
  sl.registerSingleton(InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// Usecases
  //remote
  sl.registerLazySingleton(() => GetAllPostsUsecase(sl<PostsRepository>()));
  //cache
  sl.registerFactory<AddToDbUsecase>(
      () => AddToDbUsecase(sl<PostLocalDataSource>()));
  sl.registerFactory<GetAllFromDbUsecase>(
      () => GetAllFromDbUsecase(sl<PostLocalDataSource>()));

  sl.registerLazySingleton<GetPostUsecase>(
      () => GetPostUsecase(sl<PostsRepository>()));
// Repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImp(
      sl<NetworkInfo>(),
      sl<PostRemoteDataSource>(),
      sl<PostLocalDataSource>()));
  //remote
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  // cache
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImp());

// Bloc

  sl.registerFactory(
    () => PostsBloc(getAllPosts: sl()),
  );
  sl.registerFactory(() => PostDetailsBloc(getPost: sl<GetPostUsecase>()));
}
