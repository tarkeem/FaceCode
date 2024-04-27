import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PrivacyAndPolicyWidget extends StatelessWidget {
  const PrivacyAndPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Center(
          child: Text(
            AppLocalizations.of(context)!.by_clicking_continue,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.user_agreement,
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              AppLocalizations.of(context)!.privacy_policy,
              style: TextStyle(color: Colors.blue),
            ),
            Text(AppLocalizations.of(context)!.and),
            Text(
              AppLocalizations.of(context)!.cookie_policy,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
