// user_list_bottom_sheet.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facecode/controller/userCrt.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showUserListBottomSheet(
    BuildContext context, List<String?> userIds, String title) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<UserModel>>(
        future: UserCtr.getUsersByIds(userIds),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context)!.no_users_found));
          }
          List<UserModel> users = snapshot.data!;
          if (users.isEmpty) {
            return Text("No $title yet");
          }
          return Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: users[index].imageUrl == null ||
                                    users[index].imageUrl!.isEmpty
                                ? AssetImage('images/avatardefault.png')
                                    as ImageProvider
                                : CachedNetworkImageProvider(
                                    users[index].imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                          '${users[index].firstName} ${users[index].lastName}',
                          style: Theme.of(context).textTheme.bodySmall),
                      subtitle: Text(
                        users[index].jobTitle ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
