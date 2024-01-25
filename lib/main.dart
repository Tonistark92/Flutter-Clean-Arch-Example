import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di/injection_container.dart' as di;
import 'features/show_posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/show_posts/presentation/screens/posts_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Posts App',
            home: PostsPage()));
  }
}
