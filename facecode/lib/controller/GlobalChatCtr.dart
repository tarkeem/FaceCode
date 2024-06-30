import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
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


Future<String>GenerateToken(String channel)async
{
  try {
    var res=await http.post(Uri.parse('http://localhost:3000/'),body: {
    
    "channelName":channel,
     "uid":"0",
    "tokenType":"uid"
  });

 
  var decoderes=json.decode(res.body);
    print(decoderes);
  return decoderes['token'];
  } catch (e) {

print(e);
    rethrow ;
    
  }

  
}

}
