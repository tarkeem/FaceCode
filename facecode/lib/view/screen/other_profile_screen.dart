import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facecode/controller/ChatCtr.dart';
import 'package:facecode/controller/PostCtr.dart';
import 'package:facecode/controller/followCtr.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/post_model.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/chat/chatRoomScreen.dart';
import 'package:facecode/view/widget/Postwidget.dart';
import 'package:facecode/view/widget/following_or_followers_bottomsheet.dart';
import 'package:facecode/view/widget/shared_signedin_app_bar.dart';
import 'package:facecode/view/widget/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtherProfileScreen extends StatefulWidget {
  static const String routeName = "otherprofileScreen";
  const OtherProfileScreen({super.key});

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    var provider = Provider.of<MyProvider>(context);
    bool isFollowing = provider.userModel?.following?.contains(id) ?? false;
    return Scaffold(
      appBar: SharedSignedInAppBar(
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
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
                        height: MediaQuery.of(context).size.height * 0.23,
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
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: InstaImageViewer(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.contain,
                                          imageUrl: model.imageUrl!,
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            "images/avatardefault.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: CachedNetworkImage(
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover for the profile picture
                                alignment: Alignment
                                    .topCenter, // Align the image to the top center
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
                                  alignment: Alignment
                                      .topCenter, // Align the default image to the top center
                                ),
                              ),
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
                            "${model.firstName} ${model.lastName}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () async {
                                try {
                                  var res = await ChatCtr().isThereChat(
                                      provider.userModel!.id!, model.id!);

                                  if (res.length == 0) {
                                    ChatCtr().createRoom(
                                        provider.userModel!.id!, model.id!);
                                  } else {
                                    var chatdata = res.first;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatRoom(
                                              roomId: chatdata['chatid'],
                                              FromUser: provider.userModel!.id!,
                                              toUser: model.id!),
                                        ));
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              icon: Icon(Icons.message))
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
                          InkWell(
                            onTap: () {
                              if (model.followers!.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  AppLocalizations.of(context)!.no_users_found,
                                  style: TextStyle(fontSize: 15),
                                )));
                              }
                              //print(model.following);
                              showUserListBottomSheet(context, model.followers!,
                                  AppLocalizations.of(context)!.followers);
                            },
                            child: Column(
                              children: [
                                Text(
                                  "${model.followers?.length}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.followers,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print(model.following);
                              if (model.following!.isEmpty ||
                                  model.following == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  AppLocalizations.of(context)!.no_users_found,
                                  style: TextStyle(fontSize: 15),
                                )));
                                return;
                              }
                              showUserListBottomSheet(context, model.followers!,
                                  AppLocalizations.of(context)!.following);
                            },
                            child: Column(
                              children: [
                                Text(
                                  "${model.following?.length}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.following,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
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
                            AppLocalizations.of(context)!.bio,
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
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.no_bio,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      isFollowing
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                              // UnFollow another user from here
                              onPressed: () {
                                ShowDialog.showCustomDialog(
                                    context,
                                    AppLocalizations.of(context)!.unfollow,
                                    Text(
                                        "${AppLocalizations.of(context)!.are_you_sure_do_you_want_to_unfollow} ${model.firstName} ?"),
                                    () async {
                                  await FollowCtr.unfollow(
                                      provider.userModel!.id!, id);
                                  setState(() {
                                    provider.userModel!.following!.remove(id);
                                  });
                                  Navigator.pop(context);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.following,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.check, color: Colors.white)
                                ],
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                              // Follow another user from here
                              onPressed: () async {
                                await FollowCtr.follow(
                                    provider.userModel!.id!, id);
                                setState(() {
                                  provider.userModel!.following!.add(id);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Follow",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.add, color: Colors.white)
                                ],
                              ),
                            ),
                      SizedBox(height: 20),
                      StreamBuilder(
                        stream: PostCtr.getProfilePosts(id),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<PostModel>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Something went wrong"),
                                ElevatedButton(
                                    onPressed: () {}, child: Text("Try again"))
                              ],
                            );
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Column(
                              children: [
                                SizedBox(height: 50),
                                Center(
                                  child: Text(AppLocalizations.of(context)!
                                      .no_posts_yet),
                                ),
                              ],
                            );
                          }

                          List<PostModel> posts =
                              snapshot.data!.docs.map((e) => e.data()).toList();
                          return Column(
                            children: posts.map((post) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: PostWidget(
                                  postC: post,
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
