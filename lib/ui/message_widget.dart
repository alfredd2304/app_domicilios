import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/message_controller.dart';
import '../models/message.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController _msgCtrl = TextEditingController();
  @override
  void dispose() {
    chatController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      chatController.start(user.uid);
    }

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
                controller: chatController.scrollController,
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
    String? username = await chatController.getUsername();
    User? user = FirebaseAuth.instance.currentUser;
    if (username != null) {
      await chatController.sendMessage(
          Message(_msgCtrl.text, username, 'user@mail.com'), user!.uid);
      chatController.scrollToEnd();
      await _responderComoRepartidor();
      chatController.scrollToEnd();
    } else {
      print("Error: No se pudo obtener el nombre de usuario");
    }
  }

  Future<void> _responderComoRepartidor() async {
    User? user = FirebaseAuth.instance.currentUser;

    await Future.delayed(const Duration(seconds: 2));
    chatController.sendMessage(
        Message("Hola, soy el repartidor... en que te puedo ayudar?",
            "Repartidor", "repartidor@gmail.com"),
        user!.uid);
  }
}
