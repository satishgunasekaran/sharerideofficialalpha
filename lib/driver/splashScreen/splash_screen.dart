import 'dart:async';

import 'package:flutter/material.dart';
import '/driver/authentication/login_screen.dart';
import '/driver/global/global.dart';
import '/driver/mainScreens/main_screen.dart';

class DriverSplashScreen extends StatefulWidget {
  const DriverSplashScreen({Key? key}) : super(key: key);

  @override
  State<DriverSplashScreen> createState() => _DriverSplashScreenState();
}

class _DriverSplashScreenState extends State<DriverSplashScreen> {

  startTimer(){
    Timer(const Duration(seconds: 1), () async 
    {
      print(await fAuth.currentUser);
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        currentUid = currentFirebaseUser! .uid;
         // Send user to Main Screen
      Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));

      }else{
        // Send user to login Screen
      Navigator.push(
        context, MaterialPageRoute(builder: (c)=> LoginScreen()));

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple,Colors.orange])
        ),
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo1.png'),
              const SizedBox(height: 10,),
              const Text("Driver Connect App",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}