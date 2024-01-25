import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/details/post_details_bloc.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/details_page/details_widget.dart';
import '../widgets/posts_page/loading_widget.dart';
import '../widgets/posts_page/message_display_widget.dart';

class DetailsScreen extends StatelessWidget {
  final int id;
  const DetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<PostDetailsBloc, PostDetailsState>(
      builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostState) {
          return DetailsWidget(post: state.post);
        } else {
          return const MessageDisplayWidget(
            message: "error ocured",
          );
        }
      },
    ));
  }
}
