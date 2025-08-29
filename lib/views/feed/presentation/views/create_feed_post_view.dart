import 'dart:developer' as developer show log;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_portal/injection_container.dart';
import 'package:job_portal/utils/storage/shared_preference.dart';
import 'package:job_portal/utils/upload_file_get_url/presentation/bloc/upload_file_bloc.dart';
import 'package:job_portal/utils/upload_file_get_url/presentation/bloc/upload_file_event.dart';
import 'package:job_portal/utils/upload_file_get_url/presentation/bloc/upload_file_state.dart';
import 'package:job_portal/views/feed/presentation/bloc/create_feed_post_bloc/create_feed_post_bloc.dart';
import 'package:job_portal/views/feed/presentation/bloc/create_feed_post_bloc/create_feed_post_event.dart';
import 'package:job_portal/views/feed/presentation/bloc/create_feed_post_bloc/create_feed_post_state.dart';
import 'package:job_portal/views/feed/presentation/bloc/feed_bloc/feed_bloc.dart';
import 'package:job_portal/views/feed/presentation/bloc/feed_bloc/feed_event.dart';
import 'package:job_portal/widgets/widgets.dart';

class CreateFeedPostView extends StatefulWidget {
  const CreateFeedPostView({super.key});

  @override
  State<CreateFeedPostView> createState() => _CreateFeedPostviewstate();
}

class _CreateFeedPostviewstate extends State<CreateFeedPostView> {
  final _captionController = TextEditingController();

  XFile? imageFile;

  Future<void> onUploadPostImages() async {
    if (imageFile == null) return;

    final fileName = imageFile!.path.split('/').last;

    final formData = FormData.fromMap({
      'feedImage':
          await MultipartFile.fromFile(imageFile!.path, filename: fileName),
    });

    context.read<UploadFileBloc>().add(LoadUploadFile(formData));
  }

  Future<void> onUploadPost(String imageUrl) async {
    final prefs = sl<PreferencesManager>();
    final user_id = prefs.getuser_id();

    final map = {
      "user_id": user_id ?? 16,
      "image": imageUrl,
      "caption": _captionController.text.trim()
    };

    context.read<CreateFeedPostBloc>().add(LoadCreateFeedPost(map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                developer.log('start to pick images.');
                context
                    .read<CreateFeedPostBloc>()
                    .add(const PickImagesCreatePost());
              },
              icon: Icon(
                Icons.photo_outlined,
                color: Colors.grey[500],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              onTap: () {
                if (imageFile != null) {
                  onUploadPostImages();
                } else if (_captionController.text.trim().isNotEmpty) {
                  onUploadPost("http://example.com/image.jpg");
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 3, 36, 102)),
                    borderRadius: BorderRadius.circular(999),
                    color: const Color.fromARGB(255, 3, 36, 102)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                  child: Text(
                    'Post',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocListener<CreateFeedPostBloc, CreateFeedPostState>(
                listener: (context, state) {
                  if (state is CreateFeedPostLoaded) {
                    final data = state.createFeedPostEntity;
                    showSnackbar(data.message, context);
                    // context.read<FeedBloc>().add(const LoadFeedPosts());
                    Navigator.pop(context);
                  } else if (state is CreateFeedPostLoading) {
                    developer.log('Create feed post is loading.');
                  } else if (state is CreateFeedPostError) {
                    developer.log('Create feed post ended up in error.');
                  }
                },
                child: SizedBox(),
              ),
              BlocListener<UploadFileBloc, UploadFileState>(
                listener: (context, state) {
                  if (state is UploadFileLoaded) {
                    final imageUrl = state.uploadFileEntity;
                    developer.log('Image url : ${imageUrl.url.first}');
                    onUploadPost(imageUrl.url.first);
                  } else if (state is UploadFileLoading) {
                    developer.log('Upload File Loading');
                  } else if (state is UploadFileError) {
                    developer.log('Upload File error');
                  }
                },
                child: SizedBox(),
              ),
              TextFormField(
                controller: _captionController,
                maxLength: 255,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Share your thoughts...',
                  hintStyle: TextStyle(fontSize: 18),
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 20,
              ),

              BlocBuilder<CreateFeedPostBloc, CreateFeedPostState>(
                  builder: (context, state) {
                if (state is PickImagesCreatePostLoaded) {
                  developer.log('Images picked;');
                  final image = state.image;
                  imageFile = image;
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(File(image.path)));
                  // return GridView.builder(
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisSpacing: 20,
                  //             crossAxisCount: 2,
                  //             mainAxisSpacing: 20),
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     itemCount: images.length,
                  //     itemBuilder: (context, index) {
                  //       final curr = images[index];
                  //       return Expanded(
                  //         child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(12),
                  //             child: Image.file(File(curr.path))),
                  //       );
                  //     });
                } else if (state is PickImagesCreatePostLoading) {
                  developer.log('Images loading;');
                  return SizedBox();
                } else if (state is PickImagesCreatePostNoPhotoSelected) {
                  developer.log('no images selected');
                  return SizedBox();
                } else if (state is PickImagesCreatePostError) {
                  developer.log('error in picking images');
                  return SizedBox();
                } else {
                  return SizedBox();
                }
              }),

              // CustomTextField(controller: _controller, hintText: 'Hint text')
              // Spacer(),
              // Padding(
              //   padding: const EdgeInsets.,
              //   child: IconButton(onPressed: () {}, icon: Icon(Icons.photo_outlined)),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
