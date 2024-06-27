import 'package:facecode/controller/SearchCtr.dart';
import 'package:facecode/model/entities/user_model.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/screen/other_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "searchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    final UserModel? loggedInUser = provider.userModel;
    print(loggedInUser!.lastName);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: TextField(
          style: TextStyle(fontSize: 16),
          cursorColor: Colors.grey[700],
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          cursorHeight: 30,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 1.5),
            filled: true,
            fillColor: Colors.grey[300],
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey[700], height: 3.7),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[700],
            ),
          ),
        ),
      ),
      body: searchQuery.isEmpty
          ? Center(child: Text("No users found...",style: Theme.of(context).textTheme.bodySmall,))
          : StreamBuilder<List<UserModel>>(
              stream: SearchCtr.searchUsers(searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('An error occurred'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No users found'));
                }
                List<UserModel> users = snapshot.data!;
                //This line to prevent search to retrieve my account
                users = users.where((user) => user.id != loggedInUser.id).toList();
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    UserModel user = users[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, OtherProfileScreen.routeName,arguments: user.id);
                      },
                      child: ListTile(
                        title: Text(
                          '${user.firstName} ${user.lastName}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        subtitle: Text(
                          user.jobTitle ?? '',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        leading: user.imageUrl != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(user.imageUrl!),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage("images/avatardefault.png")),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
