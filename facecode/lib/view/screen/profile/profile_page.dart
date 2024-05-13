// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/view/screen/addpost.dart';
import 'package:facecode/view/screen/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  UserModel model;

  ProfilePage({super.key, required this.model});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    Future<void> updateUserModel(UserModel updatedModel) async {
      setState(() {
        widget.model = updatedModel;
      });
    }
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Addpost.routeName,
                      arguments: widget.model);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/defaultCover.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5)),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          widget.model.imageUrl ?? "images/avatardefault.png",
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //Inner Column
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.model.firstName ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.model.lastName ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Text(
                widget.model.jobTitle ?? "",
                style: TextStyle(fontSize: 17),
              ),
              Row(
                children: [
                  Text(
                    "${widget.model.country ?? ""}, ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    "${widget.model.state ?? ""}, ",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    widget.model.city ?? "",
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
              SizedBox(height: 10,),
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
                      child: widget.model.additionalAttributes != null
                          ? Center(
                            child: Text(
                                widget.model.additionalAttributes!['bio'],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                          )
                          : Center(
                            child: Text(
                                'No bio yet',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Addpost.routeName,
                            arguments: widget.model);
                      },
                      child: Text(
                        "Add Post+",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      onPressed: () async{
                        UserModel? updatedModel = await Navigator.pushNamed(
                          context,
                          EditProfile.routeName,
                          arguments: widget.model,
                        ) as UserModel?;
                        if (updatedModel != null) {
                          updateUserModel(updatedModel);
                        }
                      },
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
