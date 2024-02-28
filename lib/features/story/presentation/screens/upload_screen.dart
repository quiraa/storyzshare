import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_story_app/config/routes/route_config.dart';
import 'package:flutter_story_app/config/themes/typography.dart';

class UploadScreen extends HookWidget {
  UploadScreen({Key? key}) : super(key: key);

  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buidlContent(),
      floatingActionButton: _fabPickImage(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Upload Story'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => AppRouter.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  Widget _fabPickImage(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.image_search_rounded),
    );
  }

  Widget _buidlContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(),
          _buildDescriptionField(),
          _buildLocationToggle(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      color: Colors.grey[200],
      height: 240.0,
      width: double.maxFinite,
      child: const Icon(
        Icons.image_not_supported_rounded,
        size: 48.0,
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

  Widget _buildLocationToggle() {
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
            value: false,
            onChanged: (bool? newValue) {},
          )
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.maxFinite,
        child: FilledButton(
          onPressed: () {},
          child: const Text(
            'Upload',
            style: StoryTypography.authSubtitle,
          ),
        ),
      ),
    );
  }
}
