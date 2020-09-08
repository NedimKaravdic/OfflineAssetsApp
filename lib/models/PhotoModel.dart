import 'package:flutter/foundation.dart';
import 'package:permission/permission.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PhotoModel {
  String id;
  String personName;
  String url;
  File path;
  PhotoModel(
      {@required this.personName, @required this.url, this.id, this.path});
}

class ModelOperations with ChangeNotifier {
  PermissionName permission = PermissionName.Storage;

  List<PhotoModel> _models = [
    PhotoModel(
      id: "0",
      personName: "Faruk",
      url: 'http://izvornade.com/wp-content/uploads/2016/12/Faruk-Cidic.jpg',
    ),
    PhotoModel(
      id: "1",
      personName: "Omer",
      url: 'https://magazinplus.eu/wp-content/uploads/2019/12/hafiz-buku.jpg',
    ),
    PhotoModel(
      id: "2",
      personName: "Imran",
      url:
          'https://scontent.fsjj1-1.fna.fbcdn.net/v/t31.0-8/18954781_111547186116143_674352643303108205_o.jpg?_nc_cat=100&_nc_sid=09cbfe&_nc_ohc=x3IjG6ZO0DkAX_9mwVZ&_nc_ht=scontent.fsjj1-1.fna&oh=7e01ce7d8d6ecb17c3e70d4a6762d57c&oe=5F7D18ED',
    ),
    PhotoModel(
      id: "3",
      personName: "Nedim",
      url:
          'https://scontent.fsjj1-1.fna.fbcdn.net/v/t1.0-9/90285088_10216068848653900_4623926095400402944_n.jpg?_nc_cat=111&_nc_sid=09cbfe&_nc_ohc=8NpU9GJJ70wAX-ppoGh&_nc_ht=scontent.fsjj1-1.fna&oh=b887a05ff9157227cf3ca2d30c8df0ac&oe=5F7B0AC5',
    ),
    PhotoModel(
        id: "4",
        personName: 'John',
        url:
            'https://pics.me.me/being-a-developer-is-not-stressing-at-all-john-37510499.png')
  ];

  List<PhotoModel> get models {
    return [..._models];
  }

  List<PhotoModel> updatedModels = [];

  void addModels(PhotoModel model) {
    _models.add(model);
  }

  List<FileSystemEntity> _fileModels = [];

  List<FileSystemEntity> get fileModels {
    return [..._fileModels];
  }

  Future<void> getModels(String name, String url, String id) async {
    final imageUrl = url;
    final response = await http.get(imageUrl);
    final getDir = await getApplicationDocumentsDirectory();
    final directory = getDir.path + "/Images";
    final model = directory + "/$name.jpg";
    var finalModel = File(model);

    final Directory dir = await Directory(directory).create(recursive: false);

    if (!fileModels.contains(finalModel)) {
      finalModel.writeAsBytesSync(response.bodyBytes);
      populateFileModels(finalModel);
      notifyListeners();
    }
  }

  void populateFileModels(File file) async {
    _fileModels.add(file);
  }

  Future<void> processModels() async {
    for (int i = 0; i < _models.length; i++) {
      getModels(_models[i].personName, _models[i].url, models[i].id);
    }
  }

  void checkPermission() {
    List<PermissionName> permissions = [];
    permissions.add(permission);
    Permission.getPermissionsStatus(permissions);
  }

  void requestPermission() async {
    List<PermissionName> permissions = [];
    permissions.add(permission);
    await Permission.requestPermissions(permissions);
  }
}
