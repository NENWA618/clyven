import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../known_entry/presentation/providers/known_entry_provider.dart';
import '../providers/word_list_provider.dart';

class WordListPage extends ConsumerWidget {
  final int listId;
  final String explanationLanguageCode;

  const WordListPage({
    super.key,
    required this.listId,
    this.explanationLanguageCode = 'zh',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final query = (
      listId: listId,
      explanationLanguageCode: explanationLanguageCode,
    );

    final detailAsync = ref.watch(wordListDetailProvider(query));

    final knownAsync = ref.watch(knownEntriesForListProvider(query));

    final knownEntryIds = knownAsync.value ?? <int>{};

    return Scaffold(
      appBar: AppBar(title: Text(l10n.wordLists)),
      body: detailAsync.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                l10n.wordListLoadFailed(error.toString()),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        data: (detail) {
          if (detail == null) {
            return Center(child: Text(l10n.wordListNotFound));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  detail.wordList.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              if (detail.wordList.description != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Text(detail.wordList.description!),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Text(l10n.wordListEntryCount(detail.items.length)),
              ),

              const Divider(height: 1),

              Expanded(
                child: ListView.separated(
                  itemCount: detail.items.length,
                  separatorBuilder: (context, index) {
                    return const Divider(height: 1, indent: 72);
                  },
                  itemBuilder: (context, index) {
                    final item = detail.items[index];

                    final entryId = item.entry.id;

                    final meaning = item.definitions.isEmpty
                        ? l10n.noDefinition
                        : item.definitions.first.gloss;

                    final isKnown =
                        entryId != null && knownEntryIds.contains(entryId);

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),

                      leading: IconButton(
                        tooltip: isKnown ? l10n.unmarkKnown : l10n.markAsKnown,
                        onPressed: entryId == null
                            ? null
                            : () async {
                                final repository = ref.read(
                                  knownEntryRepositoryProvider,
                                );

                                await repository.setKnown(
                                  entryId: entryId,
                                  known: !isKnown,
                                );

                                // 刷新词表自己的 ✓ / ○
                                ref.invalidate(
                                  knownEntriesForListProvider(query),
                                );

                                ref.invalidate(knowledgeStateProvider);

                                ref.invalidate(knowledgeStatesProvider);
                              },
                        icon: Icon(
                          isKnown
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                        ),
                      ),

                      title: Text(
                        item.entry.text,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          decoration: isKnown ? TextDecoration.none : null,
                        ),
                      ),

                      subtitle: Text(
                        meaning,
                        style: const TextStyle(fontSize: 15),
                      ),

                      trailing: Text(
                        item.entry.entryType == 'phrase'
                            ? l10n.entryTypePhrase
                            : l10n.entryTypeWord,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
