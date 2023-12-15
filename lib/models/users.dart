import 'message.dart';

class Usuario {
  String username;
  String mail;
  String userId;
  List<Message> messages;

  Usuario(this.username, this.mail, this.userId, {List<Message>? messages})
      : messages = messages ?? [];

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'mail': mail,
      'userId': userId,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }

  factory Usuario.fromJson(Map<dynamic, dynamic> json) {
    return Usuario(
      json['username'] ?? 'username',
      json['mail'] ?? 'not@found.mail',
      json['userId'] ?? '',
      messages: (json['messages'] as List<dynamic>?)
              ?.map((messageJson) => Message.fromJson(messageJson, json))
              .toList() ??
          [],
    );
  }
}
