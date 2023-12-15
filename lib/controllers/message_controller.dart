import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/message.dart';
import '../models/users.dart';

class ChatController extends GetxController {
  final String dbName = "users";
  final ScrollController scrollController = ScrollController();
  var messages = <Message>[].obs;
  RxString username = ''.obs;
  final db = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> newMessage;
  ChatController() {
    scrollController.addListener(() {});
  }

  Future<void> start(String userId) async {
    messages.clear();
    newMessage = db
        .child(dbName)
        .child(userId)
        .child("messages")
        .onChildAdded
        .listen(_onNewMessage);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => scrollToEnd());
  }

  stop() {
    newMessage.cancel();
  }

  _onNewMessage(DatabaseEvent event) {
    final json = event.snapshot.value as Map<dynamic, dynamic>;
    messages.add(Message.fromJson(event.snapshot, json));
  }

  Future<void> sendMessage(Message msg, String userId) async {
    try {
      await db
          .child(dbName)
          .child(userId)
          .child("messages")
          .push()
          .set(msg.toJson());
    } catch (e) {
      logError("Error sending message: $e");
      return Future.error(e);
    }
  }

  void scrollToEnd() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  Future<String?> getUsername() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      DatabaseReference userRef = db.child(dbName).child(uid);
      DataSnapshot snapshot = await userRef.child('username').get();

      if (snapshot.value != null) {
        return snapshot.value.toString();
      }
    }
    return null;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
