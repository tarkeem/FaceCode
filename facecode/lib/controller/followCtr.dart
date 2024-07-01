import 'package:cloud_firestore/cloud_firestore.dart';

class FollowCtr {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> follow(String currentUserId, String targetUserId) async {
    try {
      await _firestore.collection('Users').doc(currentUserId).update({
        'following': FieldValue.arrayUnion([targetUserId])
      });

      await _firestore.collection('Users').doc(targetUserId).update({
        'followers': FieldValue.arrayUnion([currentUserId])
      });

      print('Successfully followed the user');
    } catch (e) {
      print('Error following user: $e');
    }
  }

  static Future<void> unfollow(
      String currentUserId, String targetUserId) async {
    try {
      await _firestore.collection('Users').doc(currentUserId).update({
        'following': FieldValue.arrayRemove([targetUserId])
      });

      await _firestore.collection('Users').doc(targetUserId).update({
        'followers': FieldValue.arrayRemove([currentUserId])
      });

      print('Successfully unfollowed the user');
    } catch (e) {
      print('Error unfollowing user: $e');
    }
  }
}
