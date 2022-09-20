import 'dart:io';

import 'package:blog_with_riverpod/controller/base/base_state.dart';
import 'package:blog_with_riverpod/controller/blog_controller.dart';
import 'package:blog_with_riverpod/controller/state/blog_state.dart';
import 'package:blog_with_riverpod/model/blog_model.dart';
import 'package:blog_with_riverpod/services/image_services.dart';
import 'package:blog_with_riverpod/views/base/kTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreateUpdateBlogScreen extends ConsumerStatefulWidget {
  const CreateUpdateBlogScreen(
      {Key? key, required this.isCreate, this.blogModel})
      : super(key: key);

  final bool isCreate;
  final BlogModel? blogModel;

  @override
  ConsumerState<CreateUpdateBlogScreen> createState() =>
      _CreateUpdateBlogScreenState();
}

class _CreateUpdateBlogScreenState
    extends ConsumerState<CreateUpdateBlogScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? imagePath;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blogState = ref.watch(blogProvider);

    ref.listen(blogProvider, (previous, state) {
      if (state is BlogSuccessState) {
        Navigator.pop(context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreate ? 'Create New Blog' : 'Update Blog'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            KTextField(
              controller: titleController,
              hintText: 'Enter Title',
            ),
            KTextField(
              controller: subTitleController,
              hintText: 'Enter SubTitle',
            ),
            KTextField(
              controller: descriptionController,
              hintText: 'Enter Description',
              minLines: 4,
              maxLines: null,
            ),
            GestureDetector(
              onTap: () async {
                XFile image = await ImageServices().galleryImage();
                imagePath = ImageServices().getImagePath(image);
                imageFile = await ImageServices().getImageFile(image);
                setState(() {});
              },
              child: Container(
                margin: const EdgeInsets.all(15),
                height: size.height * 0.3,
                width: size.width,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black54),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: imageFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.photo_size_select_actual_outlined,
                              size: 50,
                              color: Colors.black54,
                            ),
                            Text(
                              'Please, Select an image',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            )
                          ],
                        )
                      : Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              // border: Border.all(width: 1,color: myblack),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageFile!),
                              )),
                        ),
                ),
              ),
            ),
            GestureDetector(
              onTap: blogState is LoadingState
                  ? null
                  : () async {
                      widget.isCreate
                          ? await ref.read(blogProvider.notifier).createBog(
                              title: titleController.text,
                              subtitle: subTitleController.text,
                              description: descriptionController.text,
                              imagePath: imagePath,
                              imageFile: imageFile)
                          : null;
                    },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                height: size.height * 0.08,
                width: size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  blogState is LoadingState
                  ? 'Please wait'
                  : widget.isCreate ? 'Create' : 'Update',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
