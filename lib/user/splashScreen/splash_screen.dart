import 'dart:async';
import 'package:flutter/material.dart';
import '/user/authentication/login_screen.dart';
import '/user/global/global.dart';
import '/user/mainScreens/main_screen.dart';

class UserSplashScreen extends StatefulWidget {
  const UserSplashScreen({Key? key}) : super(key: key);

  @override
  State<UserSplashScreen> createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 1), () async {
      Navigator.push(context, MaterialPageRoute(builder: (c) => MainScreen()));
      print(await fAuth.currentUser);
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        currentUid = currentFirebaseUser!.uid;
        // Send user to Main Screen
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        // Send user to login Screen
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Driver Connect App",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
