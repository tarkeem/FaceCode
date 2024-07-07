import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotifyController {
  static final String _serverToken = 'YOUR_SERVER_KEY_HERE';
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> sendNotification({
    required String title,
    required String body,
    required String userId,
  }) async {
    var userDoc = await _firestore.collection('Users').doc(userId).get();
    var token = userDoc['fcmToken'];

    if (token != null) {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$_serverToken',
        },
        body: jsonEncode(<String, dynamic>{
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
          'priority': 'high',
          'to': token,
        }),
      );
    }
  }

  static Future<void> notifyNewLike(String userId) async {
    await sendNotification(
      title: 'FaceCode',
      body: 'You Have new likes!',
      userId: userId,
    );
  }
  //  static Future<void> notifychat(String userId) async {
  //   await sendNotification(
  //     title: 'FaceCode',
  //     body: 'You Have new Messages!',
  //     userId: userId,
  //   );
  // }
  static Future<void> notifyNewComment(String userId, String postId) async {
    await sendNotification(
      title: 'FaceCode',
      body: 'Someone commented on your post!',
      userId: userId,
    );
  }

  static Future<void> notifyNewFollower(String userId) async {
    await sendNotification(
      title: 'FaceCode',
      body: 'You have a new followers!',
      userId: userId,
    );
  }
}
