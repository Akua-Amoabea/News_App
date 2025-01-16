import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/Colors/colors.dart';
import 'package:untitled2/Provider/news_notifier.dart';
import 'package:untitled2/screen/full_description_screen.dart';

import '../main.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with RouteAware {

  /*@override
  void didPopNext() {
    Provider.of<NewsNotifier>(context, listen: false).clearNews();
    super.didPopNext();
    debugPrint('The message cleared');
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }*/

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    List articles = Provider.of<NewsNotifier>(context, listen: false).allNews;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',

          style: Theme.of(context).textTheme.headlineMedium,
        ),

        titleSpacing: 14,
        forceMaterialTransparency: true,
      ),
      body: articles.isEmpty
          ? const Center(
              child: Text('No News Available'),
            )
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullDescriptionScreen(
                                title: articles[index].title,
                                description: articles[index].content,
                                category: 'Business',
                                language: 'en',
                              publishedAt: articles[index].publishedAt,
                              urlToImage: articles[index].urlToImage,
                              author: articles[index].author,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        articles[index].title?? '',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                    subtitle: Text(
                      articles[index].description?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11),
                    ),
                      trailing: articles[index].urlToImage != null? CachedNetworkImage(
                        imageUrl: articles[index].urlToImage,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ): const Text('No Image found')
                      

                  ),
                );
              },
            ),
    );
  }
}
