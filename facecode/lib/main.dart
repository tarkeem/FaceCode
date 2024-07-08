import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/styles/my_theme.dart';
import 'package:facecode/view/favourite_posts_screen.dart';
import 'package:facecode/view/screen/addpost.dart';
import 'package:facecode/view/screen/chat/globalChatBoard.dart';
import 'package:facecode/view/screen/homepage.dart';
import 'package:facecode/view/screen/auth/loginScreen.dart';
import 'package:facecode/view/screen/auth/resetPassword.dart';
import 'package:facecode/view/screen/auth/signUpScreen.dart';
import 'package:facecode/view/screen/other_profile_screen.dart';
import 'package:facecode/view/screen/profile/edit_cover_screen.dart';
import 'package:facecode/view/screen/profile/edit_profilePicture_screen.dart';
import 'package:facecode/view/screen/profile/edit_bio_screen.dart';
import 'package:facecode/view/screen/profile/edit_profile_screen.dart';
import 'package:facecode/view/screen/search_screen.dart';
import 'package:facecode/view/screen/settings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider<MyProvider>(
      create: (context) => MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      locale: Locale(provider.languageCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser != null
          ? HomePage.routeName
          : LoginScreen.routeName,
      routes: {
        FavouritePostsScreen.routeName: (context) => FavouritePostsScreen(),
        globalChatBoard.routeName: (context) => globalChatBoard(),
        OtherProfileScreen.routeName: (context) => OtherProfileScreen(),
        SearchScreen.routeName: (context) => SearchScreen(),
        //chatBoard.routeName: (context) => chatBoard(),
        EditCoverScreen.routeName: (context) => EditCoverScreen(),
        EditBioScreen.routeName: (context) => EditBioScreen(),
        EditProfilePictureScreen.routeName: (context) =>
            EditProfilePictureScreen(),
        EditProfile.routeName: (context) => EditProfile(),
        Addpost.routeName: (context) => Addpost(),
        AppSettings.routeName: (context) => AppSettings(),
        HomePage.routeName: (context) => HomePage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
      },
      theme: MyTheme(provider).lightTheme,
      darkTheme: MyTheme(provider).darkTheme,
      themeMode: provider.myTheme,
    );
  }
}
