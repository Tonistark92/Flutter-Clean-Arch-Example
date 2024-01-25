import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/models/post.dart';
import '../../bloc/details/post_details_bloc.dart';
import '../../bloc/posts/posts_bloc.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final scrollController = ScrollController();
    // scrollController.addListener(_onScroll(context, scrollController));
    return ListView.separated(
      // controller: scrollController,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(fontSize: 16),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            BlocProvider.of<PostDetailsBloc>(context)
                .add(GetPostEvent(posts[index].id));
            context.push("/details/${posts[index].id}");
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(thickness: 1),
    );
  }
}

_onScroll(BuildContext context, ScrollController scrollController) {
  final maxScroll = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.offset;
  if (currentScroll >= (maxScroll * 0.9)) {
    context.read<PostsBloc>().add(GetAllPostsEvent());
  }
}
