import 'dart:async';
import 'package:project_b/src/database/database.dart';
import 'package:project_b/src/models/debtItem.dart';


class DebtDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createDebt(DebtItem debt) async {
    final db = await dbProvider.database;
    var result = db.insert(debtTABLE, debt.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<DebtItem>> getDebts({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    //TODO: HIER NOCH VARS ÄNDERN
    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(debtTABLE,
            columns: columns,
            where: 'name LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(debtTABLE, columns: columns);
    }

    List<DebtItem> debts = result.isNotEmpty
        ? result.map((item) => DebtItem.fromDatabaseJson(item)).toList()
        : [];
    return debts;
  }

  //TODO: HIER ÄNDERN
  Future<int> updateDebt(DebtItem debt) async {
    final db = await dbProvider.database;

    var result = await db.update(debtTABLE, debt.toDatabaseJson(),
        where: "id = ?", whereArgs: [debt.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteDebt(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(debtTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllDebts() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      debtTABLE,
    );

    return result;
  }
}