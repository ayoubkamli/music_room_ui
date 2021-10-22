abstract class ImageEventState {}

class ImageEventInitState extends ImageEventState {}

class ImageEventLoadedState extends ImageEventState {
  String url;
  ImageEventLoadedState({
    required this.url,
  });
}

class ImageEventErrorState extends ImageEventState {}
