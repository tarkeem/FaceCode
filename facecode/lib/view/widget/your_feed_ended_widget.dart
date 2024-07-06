import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YourFeedEndedWidget extends StatelessWidget {
  const YourFeedEndedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline, color: Colors.grey, size: 60),
          SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)!.your_feed_has_ended,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontSize: 18,
                ),
          ),
        ],
      ),
    );
  }
}
