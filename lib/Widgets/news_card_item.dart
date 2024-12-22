import 'package:cloud_news/model/article_model.dart';
import 'package:flutter/material.dart';

import '../Screens/locale_provider.dart';
import '../services/bookmarks_provider.dart';

const String IMAGE_URL =
    'https://mnlht.com/wp-content/uploads/2017/06/no_image_placeholder.png';

GestureDetector newsCardItem(
    {required int index, required List<ArticleModel> articles}) {
  return GestureDetector(
    onTap: () {},
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              articles[index].image ?? IMAGE_URL,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  articles[index].title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  articles[index].subTitle ?? 'No Description Available',
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(
                            0, 0), // Sets the minimum size of the button
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Reduces the touch target size
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Read more...',
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.bookmark_add)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

GestureDetector newsItemCard(
    AsyncSnapshot<List<ArticleModel>> snapshot,
    int index,
    LocalizationProvider localizationProvider,
    bool isBookmarked,
    BookmarkProvider value) {
  return GestureDetector(
    onTap: () {},
    child: Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              snapshot.data![index].image ?? IMAGE_URL,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.data![index].title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  localizationProvider.locale.languageCode == 'en'
                      ? snapshot.data![index].subTitle ??
                          'No Description Available'
                      : snapshot.data![index].subTitle ?? 'لا يوجد وصف متاح',
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(
                            0, 0), // Sets the minimum size of the button
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Reduces the touch target size
                      ),
                      onPressed: () {},
                      child: Text(
                        localizationProvider.locale.languageCode == 'en'
                            ? 'Read more...'
                            : 'اقرأ المزيد...',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (isBookmarked) {
                          value.removeBookmark(snapshot.data![index].url!);
                        } else {
                          value.addBookmark(snapshot.data![index]);
                        }
                      },
                      icon: Icon(
                        isBookmarked
                            ? Icons.bookmark_added_sharp
                            : Icons.bookmark_border,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
