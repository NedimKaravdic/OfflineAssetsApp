import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/HomeScreen.dart';
import 'package:OfflineAssets/models/PhotoModel.dart';

void main() {
  runApp(NotCoolApp());
}

class NotCoolApp extends StatefulWidget {
  @override
  _NotCoolAppState createState() => _NotCoolAppState();
}

class _NotCoolAppState extends State<NotCoolApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ModelOperations()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: HomeScreen(),
        ),
      ),
    );
  }
}
