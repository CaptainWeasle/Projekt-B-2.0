import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:project_b/src/blocs/newDebtBloc.dart';
import 'package:project_b/src/models/debtItem.dart';
import 'package:project_b/src/ui_elements/customAlert.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NewDebtBloc _newDebtBloc = NewDebtBloc();
    DismissDirection _dismissDirection = DismissDirection.horizontal;

    TextEditingController debtNameController = TextEditingController();
    TextEditingController debtAmountController = TextEditingController();
    TextEditingController debtDateController = TextEditingController();

    bool debtSwitch = false;

    double calcAllMyDebts() {
      double debt = 0;
      
      return debt;
    }

    double calcOtherDebts() {
      double debt = 0;
      
      return debt;
    }

    double calcDebtDifference() {
      return calcOtherDebts() - calcAllMyDebts();
    }

    Widget summaryDialog = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text("Summary", style: TextStyle(color: Colors.black, fontSize: 25)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("ICH SCHULDE INSGESAMT:"),
            Text(" " + calcAllMyDebts().toString() + "€"),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("ICH BEKOMME INSGESAMT:"),
            Text(" " + calcOtherDebts().toString() + "€"),
          ],
        ),
        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("ALLGEMEINE BILANZ:"),
          Text(" " + calcDebtDifference().toString() + "€")
        ]),
      ]),
    );

    Widget addDebtDialog = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Wer schuldet wem? ",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Row(
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
            TextField(
              controller: debtNameController,
              decoration: InputDecoration(
                  icon: Icon(Icons.account_circle), labelText: "Wer?/ Wem?"),
            ),
            TextField(
              controller: debtAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on), labelText: "Wie viel?"),
            ),
            DateTimeField(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: MaterialButton(
                elevation: 5.0,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  setState(
                    () {
                      DebtItem item = DebtItem(iOwe: true);
                      item.name = debtNameController.text;
                      item.debt = double.parse(debtAmountController.text);
                      item.debtDeadlineDate =
                          debtDateController.text + " 00:00:00Z";
                      item.iOwe = !debtSwitch;
                      _newDebtBloc.addDebt(item);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    var _summaryIcon = IconButton(
      icon: Icon(Icons.assessment),
      onPressed: () {
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.01),
            transitionBuilder: (context, a1, a2, widget) {
              final curvedValue =
                  Curves.linearToEaseOut.transform(a1.value) - 1.0;
              return Transform(
                transform:
                    Matrix4.translationValues(0.0, curvedValue * 600, 0.0),
                child: Opacity(
                    opacity: a1.value,
                    child: CustomAlert(
                      content: summaryDialog,
                    )),
              );
            },
            transitionDuration: Duration(milliseconds: 350),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      },
    );

    var _floatingActionButton = FloatingActionButton(
      onPressed: () {
        showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.2),
          transitionBuilder: (context, a1, a2, widget) {
            return CustomAlert(
              content: addDebtDialog,
            );
          },
          pageBuilder: (context, animation1, animation2) {},
          transitionDuration: Duration(milliseconds: 0),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
        );
      },
      child: Icon(Icons.add),
    );

    Widget loadingData() {
      _newDebtBloc.getDebts();
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Loading...",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      );
    }

    Widget noDebtMessageWidget() {
      return Container(
        child: Text(
          "Start adding Debts...",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        ),
      );
    }

    Widget getDebtCardWidget(AsyncSnapshot<List<DebtItem>> snapshot) {
      if (snapshot.hasData) {
        return snapshot.data.length != 0
            ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, itemPosition) {
                  DebtItem debt = snapshot.data[itemPosition];
                  final Widget dismissibleCard = new Dismissible(
                    background: Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Deleting",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      color: Colors.redAccent,
                    ),
                    onDismissed: (direction) {
                      _newDebtBloc.deleteDebtById(debt.id);
                    },
                    direction: _dismissDirection,
                    key: new ObjectKey(debt),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey[200], width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          leading: InkWell(
                            onTap: () {
                              debt.isDone = !debt.isDone;
                              _newDebtBloc.updateDebt(debt);
                            },
                            child: Container(
                              //decoration: BoxDecoration(),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: debt.isDone
                                    ? Icon(
                                        Icons.done,
                                        size: 26.0,
                                        color: Colors.indigoAccent,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 26.0,
                                        color: Colors.tealAccent,
                                      ),
                              ),
                            ),
                          ),
                          title: Text(
                            debt.name,
                            style: TextStyle(
                                fontSize: 16.5,
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.w500,
                                decoration: debt.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        )),
                  );
                  return dismissibleCard;
                },
              )
            : Container(
                child: Center(
                child: noDebtMessageWidget(),
              ));
      } else {
        return Center(
          /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
          child: loadingData(),
        );
      }
    }

    var _appBody = StreamBuilder(
      stream: _newDebtBloc.debts,
      builder: (BuildContext context, AsyncSnapshot<List<DebtItem>> snapshot) {
        return getDebtCardWidget(snapshot);
      },
    );

    dispose() {
      _newDebtBloc.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Debt Collector 3000"),
        actions: <Widget>[
          _summaryIcon,
        ],
      ),
      floatingActionButton: _floatingActionButton,
      body: _appBody,
    );
  }
}
