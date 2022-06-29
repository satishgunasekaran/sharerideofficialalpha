import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
String? currentUid;

// Firebase Realtime database content but not used yet
FirebaseDatabase fBase = FirebaseDatabase.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref("users");
Map? userdata;

Future<Map?> getUserDetails(uid) async {
  DatabaseReference child = ref.child(uid);
  print('Charles');
  DatabaseEvent event = await child.once();
  userdata = event.snapshot.value as Map?;
  print(userdata!['name']);
  print(userdata!['email']);
  return userdata;
}
