import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/screens/home.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../common/states/app_state.dart';
import '../../common/utils/utils.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppState(),
        )
      ],
      child: MyApp(),
    );
  }
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
