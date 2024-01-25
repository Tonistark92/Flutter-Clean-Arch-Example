import 'package:flutter/widgets.dart';

import '../../../domain/models/detail_post.dart';
import '../../../domain/models/post.dart';

// ignore: must_be_immutable
class DetailsWidget extends StatelessWidget {
  DetailPost post;
  DetailsWidget({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(post.title),
    );
  }
}
