import 'package:flutter/material.dart';

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
            "Your feed has ended..",
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
