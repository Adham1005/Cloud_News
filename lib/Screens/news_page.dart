import 'package:cloud_news/Screens/search_page.dart';
import 'package:cloud_news/Screens/settings_page.dart';
import 'package:cloud_news/Screens/webview_screen.dart';
import 'package:cloud_news/Widgets/navigator_push.dart';
import 'package:cloud_news/model/article_model.dart';
import 'package:cloud_news/services/bookmarks_provider.dart';
import 'package:cloud_news/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/news_card_item.dart';
import 'locale_provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var future;

  @override
  void initState() {
    super.initState();
    future = NewsServices().getNews();
  }

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizationProvider.locale.languageCode == 'en'
              ? 'Today News'
              : 'اخبار اليوم',
          style: const TextStyle(fontSize: 26),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 26,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              navigatorTo(context: context, page: const SearchPage());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 26,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              navigatorTo(context: context, page: const SettingsPage());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Consumer<BookmarkProvider>(
                      builder: (BuildContext context, BookmarkProvider value,
                          Widget? child) {
                        final isBookmarked = value.bookmarks.any(
                            (item) => item.url == snapshot.data![index].url);
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
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    snapshot.data![index].image ?? IMAGE_URL,
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        localizationProvider
                                                    .locale.languageCode ==
                                                'en'
                                            ? snapshot.data![index].subTitle ??
                                                'No Description Available'
                                            : snapshot.data![index].subTitle ??
                                                'لا يوجد وصف متاح',
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 15,
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
                                              minimumSize: const Size(0,
                                                  0), // Sets the minimum size of the button
                                              tapTargetSize: MaterialTapTargetSize
                                                  .shrinkWrap, // Reduces the touch target size
                                            ),
                                            onPressed: () {
                                              navigatorTo(
                                                context: context,
                                                page: WebViewPage(
                                                    url: snapshot
                                                            .data![index].url ??
                                                        'https://www.youtube.com/'),
                                              );
                                            },
                                            child: Text(
                                              localizationProvider.locale
                                                          .languageCode ==
                                                      'en'
                                                  ? 'Read more...'
                                                  : 'اقرأ المزيد...',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () {
                                              if (isBookmarked) {
                                                value.removeBookmark(
                                                    snapshot.data![index].url!);
                                              } else {
                                                value.addBookmark(
                                                    snapshot.data![index]);
                                              }
                                            },
                                            icon: Icon(
                                              size: 26,
                                              color: isBookmarked
                                                  ? Colors.blueAccent
                                                  : Colors.grey,
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
                      },
                    );
                  },
                ),
              );
            }
          }

          return Center(
            child: Text(
              localizationProvider.locale.languageCode == 'en'
                  ? 'Something went wrong. Please try again later.'
                  : 'حدث خطأ ما. يرجى المحاولة مرة أخرى لاحقًا.',
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}

// class NewsPage extends StatefulWidget {
//   const NewsPage({super.key});
//
//   @override
//   State<NewsPage> createState() => _NewsPageState();
// }
//
// class _NewsPageState extends State<NewsPage> {
//   var future;
//
//   @override
//   initState() {
//     super.initState();
//     future = NewsServices().getNews();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Cloud News',
//             style: TextStyle(
//               fontSize: 26,
//             ),
//           ),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               icon: const Icon(
//                 Icons.search,
//                 size: 26,
//                 color: Colors.blueAccent,
//               ),
//               onPressed: () {
//                 navigatorTo(context: context, page: const SearchPage());
//               },
//             ),
//             IconButton(
//               icon: const Icon(
//                 Icons.settings,
//                 size: 26,
//                 color: Colors.blueAccent,
//               ),
//               onPressed: () {
//                 navigatorTo(context: context, page: const SettingsPage());
//               },
//             ),
//           ],
//         ),
//         body: FutureBuilder<List<ArticleModel>>(
//           future: future,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasError) {
//                 // Display an error message if there is an issue
//                 return Center(
//                   child: Text(
//                     'Error: ${snapshot.error}',
//                     style: const TextStyle(color: Colors.red, fontSize: 16),
//                   ),
//                 );
//               } else if (snapshot.hasData && (snapshot.data)!.isEmpty) {
//                 // Display a hint if the data is empty
//                 return const Center(
//                   child: Text(
//                     'No news available. Please try again later.',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 );
//               } else {
//                 return Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       return newsCardItem(
//                         index: index,
//                         articles: snapshot.data as List<ArticleModel>,
//                       );
//                     },
//                   ),
//                 );
//               }
//             }
//             // Handle unexpected cases (fallback UI)
//             return const Center(
//               child: Text(
//                 'Something went wrong. Please try again later.',
//                 style: TextStyle(color: Colors.grey, fontSize: 18),
//               ),
//             );
//           },
//         ));
//   }
// }
