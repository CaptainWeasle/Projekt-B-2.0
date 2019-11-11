import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_b/src/blocs/newDebtBloc.dart';
import 'package:project_b/src/models/debtItem.dart';

class SummaryDialog extends StatefulWidget {
  final List<DebtItem> localList;

  const SummaryDialog({
    Key key,
    this.localList,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SummaryDialogState();
  }
}

class SummaryDialogState extends State<SummaryDialog> {
  @override
  Widget build(BuildContext context) {

    var bilanzColor; 

    double calcAllMyDebts() {
      double debt = 0;
      for (int i = 0; i < widget.localList.length; i++) {
        if (widget.localList[i].iOwe) {
          debt += widget.localList[i].debt;
        }
      }
      return debt;
    }

    double calcOtherDebts() {
      double debt = 0;
      for (int i = 0; i < widget.localList.length; i++) {
        if (!widget.localList[i].iOwe) {
          debt += widget.localList[i].debt;
        }
      }
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

    var _appBody = Container();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: summaryDialog,
    );
  }
}
