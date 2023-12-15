import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../models/message.dart';
import '../models/users.dart';

class ChatController extends GetxController {
  final String dbName = "users";
  var messages = <Message>[].obs;

  start() {
    messages.add(Message("Hola", "user", "user@mail.com"));
    messages.add(Message("¿Cómo estás?", "user2", "user2@mail.com"));
  }

  Future<void> sendMessage(Message msg) async {
    messages.add(msg);
  }

  _onNewMessage(DatabaseEvent event) {
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    Usuario user = Usuario.fromJson(json);
    messages.addAll(user.messages
        .map((msg) => Message(msg.text, user.username, user.mail)));
  }
}
