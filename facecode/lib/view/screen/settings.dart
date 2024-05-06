import 'package:facecode/providers/my_provider.dart';
import 'package:facecode/view/bottom_sheets/language_bottom_sheet.dart';
import 'package:facecode/view/bottom_sheets/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AppSettings extends StatelessWidget {
  static const String routeName = "AppSettings";
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        iconTheme: IconThemeData(color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: provider.myTheme == ThemeMode.dark
                ? Color(0xFF181818)
                : Colors.white,
          ),
          height: MediaQuery.of(context).size.height * 0.40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: LanguageBottomSheet(),
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black, width: 2),
                  ),
                  child: Row(
                    children: [
                      Text(
                        provider.languageCode == "en"
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                AppLocalizations.of(context)!.theme,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    isScrollControlled: true,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.50,
                        child: ThemeBottomSheet(),
                      );
                    },
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black, width: 2),
                  ),
                  child: Row(
                    children: [
                      Text(
                          provider.myTheme == ThemeMode.light
                              ? "Light"
                              : "Dark",
                          style: Theme.of(context).textTheme.bodyMedium,),
                      Spacer(),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
