import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullDescriptionScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final String? category;
  final String? language;
  final String? publishedAt;
  final String? urlToImage;
  final String? author;

  const FullDescriptionScreen({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.language,
    required this.publishedAt,
    required this.urlToImage,
    required this.author,
  });

  @override
  State<FullDescriptionScreen> createState() => _FullDescriptionScreenState();
}

class _FullDescriptionScreenState extends State<FullDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(
            'News',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            Text(widget.language ?? ''),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title ?? "",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text('By ${widget.author ?? 'unknown'}'),
                Text('Published By: ${widget.publishedAt ?? 'unknown'}'),
                widget.urlToImage != null? CachedNetworkImage(
                  imageUrl: widget.urlToImage??'',
                  placeholder: (context, url) => const Text('loading...', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ): const Text('No image found'),
                Text(
                  widget.description ?? 'No content available',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}
