import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_b/src/models/debtItem.dart';

debtNumber(DebtItem debt) {
  debtNumberStrich2(DebtItem debt) {
    if (debt.isDone) {
      return Colors.black;
    } else if (!debt.isDone) {
      return Colors.red;
    }
    return Colors.black;
  }

  debtNumberStrich(DebtItem debt) {
    if (debt.isDone) {
      return Colors.black;
    } else if (!debt.isDone) {
      return Colors.green;
    }
    return Colors.black;
  }

  if (debt.iOwe) {
    return Text(
      "-" + debt.debt.toString() + "€",
      style: TextStyle(
          color: debtNumberStrich2(debt),
          fontSize: 16.5,
          fontFamily: 'RobotoMono',
          fontWeight: FontWeight.w500,
          decoration:
              debt.isDone ? TextDecoration.lineThrough : TextDecoration.none),
    );
  } else if (!debt.iOwe) {
    return Text(
      "+" + debt.debt.toString() + "€",
      style: TextStyle(
          color: debtNumberStrich(debt),
          fontSize: 16.5,
          fontFamily: 'RobotoMono',
          fontWeight: FontWeight.w500,
          decoration:
              debt.isDone ? TextDecoration.lineThrough : TextDecoration.none),
    );
  }
}
