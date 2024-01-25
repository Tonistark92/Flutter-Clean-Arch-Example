import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_clean/api/api_consumer.dart';
import 'package:my_clean/api/dio_consumer.dart';
import 'package:my_clean/core/util/network/network_info.dart';
import 'package:my_clean/features/show_posts/domain/repo/posts_repository.dart';

import '../features/show_posts/data/cache/abstraction/cache_data_source.dart';
import '../features/show_posts/data/cache/impelementation/cache_data_sourceimp.dart';
import '../features/show_posts/data/network/abstraction/post_api.dart';
import '../features/show_posts/data/network/impelementation/post_remote_data_source_imp.dart';
import '../features/show_posts/data/repos/posts_repository_imp.dart';
import '../features/show_posts/domain/use_cases/cache/add_to_db.dart';
import '../features/show_posts/domain/use_cases/cache/get_all_from_db.dart';
import '../features/show_posts/domain/use_cases/remote/get_all_posts.dart';
import '../features/show_posts/presentation/bloc/posts/posts_bloc.dart';

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
}
