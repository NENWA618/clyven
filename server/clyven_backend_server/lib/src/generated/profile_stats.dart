/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class ProfileStats
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ProfileStats._({
    required this.followerCount,
    required this.followingCount,
    required this.videoCount,
    required this.favoriteCount,
    required this.totalViewCount,
    required this.bio,
  });

  factory ProfileStats({
    required int followerCount,
    required int followingCount,
    required int videoCount,
    required int favoriteCount,
    required int totalViewCount,
    required String bio,
  }) = _ProfileStatsImpl;

  factory ProfileStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfileStats(
      followerCount: jsonSerialization['followerCount'] as int,
      followingCount: jsonSerialization['followingCount'] as int,
      videoCount: jsonSerialization['videoCount'] as int,
      favoriteCount: jsonSerialization['favoriteCount'] as int,
      totalViewCount: jsonSerialization['totalViewCount'] as int,
      bio: jsonSerialization['bio'] as String,
    );
  }

  int followerCount;

  int followingCount;

  int videoCount;

  int favoriteCount;

  int totalViewCount;

  String bio;

  /// Returns a shallow copy of this [ProfileStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProfileStats copyWith({
    int? followerCount,
    int? followingCount,
    int? videoCount,
    int? favoriteCount,
    int? totalViewCount,
    String? bio,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfileStats',
      'followerCount': followerCount,
      'followingCount': followingCount,
      'videoCount': videoCount,
      'favoriteCount': favoriteCount,
      'totalViewCount': totalViewCount,
      'bio': bio,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfileStats',
      'followerCount': followerCount,
      'followingCount': followingCount,
      'videoCount': videoCount,
      'favoriteCount': favoriteCount,
      'totalViewCount': totalViewCount,
      'bio': bio,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ProfileStatsImpl extends ProfileStats {
  _ProfileStatsImpl({
    required int followerCount,
    required int followingCount,
    required int videoCount,
    required int favoriteCount,
    required int totalViewCount,
    required String bio,
  }) : super._(
         followerCount: followerCount,
         followingCount: followingCount,
         videoCount: videoCount,
         favoriteCount: favoriteCount,
         totalViewCount: totalViewCount,
         bio: bio,
       );

  /// Returns a shallow copy of this [ProfileStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProfileStats copyWith({
    int? followerCount,
    int? followingCount,
    int? videoCount,
    int? favoriteCount,
    int? totalViewCount,
    String? bio,
  }) {
    return ProfileStats(
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
      videoCount: videoCount ?? this.videoCount,
      favoriteCount: favoriteCount ?? this.favoriteCount,
      totalViewCount: totalViewCount ?? this.totalViewCount,
      bio: bio ?? this.bio,
    );
  }
}
