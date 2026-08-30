class VideoInteractionState {
  final int likeCount;
  final int favoriteCount;

  final bool isLiked;
  final bool isFavorited;

  final bool isChangingLike;
  final bool isChangingFavorite;

  const VideoInteractionState({
    required this.likeCount,
    required this.favoriteCount,
    required this.isLiked,
    required this.isFavorited,
    this.isChangingLike = false,
    this.isChangingFavorite = false,
  });

  VideoInteractionState copyWith({
    int? likeCount,
    int? favoriteCount,
    bool? isLiked,
    bool? isFavorited,
    bool? isChangingLike,
    bool? isChangingFavorite,
  }) {
    return VideoInteractionState(
      likeCount:
          likeCount ?? this.likeCount,
      favoriteCount:
          favoriteCount ??
          this.favoriteCount,
      isLiked:
          isLiked ?? this.isLiked,
      isFavorited:
          isFavorited ??
          this.isFavorited,
      isChangingLike:
          isChangingLike ??
          this.isChangingLike,
      isChangingFavorite:
          isChangingFavorite ??
          this.isChangingFavorite,
    );
  }
}