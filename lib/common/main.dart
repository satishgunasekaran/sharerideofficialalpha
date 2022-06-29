import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'states/app_state.dart';
import 'utils/utils.dart';

void main() {
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Share Ride',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: "Share Ride"),
    );
  }
}
