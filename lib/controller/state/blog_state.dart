import 'package:blog_with_riverpod/controller/base/base_state.dart';
import 'package:blog_with_riverpod/model/blog_model.dart';


class BlogsListSuccessState extends SuccessState{
  final List<BlogModel> blogsList;
  const BlogsListSuccessState(this.blogsList);
}

class BlogSuccessState extends SuccessState {
  const BlogSuccessState();
}