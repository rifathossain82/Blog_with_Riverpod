import 'package:blog_with_riverpod/controller/base/base_state.dart';
import 'package:blog_with_riverpod/controller/blog_list_controller.dart';
import 'package:blog_with_riverpod/controller/state/blog_state.dart';
import 'package:blog_with_riverpod/model/blog_model.dart';
import 'package:blog_with_riverpod/views/base/loading_widget.dart';
import 'package:blog_with_riverpod/views/base/no_data_found_widget.dart';
import 'package:blog_with_riverpod/views/base/no_internet_connection_widget.dart';
import 'package:blog_with_riverpod/views/screens/create_update_blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    refreshScreen();
    super.initState();
  }

  void refreshScreen() {
    ref.read(blogListProvider.notifier).fetchBlogsList();
  }

  @override
  Widget build(BuildContext context) {
    final blogsListState = ref.watch(blogListProvider);
    List<BlogModel> blogsList =
        blogsListState is BlogsListSuccessState ? blogsListState.blogsList : [];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog with Riverpod'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            refreshScreen();
          },
          child: blogsListState is LoadingState
              ? const LoadingWidget()
              : blogsListState is NoInternetState
                  ? const NoInternetConnectionWidget()
                  : blogsListState is BlogsListSuccessState && blogsList.isNotEmpty
                      ? ListView.builder(
                          itemCount: blogsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(blogsList[index].title!),
                            );
                          },
                        )
                      : const NoDataFoundWidget(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateUpdateBlogScreen(isCreate: true)));
          },
          child: Icon(Icons.create,),
        ),
    );
  }
}
