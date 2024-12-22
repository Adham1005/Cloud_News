import 'package:cloud_news/model/article_model.dart';
import 'package:cloud_news/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locale_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<ArticleModel> _articles = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() async {
    setState(() {
      _isLoading = false;
      _searchController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
      FocusScope.of(context).unfocus();
    });

    try {
      final result = await NewsServices().searchNews(value: _searchQuery);
      setState(() {
        _articles = result;
      });
    } catch (error) {
      print('Error performing search: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizationProvider.locale.languageCode == 'en' ? 'Search' : 'البحث',
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: localizationProvider.locale.languageCode == 'en'
                    ? 'Search News...'
                    : 'بحث عن الأخبار...',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              _searchQuery = _searchController.text.trim();
                            });
                            _performSearch();
                          },
                          icon: const Icon(Icons.search)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                          onPressed: () {
                            _clearSearch();
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Show a loading indicator while fetching
            if (_isLoading) const CircularProgressIndicator(),

            // Display search results
            if (!_isLoading && _articles.isEmpty)
              Expanded(
                child: Center(
                    child: Text(localizationProvider.locale.languageCode == 'en'
                        ? "No articles found"
                        : 'لم يتم العثور على أي مقالات')),
              )
            else if (!_isLoading)
              Expanded(
                child: ListView.builder(
                  itemCount: _articles.length,
                  itemBuilder: (context, index) {
                    final article = _articles[index];
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => WebViewPage(url: article.url!),
                        //   ),
                        // );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              article.image ??
                                  'https://archive.org/download/placeholder-image/placeholder-image.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            article.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            localizationProvider.locale.languageCode == 'en'
                                ? article.subTitle ?? 'No description available'
                                : article.subTitle ?? 'لا يوجد وصف متاح',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                    // return ListTile(
                    //   title: Text(article.title),
                    //   subtitle: Text(article.description!),
                    //   onTap: () {
                    //
                    //   },
                    // );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
