import 'package:OfflineAssets/models/PhotoModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:OfflineAssets/models/PermissionModel.dart';
import 'package:permission/permission.dart';

class Photos extends StatefulWidget {
  final bool permStatus;
  Photos({@required this.permStatus});
  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  @override
  Widget build(BuildContext context) {
    final models = Provider.of<ModelOperations>(context);

    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: models.fileModels.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.all(5),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image(
                        fit: BoxFit.cover,
                        image: widget.permStatus == true
                            ? FileImage(models.fileModels[index])
                            : NetworkImage(models.models[index].url),
                      ));
                }))
      ],
    );
  }
}
