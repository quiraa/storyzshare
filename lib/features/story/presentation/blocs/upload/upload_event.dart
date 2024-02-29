import 'dart:io';

abstract class UploadEvent {
  final File? photo;
  final String? description;

  const UploadEvent({this.photo, this.description});
}

class UploadInitialEvent extends UploadEvent {
  const UploadInitialEvent();
}

class UploadStoryEvent extends UploadEvent {
  const UploadStoryEvent(
    File photo,
    String description,
  ) : super(photo: photo, description: description);
}
