import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_b/src/models/debtItem.dart';

begleichenButtonText(DebtItem debt) {
  if (debt.isDone) {
    return "Schuld nicht beglichen";
  }
  return "Schuld begleichen";
}

begleichenButtonTap(DebtItem debt) {
  if (debt.isDone) {
    return debt.isDone = false;
  }
  return debt.isDone = true;
}
 werSchuldetWem(DebtItem debt){
      if(debt.iOwe == true){
        return Text("Ich schulde...",
          style: TextStyle(
            fontSize: 25.0,
            fontStyle: FontStyle.italic,
            
          ),
        );
      }else if(debt.iOwe == false){
        return Text("Mir schuldet...",
          style: TextStyle(
            fontSize: 25.0,
            fontStyle: FontStyle.italic,
           
          ),
        );
      }
      return Text("Nur arme leihen sich Geld...",
        style: TextStyle(
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          
        ),
      );
    }
isDone(DebtItem debt) {
  if (debt.isDone) {
    return Text(
      "Ja",
      style: TextStyle(
        fontSize: 20,
      ),
    );
  } else if (!debt.isDone) {
    return Text(
      "Nein",
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
  return "";
}

priorityFarbe(DebtItem debt) {
  if (debt.priority == 1) {
    return Text(
      "High",
      style: TextStyle(
        fontSize: 20,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  } else if (debt.priority == 2) {
    return Text(
      "Normal",
      style: TextStyle(
        fontSize: 20,
        color: Colors.orange,
        fontWeight: FontWeight.bold,
      ),
    );
  } else if (debt.priority == 3) {
    return Text(
      "Low",
      style: TextStyle(
        fontSize: 20,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  return Text(
    "Keine",
    style: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

itemRow(icon, name, title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.black,
              ),
              SizedBox(width: 6.0),
              Text(
                name,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              )
            ],
          ),
        ],
      ),
      Text(title.toString(),
          style: TextStyle(color: Colors.black, fontSize: 20.0))
    ],
  );
}

Widget debtNumber(DebtItem debt) {
  if (debt.iOwe) {
    return Text(
      "-" + debt.debt.toString() + "€",
      style: TextStyle(
        color: Colors.red,
        fontSize: 20,
      ),
    );
  } else if (!debt.iOwe) {
    return Text(
      "+" + debt.debt.toString() + "€",
      style: TextStyle(
        color: Colors.green,
        fontSize: 20,
      ),
    );
  }
  return Text("data");
}

debtNumberCard(DebtItem debt) {
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
