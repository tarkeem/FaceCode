import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


class PrivacyAndPolicyWidget extends StatelessWidget {
  const PrivacyAndPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Center(
          child: Text(
            AppLocalizations.of(context)!.by_clicking_continue,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.user_agreement,
                style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w500),
              ),
              Text(
                AppLocalizations.of(context)!.privacy_policy,
                style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w500),
              ),
              Text(AppLocalizations.of(context)!.and,style: TextStyle(color: provider.myTheme == ThemeMode.dark ? Colors.white : Colors.black,fontSize: 15),),
              Text(
                AppLocalizations.of(context)!.cookie_policy,
                style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
