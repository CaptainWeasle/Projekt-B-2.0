import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final debtTABLE = 'Debt';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;
  //bool changed = false;
  Future<Database> get database async {
    /*if(!changed){
      changeTable(_database, 1);
      changed = true;
    }*/
    if (_database != null) return _database;
    _database = await createDatabase();
    //changeTable(_database, 1);
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveDebt.db is our database instance name
    String path = join(documentsDirectory.path, "ReactiveDebt.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }
/*
  void changeTable(Database database, int version) async{
    await database.rawInsert(
      "ALTER TABLE $debtTABLE "
      "ADD descr TEXT"
    );
  }*/

  void initDB(Database database, int version) async {
    await database.execute(" CREATE TABLE " + debtTABLE + " ("
        " id INTEGER PRIMARY KEY, "
        " name TEXT, "
        " debt REAL, "
        " debtStartDate TEXT, "
        " debtDeadlineDate TEXT, "
        " priority INTEGER, "
        " iOwe INTEGER, "
        " is_done INTEGER, "
        " descr TEXT "
        ") ");
  }
}
