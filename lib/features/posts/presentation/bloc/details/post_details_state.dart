part of 'post_details_bloc.dart';

sealed class PostDetailsState extends Equatable {
  const PostDetailsState();

  @override
  List<Object> get props => [];
}

final class PostDetailsLoading extends PostDetailsState {}

class LoadedPostState extends PostDetailsState {
  final DetailPost post;

  const LoadedPostState({required this.post});

  @override
  List<Object> get props => [post];
}

class ErrorPostState extends PostDetailsState {
  final String message;

  const ErrorPostState({required this.message});

  @override
  List<Object> get props => [message];
}
