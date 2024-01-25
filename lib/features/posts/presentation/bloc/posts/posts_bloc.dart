import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/post.dart';
import '../../../domain/use_cases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPosts;

  PostsBloc({
    required this.getAllPosts,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllPosts();
        emit(LoadedPostsState(posts: posts));

        if (kDebugMode) {
          print("${posts[0]} is fitched bloc ssssss ================");
        }
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllPosts();
        emit(LoadedPostsState(posts: posts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(List<Post> posts) {
    // if nothing in db show that it is empty
    return LoadedPostsState(
      posts: posts,
    );
  }

  // String _mapFailureToMessage(Failure failure) {
  //   switch (failure.runtimeType) {
  //     case ServerFailure:
  //       return "SERVER_FAILURE_MESSAGE";
  //     case EmptyCacheFailure:
  //       return "EMPTY_CACHE_FAILURE_MESSAGE";
  //     case OfflineFailure:
  //       return "OFFLINE_FAILURE_MESSAGE";
  //     default:
  //       return "Unexpected Error , Please try again later .";
  //   }
  // }
}
