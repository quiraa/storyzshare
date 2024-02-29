abstract class StoryEvent {
  const StoryEvent();
}

class NavigateToAddStoryEvent extends StoryEvent {
  const NavigateToAddStoryEvent();
}

class GetStoriesEvent extends StoryEvent {
  const GetStoriesEvent();
}
