import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/message_controller.dart';
import '../models/message.dart';

class ChatWidget extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController _msgCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Widget'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  var msg = chatController.messages[index];
                  return ListTile(
                    title: Text(msg.user),
                    subtitle: Text(msg.text),
                  );
                },
              ),
            ),
          ),
          _messageInput(),
        ],
      ),
    );
  }

  Widget _messageInput() {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Message",
        ),
        controller: _msgCtrl,
        onSubmitted: (value) async {
          await _sendMessage();
          _msgCtrl.clear();
        },
      ),
    );
  }

  Future<void> _sendMessage() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String username = 'user';

      if (user != null) {
        DatabaseReference userRef =
            FirebaseDatabase.instance.ref().child('users').child(user.uid);
        DatabaseEvent event = await userRef.child('username').once();
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.value != null) {
          username = snapshot.value.toString();
        }
      }

      await chatController.sendMessage(
          Message(_msgCtrl.text, username, user?.email ?? 'user@mail.com'));
    } catch (e) {
      print('Error al enviar el mensaje: $e');
    }
  }
}
