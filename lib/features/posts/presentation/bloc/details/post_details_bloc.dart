import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/detail_post.dart';
import '../../../domain/models/post.dart';
import '../../../domain/use_cases/get_post.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final GetPostUsecase getPost;
  PostDetailsBloc({required this.getPost}) : super(PostDetailsLoading()) {
    on<PostDetailsEvent>((event, emit) async {
      if (event is GetPostEvent) {
        print("GetPostEvent trigerd ================ ");
        emit(PostDetailsLoading());
        final post = await getPost(event.id);
        emit(LoadedPostState(post: post));
      }
    });
  }
}
