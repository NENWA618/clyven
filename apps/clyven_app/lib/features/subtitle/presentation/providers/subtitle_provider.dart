import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/repositories/subtitle_repository.dart';
import '../../data/repositories/serverpod_subtitle_repository.dart';

// Alt başlıkta "Depo için besleme soketi" yazıyor.
// Altyazı arşivine ihtiyaç duyan herkes buradan ulaşabilir.
final subtitleRepositoryProvider = Provider<SubtitleRepository>((ref) {
  //什么，需要定义监听，监听那个network的那边
  //定义监听，ref是class，watch是method，method传参数，传的是network，把那个穿进去这个变量，那个变量再传进去repo
  final client = ref.watch(serverpodClientProvider);
  //字幕入口返回repo？在这个插座里返回啊，原来如此，就是作为一个入口，这个provider接的是repo所以在这里定义
  //原来每次看到的repo的client参数都是在这里传入，那个network的有provider传入repo，一目了然了
  return ServerpodSubtitleRepository(client: client);
});

// "Altyazı verisi besleme portu".
// Videoyu ve dili girin, ilgili altyazılar otomatik olarak sağlanacaktır.
// 字幕数据 Provider。
// 输入：videoId + languageCode
// 输出：这个视频对应语言的字幕列表。
final subtitleProvider =
    // 调用这个 Provider 时需要传入的参数：
    // 视频 ID + 语言代码。
    FutureProvider.family<
      List<serverpod.SubtitleCueDetail>,
      ({int videoId, String languageCode})
    >((ref, query) {
      // Provider 最后异步返回的数据类型：字幕详情列表。
      // 从 subtitleRepositoryProvider 取得字幕 Repository。
      // 真正负责请求 Serverpod / 后端的是 Repository。
      final repository = ref.watch(subtitleRepositoryProvider);

      // 把调用 subtitleProvider 时传进来的参数
      // 转交给 Repository。
      return repository.loadSubtitles(
        videoId: query.videoId,
        languageCode: query.languageCode,
      );
    });

// “字幕轨道供应口”。
// 输入视频 ID，就供应这个视频有哪些字幕可选。
final subtitleTracksProvider =
    FutureProvider.family<List<serverpod.SubtitleTrack>, int>((ref, videoId) {
      final repository = ref.watch(subtitleRepositoryProvider);

      return repository.loadAvailableTracks(videoId: videoId);
    });
