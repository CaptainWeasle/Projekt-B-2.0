import 'package:project_b/src/events/debtList_events.dart';
import 'package:project_b/src/models/debtItem.dart';

abstract class DebtEvents{}

class AddDebt extends DebtEvents{
  DebtItem debt;
  AddDebt(
    this.debt
  );
}

class RemoveDebt extends DebtEvents{
  DebtItem debt;
  RemoveDebt(this.debt);
}

class GetDebts extends DebtEvents{

}

class UpdateDebt extends DebtEvents{
  DebtItem debt;
  UpdateDebt(this.debt);
}