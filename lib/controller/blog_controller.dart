import 'package:blog_with_riverpod/controller/base/base_state.dart';
import 'package:blog_with_riverpod/controller/blog_list_controller.dart';
import 'package:blog_with_riverpod/controller/state/blog_state.dart';
import 'package:blog_with_riverpod/model/blog_model.dart';
import 'package:blog_with_riverpod/network/endpoints.dart';
import 'package:blog_with_riverpod/network/network_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

final blogProvider = StateNotifierProvider<BlogController, BaseState>(
    (ref) => BlogController(ref: ref));

class BlogController extends StateNotifier<BaseState> {
  final Ref? ref;
  BlogController({this.ref}) : super(const InitialState());

  Future createBog({title, subtitle, description, imagePath, imageFile}) async {
    state = const LoadingState();

    dynamic requestBody = {
      'title': title,
      'subtitle': subtitle,
      'description': description,
    };

    dynamic responseBody;

    if (await isNetworkAvailable()) {
      try {
        responseBody = await Network.handleResponse(
            await Network.multipartRequest(
                endPoint: Endpoints.createBlog,
                body: requestBody,
                methodName: 'POST',
                filePath: imagePath));
        if (responseBody != null) {
          BlogModel createdBlog = BlogModel.fromJson(responseBody['student']);

          List<BlogModel> blogList =
              ref!.read(blogListProvider.notifier).blogList;
          blogList.add(createdBlog);

          state = const BlogSuccessState();
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
