import 'dart:io';
import 'package:database/utils/app_consts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider _instance = DBProvider._internal();
  late Database _database;

  factory DBProvider() {
    return _instance;
  }

  Database get database => _database;
  DBProvider._internal();

  Future<Database> initDatabase() async {
    //PATH_PROVIDER => getApplicationDocumentsDirectory
    Directory directory = await getApplicationDocumentsDirectory();
    //PATH => join
    String path = join(directory.path, DB_NAME);
    return _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async{
        await db.execute("CREATE TABLE $CONTACT_TAPLE("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT,"
            "mobile TEXT"
            ")");
      }
    );
  }
}
