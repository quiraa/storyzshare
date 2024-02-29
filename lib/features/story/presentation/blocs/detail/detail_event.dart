abstract class DetailEvent {
  final String? storyId;

  const DetailEvent({this.storyId});
}

class GetDetailStoryEvent extends DetailEvent {
  const GetDetailStoryEvent(String storyId) : super(storyId: storyId);
}
