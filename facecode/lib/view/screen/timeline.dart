// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/addpost.dart';
import 'package:facecode/view/widget/Postwidget.dart';
import 'package:facecode/view/widget/your_feed_ended_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Timeline extends StatefulWidget {
  Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var userModel = provider.userModel;
    if (userModel!.following == null || userModel.following!.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset("images/emptyFeed.png"),
            ),
          ),
          SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.your_feed_is_empty,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      );
    }
    FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Addpost.routeName, arguments: userModel);
      },
      backgroundColor: Colors.grey[300],
      child: Icon(
        Icons.add,
      ),
    );

    return StreamBuilder(
      stream: PostCtr.getTimeLinePosts(provider.userModel!.following!),
      builder: (context, AsyncSnapshot<QuerySnapshot<PostModel>> snapshot) {
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
                onPressed: () {
                  setState(() {}); // retry
                },
                child: Text("Try again"),
              )
            ],
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset("images/emptyFeed.png"),
                ),
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.your_feed_is_empty,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          );
        }

        List<PostModel> posts =
            snapshot.data!.docs.map((e) => e.data()).toList();
        return Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == posts.length) {
                    return YourFeedEndedWidget();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PostWidget(
                      postC: posts[index],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
