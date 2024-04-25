import 'package:cloud_firestore/cloud_firestore.dart';

class CommentCtrl {
  late CollectionReference<Map<String, dynamic>> _roomInstant;



  Future<void> likeComment(String id) async {
    var res = await _roomInstant.doc(id);
    var old = await res.get();
    res.update({'likesNum': old['likesNum'] + 1});
  }

  Future<void> dislikeComment(String id) async {
    var res = await _roomInstant.doc(id);
    var old = await res.get();
    res.update({'dislikesNum': old['dislikesNum'] + 1});
  }

  Future<void> deleteComment(String id) async {
    var res = await _roomInstant.doc(id);
    res.delete();
  }
}
