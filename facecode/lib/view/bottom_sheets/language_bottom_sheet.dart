// ignore_for_file: must_be_immutable

import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeLaguage("en");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (provider.languageCode == "en") ...[
                  Text(
                    AppLocalizations.of(context)!.english,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  Icon(Icons.done, size: 35, color: Colors.black)
                ] else
                  Text(
                    AppLocalizations.of(context)!.english,
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              provider.changeLaguage("ar");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (provider.languageCode == "ar") ...[
                  Text(
                    AppLocalizations.of(context)!.arabic,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Icon(Icons.done, size: 35, color: Colors.black)
                ] else
                  Text(
                    AppLocalizations.of(context)!.arabic,
                    style: TextStyle(fontSize: 25, color: Colors.grey),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
