// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class Mediagridwidget extends StatelessWidget {
  List<String>? images;

  Mediagridwidget({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment Media")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 50.0,
          mainAxisSpacing: 15.0,
        ),
        itemCount: images!.length,
        itemBuilder: (context, index) {
          return InstaImageViewer(
            child: CachedNetworkImage(
              imageUrl: images![index],
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
