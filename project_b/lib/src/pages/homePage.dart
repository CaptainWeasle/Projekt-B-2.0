import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_b/src/blocs/newDebtBloc.dart';
import 'package:project_b/src/models/debtItem.dart';
import 'package:project_b/src/pages/addDebtDialog.dart';
import 'package:project_b/src/ui_elements/customAlert.dart';
import 'package:project_b/src/ui_elements/debtNumberColor.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  NewDebtBloc _newDebtBloc = NewDebtBloc();

  Timer timer;
  @override
  void initState() {
    print("init state aufgerufen");
    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) => () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DismissDirection _dismissDirection = DismissDirection.endToStart;

    var bilanzColor;

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

    Widget summaryDialog = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          height: 60,
          width: 370,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  "Summary",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "ICH SCHULDE GESAMT:",
                  style: TextStyle(
                      height: 2.5, fontSize: 20, fontFamily: 'Montserrat'),
                ),
                Text(
                  " -" + calcAllMyDebts().toString() + "€",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "ICH BEKOMME GESAMT:",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  " " + calcOtherDebts().toString() + "€",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Meine Bilanz:",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  " " + calcDebtDifference().toString() + "€",
                  style: TextStyle(
                    height: 2.5,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    color: bilanzColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    var _summaryIcon = IconButton(
      icon: Icon(Icons.assessment),
      onPressed: () {
        setState(() {
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
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 350),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, animation1, animation2) {});
        });
      },
    );

    var _floatingActionButton = FloatingActionButton(
      onPressed: () async {
        await showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.2),
          transitionBuilder: (context, a1, a2, widget) {
            return AddDebtDialog(
              newDebtBloc: _newDebtBloc,
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
                        padding: EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.centerRight,
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
                          //decoration: BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: debt.isDone
                                ? Icon(
                                    Icons.check_box,
                                    size: 26.0,
                                    color: Colors.blue[200],
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    size: 26.0,
                                    color: Colors.blue[200],
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
                        trailing: debtNumber(debt),
                        onTap: () {
                          Navigator.pushNamed(context, "DetailedPage");
                        },
                      ),
                    ),
                  );
                  return dismissibleCard;
                },
              )
            : Container(
                child: Center(
                  child: noDebtMessageWidget(),
                ),
              );
      } else {
        return Center(
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Debt Collector 2.0"),
        actions: <Widget>[
          _summaryIcon,
        ],
      ),
      floatingActionButton: _floatingActionButton,
      body: _appBody,
    );
  }
}
