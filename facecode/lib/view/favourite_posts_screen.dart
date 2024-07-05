import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/widget/Postwidget.dart';
import 'package:facecode/view/widget/shared_signedin_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FavouritePostsScreen extends StatelessWidget {
  static const String routeName = "favPosts";
  const FavouritePostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: SharedSignedInAppBar(showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Favourite Posts",
                style: Theme.of(context).textTheme.bodyLarge),
            StreamBuilder<List<PostModel>>(
              stream: PostCtr.getFavPosts(provider.userModel!.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Something went wrong"),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Try again"),
                      )
                    ],
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 350),
                    child: Text("No Favourite Posts yet.."),
                  ));
                }
                List<PostModel> favPosts = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: favPosts.length,
                    itemBuilder: (context, index) {
                      PostModel post = favPosts[index];
                      return PostWidget(postC: post);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
