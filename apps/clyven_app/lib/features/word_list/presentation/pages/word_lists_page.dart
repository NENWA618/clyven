import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/word_list_provider.dart';
import 'word_list_page.dart';

class WordListsPage extends ConsumerWidget {
  const WordListsPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final listsAsync = ref.watch(
      wordListsProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('词表'),
      ),
      body: listsAsync.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                '读取词表失败：$error',
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        data: (lists) {
          if (lists.isEmpty) {
            return const Center(
              child: Text('暂时没有词表'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: lists.length,
            separatorBuilder: (
              context,
              index,
            ) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (
              context,
              index,
            ) {
              final wordList = lists[index];

              return Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.menu_book_rounded,
                  ),
                  title: Text(
                    wordList.name,
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    wordList.description ??
                        wordList.languageCode,
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                  ),
                  onTap: () {
                    final listId = wordList.id;

                    if (listId == null) {
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WordListPage(
                            listId: listId,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}