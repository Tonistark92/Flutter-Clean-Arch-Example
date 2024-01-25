import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'di/injection_container.dart' as di;
import 'features/posts/presentation/bloc/details/post_details_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/screens/details_screen.dart';
import 'features/posts/presentation/screens/posts_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PostsBloc>(
            create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
          ),
          BlocProvider<PostDetailsBloc>(
            create: (_) => di.sl<PostDetailsBloc>(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
        ));
  }

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'Posts',
        path: '/',
        builder: (context, state) => const PostsPage(),
      ),
      GoRoute(
          name: "details",
          path: "/details/:id",
          builder: ((context, state) => DetailsScreen(
                id: int.parse(state.pathParameters['id']!),
              ))),
      GoRoute(
          name: "add",
          path: "/add",
          builder: ((context, state) => const PostsPage()))
    ],
  );
}
