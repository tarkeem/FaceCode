import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class ChatCtr {
  late CollectionReference<Map<String, dynamic>> _roomInstant;

  CollectionReference<Map<String, dynamic>> initializeChat(String roomId) {

    _roomInstant = FirebaseFirestore.instance.collection('chat').doc(roomId).collection('chat');
    return _roomInstant;
  }

  void sendMessage(
      {required String from, required String to, required String content}) {
    _roomInstant.add({
      "from": from,
      'to': to,
      'content': content,
      'date': DateTime.now().toString()
    });
  }

Future createRoom(String user1,String user2)async{
String chatroomName="$user1-$user2";   
//FirebaseFirestore.instance.collection('chat').doc(chatroomName).collection('chat').add({});
await FirebaseFirestore.instance.collection('chatrooms').add({
  "user1":user1,
  "user2":user2,
  "chatid":chatroomName,
});



  }


 Future<List<QueryDocumentSnapshot>> getMyChat(String user)async{
    
    List<QueryDocumentSnapshot> res=[];
var res1=await FirebaseFirestore.instance.collection('chatrooms').where('user1',isEqualTo: user).get();
var res2=await FirebaseFirestore.instance.collection('chatrooms').where('user2',isEqualTo: user).get();

res.addAll(res1.docs);
res.addAll(res2.docs);

return res;



  }


Future<List<QueryDocumentSnapshot>> isThereChat(String user1,String user2)async{
  List<QueryDocumentSnapshot> res=[];
var res1=await FirebaseFirestore.instance.collection('chatrooms').where('user1',isEqualTo: user1).where('user2',isEqualTo: user2).get();
var res2=await FirebaseFirestore.instance.collection('chatrooms').where('user2',isEqualTo: user1).where('user1',isEqualTo: user2).get();

res.addAll(res1.docs);
res.addAll(res2.docs);

return res;




  }


Future<String>GenerateToken()async
{
  var res=await http.post(Uri.parse(''),body: json.encode({}));
  var decoderes=json.decode(res.body);
  return decoderes['token'];
}
  
}
