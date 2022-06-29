import 'package:flutter/material.dart';
import '../splashScreen/splash_screen.dart';
import '/driver/global/global.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        fAuth.signOut();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const UserSplashScreen(),
            ));
      },
      child: const Text("Sign out"),
    ));
  }
}
