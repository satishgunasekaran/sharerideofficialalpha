import 'package:flutter/material.dart';
import '/driver/global/global.dart';
import '/driver/splashScreen/splash_screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({ Key? key }) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed:(){
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c) => const DriverSplashScreen(),));
        } ,
        child: const Text(
        "Sign out"
      ),
      )
    );
  }
}