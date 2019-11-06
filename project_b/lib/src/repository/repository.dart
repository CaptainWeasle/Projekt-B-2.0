import 'package:project_b/src/dao/debt_dao.dart';
import 'package:project_b/src/models/debtItem.dart';

class DebtRepository {
  final debtDao = DebtDao();

  Future getAllDebts({String query}) => debtDao.getDebts(query: query);

  Future insertDebt(DebtItem debt) => debtDao.createDebt(debt);

  Future updateDebt(DebtItem debt) => debtDao.updateDebt(debt);

  Future deleteDebtById(int id) => debtDao.deleteDebt(id);

  //We are not going to use this in the demo
  Future deleteAllDebts() => debtDao.deleteAllDebts();
}
