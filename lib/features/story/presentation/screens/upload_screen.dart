// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/themes/typography.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/story/story_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/upload/upload_bloc.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/upload/upload_event.dart';
import 'package:flutter_story_app/features/story/presentation/blocs/upload/upload_state.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends HookWidget {
  UploadScreen({Key? key}) : super(key: key);

  final _descriptionController = TextEditingController();
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final imageState = useState<File?>(null);
    final switchState = useState<bool>(false);

    return Scaffold(
      body: _buildBody(imageState, switchState),
    );
  }

  _buildBody(
    ValueNotifier<File?> imageState,
    ValueNotifier<bool> switchState,
  ) {
    return BlocBuilder<UploadBloc, UploadState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case UploadInitialState:
            return Scaffold(
              appBar: _appBar(context),
              body: _buidlContent(context, imageState, switchState),
              floatingActionButton: _fabPickImage(context, imageState),
            );

          case UploadLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case UploadErrorState:
            return AlertDialog(
              title: const Text('Error Occured'),
              content: Text(state.error!.message!),
              actions: [
                TextButton(
                  onPressed: () {
                    BlocProvider.of<UploadBloc>(context).add(
                      UploadStoryEvent(
                        imageState.value!,
                        _descriptionController.text.toString(),
                      ),
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            );

          case UploadSuccessState:
            return AlertDialog(
              title: const Text('Story Uploaded'),
              content: const Text('Click OK to continue'),
              actions: [
                TextButton(
                  onPressed: () {
                    AppRouter.pop(context);
                    BlocProvider.of<StoryBloc>(context).add(
                      const GetStoriesEvent(),
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            );

          default:
            return Scaffold(
              appBar: _appBar(context),
              body: _buidlContent(context, imageState, switchState),
              floatingActionButton: _fabPickImage(context, imageState),
            );
        }
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Upload Story'),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => AppRouter.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  Widget _fabPickImage(BuildContext context, ValueNotifier<File?> imageState) {
    return FloatingActionButton(
      onPressed: () => _showImageSourceDialog(context, imageState),
      child: const Icon(Icons.image_search_rounded),
    );
  }

  Widget _buidlContent(
    BuildContext context,
    ValueNotifier<File?> imageState,
    ValueNotifier<bool> switchState,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(imageState.value),
          _buildDescriptionField(),
          _buildLocationToggle(switchState),
          _buildSaveButton(context, imageState),
        ],
      ),
    );
  }

  Widget _buildImage(File? imageFile) {
    return Container(
      width: double.maxFinite,
      height: 240.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: imageFile != null
          ? Image.file(imageFile, fit: BoxFit.cover)
          : Icon(
              Icons.image_not_supported,
              size: 64.0,
              color: Colors.grey[600],
            ),
    );
  }

  Widget _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _descriptionController,
        minLines: 5,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Description',
          label: Text('Description'),
          alignLabelWithHint: true,
        ),
        keyboardType: TextInputType.multiline,
      ),
    );
  }

  Widget _buildLocationToggle(ValueNotifier<bool> switchState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              'Enable Location Sharing',
              style: StoryTypography.authSubtitle,
            ),
          ),
          Switch(
            value: switchState.value,
            onChanged: (newValue) {
              switchState.value = newValue;
            },
          )
        ],
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    ValueNotifier<File?> imageState,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.maxFinite,
        child: FilledButton(
          onPressed: () => _uploadStory(context, imageState),
          child: const Text(
            'Upload',
            style: StoryTypography.authSubtitle,
          ),
        ),
      ),
    );
  }

  Future<void> _showImageSourceDialog(
    BuildContext context,
    ValueNotifier<File?> imageState,
  ) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildOption(
                context,
                Icons.camera_alt,
                'Camera',
                () => _getImageFromSource(
                  context,
                  ImageSource.camera,
                  imageState,
                ),
              ),
              const SizedBox(width: 64.0),
              _buildOption(
                context,
                Icons.image,
                'Gallery',
                () => _getImageFromSource(
                  context,
                  ImageSource.gallery,
                  imageState,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 48.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }

  void _uploadStory(
    BuildContext context,
    ValueNotifier<File?> imageState,
  ) async {
    final imageFile = imageState.value;
    final description = _descriptionController.text;

    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image.'),
        ),
      );
      return;
    }

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill the description field.'),
        ),
      );
      return;
    }
    BlocProvider.of<UploadBloc>(context).add(
      UploadStoryEvent(
        imageFile,
        description,
      ),
    );
  }

  Future<void> _getImageFromSource(
    BuildContext context,
    ImageSource source,
    ValueNotifier<File?> imageState,
  ) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      imageState.value = imageFile;
    }

    Navigator.pop(context);
  }
}
