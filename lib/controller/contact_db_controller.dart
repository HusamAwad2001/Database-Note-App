import 'package:database/controller/db_operations.dart';
import 'package:database/models/contact.dart';
import 'package:database/storage/dp_provider.dart';
import 'package:database/utils/app_consts.dart';
import 'package:sqflite/sqflite.dart';

class ContactDbController extends DbOperations<Contact>{

  late Database _database;

  ContactDbController() : _database = DBProvider().database;

  @override
  Future<bool> create(Contact object) async{
    // TODO: implement create
    int value = await _database.insert(CONTACT_TAPLE, object.toMap());
    return value != 0;
  }

  @override
  Future<bool> delete(int id) async{
    // TODO: implement delete
    return await _database.delete(CONTACT_TAPLE, where: 'id = ?', whereArgs: [id]) > 0;
  }

  @override
  Future<List<Contact>> read() async{
    // TODO: implement read
    List<Map<String, Object?>> data = await _database.query(CONTACT_TAPLE);
    return data.map((contactRowMap) => Contact.fromMap(contactRowMap)).toList();
  }

  @override
  Future<bool> update(int id, Contact object) async{
    // TODO: implement update
    return await _database.update(CONTACT_TAPLE, object.toMap(), where: 'id = ?', whereArgs: [id]) > 0;
  }
}