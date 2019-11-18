import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_b/src/blocs/newDebtBloc.dart';
import 'package:project_b/src/models/debtItem.dart';
import 'package:project_b/src/ui_elements/customAlert.dart';
import 'package:intl/intl.dart';

class AddDebtDialog extends StatefulWidget {
  final NewDebtBloc newDebtBloc;

  AddDebtDialog({
    this.newDebtBloc,
  });
  @override
  State<StatefulWidget> createState() {
    return AddDebtDialogState();
  }
}

class AddDebtDialogState extends State<AddDebtDialog> {
  TextEditingController debtNameController = TextEditingController();
  TextEditingController debtAmountController = TextEditingController();
  TextEditingController debtDateController = TextEditingController();

  IconData _iconPrio1 = Icons.add_circle_outline;
  IconData _iconPrio2 = Icons.add_circle_outline;
  IconData _iconPrio3 = Icons.add_circle_outline;

  bool debtSwitch = false;
  var prio = 0;

  @override
  Widget build(BuildContext context) {
    getRightIcon() {
      if (prio == 1) {
        _iconPrio1 = Icons.add_circle;
        _iconPrio2 = Icons.add_circle_outline;
        _iconPrio3 = Icons.add_circle_outline;
      } else if (prio == 2) {
        _iconPrio2 = Icons.add_circle;
        _iconPrio1 = Icons.add_circle_outline;
        _iconPrio3 = Icons.add_circle_outline;
      } else if (prio == 3) {
        _iconPrio3 = Icons.add_circle;
        _iconPrio2 = Icons.add_circle_outline;
        _iconPrio1 = Icons.add_circle_outline;
      }
    }

    Widget addDebtDialog(AsyncSnapshot<List<DebtItem>> snapshot) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("ICH SCHULDE"),
                      Switch(
                        value: debtSwitch,
                        onChanged: (value) {
                          setState(() {
                            debtSwitch = value;
                          });
                        },
                        activeTrackColor: Theme.of(context).accentColor,
                        activeColor: Theme.of(context).primaryColor,
                      ),
                      Text("MIR SCHULDET")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: TextField(
                    onChanged: (s){
                      print(debtNameController.text);
                    },
                    controller: debtNameController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: "Wer?/ Wem?"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: TextField(
                    controller: debtAmountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        icon: Icon(Icons.monetization_on),
                        labelText: "Wie viel?"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: DateTimeField(
                    controller: debtDateController,
                    format: DateFormat("yyyy-MM-dd"),
                    decoration: InputDecoration(
                        icon: Icon(Icons.date_range), labelText: "Bis Wann?"),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(_iconPrio1),
                        iconSize: 30,
                        color: Colors.red,
                        onPressed: () {
                          setState(
                            () {
                              prio = 1;
                              getRightIcon();
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(_iconPrio2),
                        iconSize: 30,
                        color: Colors.orange,
                        onPressed: () {
                          setState(
                            () {
                              prio = 2;
                              getRightIcon();
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(_iconPrio3),
                        iconSize: 30,
                        color: Colors.green,
                        onPressed: () {
                          setState(
                            () {
                              prio = 3;
                              getRightIcon();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  splashColor: Colors.blue[600],
                  highlightColor: Colors.blue[400],
                  onTap: () {
                    setState(
                      () {
                        DebtItem item = DebtItem();
                        item.name = debtNameController.text;
                        item.debt = double.parse(debtAmountController.text);
                        item.debtDeadlineDate = debtDateController.text;
                        item.debtStartDate =
                            DateTime.now().toString().substring(0, 10);
                        item.iOwe = !debtSwitch;
                        item.priority = prio;
                        item.descr = "Beschreibung hinzufügen";
                        print(item);
                        widget.newDebtBloc.addDebt(item);
                        Navigator.pop(context, () {
                          setState(() {});
                        });
                      },
                    );
                  },
                  child: Ink(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    height: 50,
                    width: 370,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Bestätigen",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    var _appBody = StreamBuilder(
      stream: widget.newDebtBloc.debts,
      builder: (BuildContext context, AsyncSnapshot<List<DebtItem>> snapshot) {
        return addDebtDialog(snapshot);
      },
    );

    return CustomAlert(
      content: _appBody,
    );
  }
}
