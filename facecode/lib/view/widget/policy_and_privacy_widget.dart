import 'package:flutter/material.dart';

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
            "By clicking Continue, you agree to FaceCode’s",
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "User Agreement",
              style: TextStyle(color: Colors.blue),
            ),
            Text(","),
            Text(
              " Privacy Policy",
              style: TextStyle(color: Colors.blue),
            ),
            Text(", and"),
            Text(
              " Cookie Policy.",
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
