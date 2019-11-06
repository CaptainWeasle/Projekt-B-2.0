import 'dart:async';

import 'package:project_b/src/models/debtItem.dart';
import 'package:project_b/src/repository/repository.dart';

class NewDebtBloc {
  //Get instance of the Repository
  final _debtRepository = DebtRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _debtController = StreamController<List<DebtItem>>.broadcast();

  get debts => _debtController.stream;

  NewDebtBloc() {
    getDebts();
  }

  getDebts({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _debtController.sink.add(await _debtRepository.getAllDebts(query: query));
  }

  addDebt(DebtItem todo) async {
    await _debtRepository.insertDebt(todo);
    getDebts();
  }

  updateDebt(DebtItem todo) async {
    await _debtRepository.updateDebt(todo);
    getDebts();
  }

  deleteDebtById(int id) async {
    _debtRepository.deleteDebtById(id);
    getDebts();
  }

  dispose() {
    _debtController.close();
  }
}