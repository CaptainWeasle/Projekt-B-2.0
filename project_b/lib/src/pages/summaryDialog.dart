import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_b/src/blocs/newDebtBloc.dart';
import 'package:project_b/src/models/debtItem.dart';

class SummaryDialog extends StatefulWidget {
  final NewDebtBloc newDebtBloc;

  const SummaryDialog({Key key, this.newDebtBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SummaryDialogState();
  }
}

class SummaryDialogState extends State<SummaryDialog> {
  @override
  Widget build(BuildContext context) {
    var bilanzColor;

    double calcAllMyDebts(AsyncSnapshot<List<DebtItem>> snapshot) {
      double debt = 0;
      if (snapshot.hasData) {
        if (snapshot.data.length != null) {
          print("DIE SCHEIßE HAT KEINE DATA LENGTH");
          for (int i = 0; i < snapshot.data.length; i++) {
            if (snapshot.data[i].iOwe) {
              debt += snapshot.data[i].debt;
            }
          }
        }
      } else {
        print("DIE SCHEIßE HAT KEINE DATAAAAA");
      }
      return debt;
    }

    double calcOtherDebts(AsyncSnapshot<List<DebtItem>> snapshot) {
      double debt = 0;
      if (snapshot.hasData) {
        if (snapshot.data != null) {
          for (int i = 0; i < snapshot.data.length; i++) {
            if (!snapshot.data[i].iOwe) {
              debt += snapshot.data[i].debt;
            }
          }
        }
      }
      return debt;
    }

    double calcDebtDifference(AsyncSnapshot<List<DebtItem>> snapshot) {
      return calcOtherDebts(snapshot) - calcAllMyDebts(snapshot);
    }

    Widget summaryDialogContent(AsyncSnapshot<List<DebtItem>> snapshot) {
      return Column(
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
                    " -" + calcAllMyDebts(snapshot).toString() + "€",
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
                    " " + calcOtherDebts(snapshot).toString() + "€",
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
                    " " + calcDebtDifference(snapshot).toString() + "€",
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
    }

    var _appBody = StreamBuilder(
      stream: widget.newDebtBloc.debts,
      builder: (BuildContext context, AsyncSnapshot<List<DebtItem>> snapshot) {
        return Text(snapshot.toString());
        //return summaryDialogContent(snapshot);
      },
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: _appBody,
    );
  }
}
