import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class HiveDB {
  static const String DB_NAME = 'flutter_bin';
  static var box = Hive.box(DB_NAME);

  // #user
  static void storeUser(User user) async => box.put('user', user.uid);

  static User loadUser() => box.get('user');

  static void removeUser() async => box.delete('user');

// // #language
// static void storeLang(String lang) async => box.put('lang', lang);
//
// static String loadLang() => box.get('lang');
//
// // #mode
// static void storeMode(bool isMode) async => box.put('isMode', isMode);
//
// static String loadMode() => box.get('isMode');
//
// // #note
// static void storeNote(Note note) async => box.put('notes', note);
//
// static Note loadNote() => Note.fromJson(box.get('notes'));
//
// static void removeNote() async => box.delete('notes');
}
