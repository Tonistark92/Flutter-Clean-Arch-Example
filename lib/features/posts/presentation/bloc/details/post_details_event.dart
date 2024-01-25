part of 'post_details_bloc.dart';

abstract class PostDetailsEvent extends Equatable {
  const PostDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPostEvent extends PostDetailsEvent {
  final int id;

  const GetPostEvent(this.id);

  @override
  List<Object> get props => [id];
}
