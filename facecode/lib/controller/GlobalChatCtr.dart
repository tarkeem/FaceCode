import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalChatCtr {
  late CollectionReference<Map<String, dynamic>> _roomInstant;

  CollectionReference<Map<String, dynamic>> initializeChat(String roomId) {

    _roomInstant = FirebaseFirestore.instance.collection('globalchat').doc(roomId).collection('chat');
    return _roomInstant;
  }

  void sendMessage(
      {required String from, required String content}) {
    _roomInstant.add({
      "from": from,
      'content': content,
      'date': DateTime.now().toString()
    });
  }

Future createRoom(String chatname,String userid)async{
String chatid="$userid${DateTime.now().toString()}";
FirebaseFirestore.instance.collection('globalchat').doc(chatid).collection('chat').add({});
FirebaseFirestore.instance.collection('globalchatrooms').add({
  "chatid":chatid,
  "name":chatname
});



  }


Future<List<QueryDocumentSnapshot>> getGlobalChat()async{
    
var res=await FirebaseFirestore.instance.collection('globalchatrooms').get();

print(res.docs.length);

return res.docs;



  }




  
}
