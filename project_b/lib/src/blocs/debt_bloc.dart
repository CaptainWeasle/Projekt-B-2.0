import 'package:bloc/bloc.dart';
//import 'package:project_b/src/events/debtList_events.dart';
import 'package:project_b/src/events/debt_events.dart';
import 'package:project_b/src/models/debtItem.dart';
import 'package:project_b/src/repository/repository.dart';

class DebtBloc extends Bloc<DebtEvents, DebtItem> {
  final _debtRepository = DebtRepository();

  @override
  DebtItem get initialState => DebtItem.initial();

/*
  getTodos({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _debtController.sink.add(await _debtRepository.getAllTodos(query: query));
  }
*/
  getDebts({String query}) async {
    await _debtRepository.getAllDebts(query: query);
  }

  addDebt(DebtItem debt) async {
    await _debtRepository.insertDebt(debt);
    getDebts();
  }

  updateDebt(DebtItem debt) async {
    await _debtRepository.updateDebt(debt);
    getDebts();
  }

  deleteDebtById(int id) async {
    _debtRepository.deleteDebtById(id);
    getDebts();
  }

  @override
  Stream<DebtItem> mapEventToState(
    DebtEvents event,
  ) async* {
    if (event is AddDebt) {
      await _debtRepository.insertDebt(event.debt);
      getDebts();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
