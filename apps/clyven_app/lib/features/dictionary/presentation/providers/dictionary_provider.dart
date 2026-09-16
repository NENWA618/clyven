import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../data/repositories/dictionary_repository.dart';
import '../../data/repositories/serverpod_dictionary_repository.dart';

final dictionaryRepositoryProvider =
    Provider<DictionaryRepository>((ref) {
  final client = ref.watch(
    serverpodClientProvider,
  );

  return ServerpodDictionaryRepository(
    client: client,
  );
});