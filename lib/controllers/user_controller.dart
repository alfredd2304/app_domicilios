import 'package:firebase_database/firebase_database.dart';
import 'package:loggy/loggy.dart';
import '../models/users.dart';

class UserController {
  final String dbName = "users";
  final db = FirebaseDatabase.instance.ref();

  Future<void> addUser(Usuario user) async {
    logInfo("Adding User...");
    try {
      db.child(dbName).child(user.userId).set(user.toJson());
    } catch (e) {
      logError("Error adding user: $e");
      return Future.error(e);
    }
  }

  Future<Usuario> getUser(String userId) async {
    logInfo("Getting User...");
    try {
      var snapshot = await db.child(dbName).child(userId).get();
      var userData = snapshot.value as Map<dynamic, dynamic>?;
      if (userData != null) {
        return Usuario.fromJson(userData);
      } else {
        return Usuario('Usuario no encontrado', 'not@found.mail', "id: null");
      }
    } catch (e) {
      logError("Error getting user: $e");
      return Future.error(e);
    }
  }

  Future<void> updateUser(Usuario user) async {
    logInfo("Updating User...");
    try {
      db.child(dbName).child(user.userId).set(user.toJson());
    } catch (e) {
      logError("Error updating user: $e");
      return Future.error(e);
    }
  }
}
