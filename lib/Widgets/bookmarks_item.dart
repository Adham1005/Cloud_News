import 'package:cloud_news/Widgets/news_card_item.dart';
import 'package:cloud_news/model/article_model.dart';
import 'package:cloud_news/services/bookmarks_provider.dart';
import 'package:flutter/material.dart';

Column bookmarksItem(ArticleModel article, BookmarkProvider value) {
  return Column(
    children: [
      ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            article.image ?? IMAGE_URL,
            fit: BoxFit.cover,
            width: 100,
          ),
        ),
        title: Expanded(
          child: Text(
            article.title,
            style: const TextStyle(
              fontSize: 16, // Increase font size to take up more space
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        ),
        subtitle: Expanded(
          child: Text(
            article.subTitle ?? 'No description available',
            style: const TextStyle(
              fontSize: 13, // Increase font size
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 2,
          ),
        ),
        trailing: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            value.removeBookmark(article.url!);
          },
          icon: const Icon(
            Icons.delete,
            size: 28,
            color: Colors.red,
          ),
          constraints: const BoxConstraints(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Divider(
          color: Colors.grey[300],
        ),
      ),
    ],
  );
}
