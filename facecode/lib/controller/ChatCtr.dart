import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCtr{


late CollectionReference<Map<String, dynamic>> _roomInstant;

  CollectionReference<Map<String, dynamic>> initializeChat(String roomId)
  {
    _roomInstant = FirebaseFirestore.instance.collection(roomId);
    return _roomInstant;
  }

  void sendMessage({required String from,required String to,required String content})
  {
     _roomInstant.add({
                        "from": from,
                        'to': to,
                        'content': content,
                        'date': DateTime.now().toString()
                      });
  }
 
}