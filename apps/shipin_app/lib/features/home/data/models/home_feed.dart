import 'home_video.dart';

class HomeFeed {
  final HomeVideo featuredVideo;
  final List<HomeVideo> videos;

  const HomeFeed({
    required this.featuredVideo,
    required this.videos,
  });
}