import 'package:cloud_firestore/cloud_firestore.dart';
class demoCtr
{

  var fireStoreInstance=FirebaseFirestore.instance.collection('demmo');
  Future sendDp(String txt)async
  {

   await fireStoreInstance.add({
      "message":txt
    });

  }

}