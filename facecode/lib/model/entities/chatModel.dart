<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String? from;
  String? to;
  String? content;

  Chat({
    this.from,
    this.to,
    this.content,
  });

  factory Chat.fromFirestore(
    QueryDocumentSnapshot<Object?> snapshot,
  ) {
    final data = snapshot.data() as Map;
    return Chat(
      from: data['from'],
      to: data?['to'],
      content: data?['content'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (from != null) "from": from,
      if (to != null) "to": to,
      if (content != null) "content": content,
    };
  }
=======
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String? from;
  String? to;
  String? content;

  Chat({
    this.from,
    this.to,
    this.content,
  });

  factory Chat.fromFirestore(
    QueryDocumentSnapshot<Object?> snapshot,
  ) {
    final data = snapshot.data() as Map;
    return Chat(
      from: data['from'],
      to: data?['to'],
      content: data?['content'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (from != null) "from": from,
      if (to != null) "to": to,
      if (content != null) "content": content,
    };
  }
>>>>>>> 91c7ac8aaae31f0755f083ddc29a7240948b71d5
}