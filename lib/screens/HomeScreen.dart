import 'package:flutter/material.dart';
import 'package:OfflineAssets/models/PhotoModel.dart';
import 'package:permission/permission.dart';
import 'package:provider/provider.dart';
import 'package:OfflineAssets/screens/Photos.dart';
import 'package:OfflineAssets/models/PermissionModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = true;
  bool permStts;

  @override
  void initState() {
    super.initState();
    PermFunctions()
        .requestPermission()
        .then((value) => print(PermFunctions().checkPermission().then((value) {
              print(value);
              permStts = value;
            })));
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit == true) {
      Provider.of<ModelOperations>(context).processModels().then((value) {
        isInit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "JohnBook",
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: Consumer<ModelOperations>(
          builder: (context, value, child) => isInit
              ? Center(child: CircularProgressIndicator())
              : Photos(
                  permStatus: permStts,
                ),
        ));
  }
}
