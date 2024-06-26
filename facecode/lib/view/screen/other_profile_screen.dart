import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/widget/shared_signedin_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class OtherProfileScreen extends StatelessWidget {
  static const String routeName = "otherprofileScreen";
  const OtherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: SharedSignedInAppBar(
        showBackButton: true,
        userId: id,
      ),
      body: FutureBuilder(
        future: UserCtr.getUserById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User not found'));
          }
          UserModel model = snapshot.data!;
          return Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.27,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: model.coverUrl != null && model.coverUrl != ''
                          ? InstaImageViewer(
                              child: CachedNetworkImage(
                                fit: BoxFit.fitWidth,
                                imageUrl: model.coverUrl!,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            )
                          : Image.asset(
                              "images/defaultCover.jpg",
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      top: 60,
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                        ),
                        child: ClipOval(
                          child: model.imageUrl != null
                              ? InstaImageViewer(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: model.imageUrl!,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      "images/avatardefault.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Image.asset(
                                  "images/avatardefault.png",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Inner Column
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          model.firstName ?? "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          model.lastName ?? "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Text(
                      model.jobTitle ?? "",
                      style: TextStyle(fontSize: 17),
                    ),
                    Row(
                      children: [
                        Text(
                          "${model.country ?? ""}, ",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "${model.state ?? ""}, ",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          model.city ?? "",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              "Followers",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              "Following",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              "Posts",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Bio
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bio',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Center(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: model.bio != null && model.bio != ''
                                ? Center(
                                    child: Text(
                                      model.bio!,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black87),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'No bio',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black87),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  //Follow another user from heeeeeeereeeeeeeeeeeee
                  onPressed: () {},
                  child: Text(
                    "Follow",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
