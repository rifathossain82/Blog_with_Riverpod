import 'package:blog_with_riverpod/controller/base/base_state.dart';
import 'package:blog_with_riverpod/controller/state/blog_state.dart';
import 'package:blog_with_riverpod/model/blog_model.dart';
import 'package:blog_with_riverpod/network/endpoints.dart';
import 'package:blog_with_riverpod/network/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

final blogListProvider = StateNotifierProvider<BlogListController, BaseState>(
    (ref) => BlogListController(ref: ref));

class BlogListController extends StateNotifier<BaseState> {
  final Ref? ref;
  BlogListController({this.ref}) : super(const InitialState());

  List<BlogModel> blogList = [];

  Future fetchBlogsList() async {
    state = const LoadingState();
    dynamic responseBody;

    if (await isNetworkAvailable()) {
      try {
        responseBody = await Network.handleResponse(
            await Network.getRequest(endPoint: Endpoints.getAllBlogs));

        if (responseBody != null) {
          blogList = (responseBody['data'] as List<dynamic>)
              .map((e) => BlogModel.fromJson(e))
              .toList();
          state = BlogsListSuccessState(blogList);
        } else {
          state = const ErrorState();
        }
      } catch (e, stackTrace) {
        print(stackTrace);
        state = const ErrorState();
      }
    } else {
      state = const NoInternetState();
    }
  }
}
