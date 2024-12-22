import 'package:cloud_news/Screens/webview_screen.dart';
import 'package:cloud_news/Widgets/bookmarks_item.dart';
import 'package:cloud_news/services/bookmarks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/navigator_push.dart';
import 'locale_provider.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizationProvider.locale.languageCode == 'en'
              ? 'Bookmarks'
              : 'العلامات المرجعية',
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<BookmarkProvider>(
        builder: (context, BookmarkProvider value, child) {
          if (value.bookmarks.isEmpty) {
            return Center(
                child: Text(localizationProvider.locale.languageCode == 'en'
                    ? 'No bookmarks saved yet.'
                    : 'لم يتم حفظ أي إشارات مرجعية بعد.'));
          }
          return ListView.builder(
            itemCount: value.bookmarks.length,
            itemBuilder: (context, index) {
              final article = value.bookmarks[index];
              return InkWell(
                child: bookmarksItem(article, value),
                onTap: () {
                  navigatorTo(
                    context: context,
                    page: WebViewPage(
                        url: value.bookmarks[index].url ??
                            'https://www.youtube.com/'),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
