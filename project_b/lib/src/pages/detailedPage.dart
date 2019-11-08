import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_b/src/database/database.dart';
import 'package:project_b/src/models/debtItem.dart';

class DetailedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailedPageState();
  }
}

class DetailedPageState extends State<DetailedPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController beschreibungEditController = TextEditingController();

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

    var appBody = Container();
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.blue[200],
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: EdgeInsets.fromLTRB(32, 0, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 32.0),
                Container(
                  width: 200.0,
                  child: Text(
                    'Schuld Übersicht',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 45.0),
                  ),
                ),
                SizedBox(height: 42.0),
                itemRow(Icons.account_box, 'Name', 'Test'),
                SizedBox(height: 22.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.monetization_on,
                              color: Colors.black,
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              "Schulden",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                        "debt"), //Andre´s neues kacksystem hier, siehe DEBTNUMBER
                  ],
                ),
                SizedBox(height: 22.0),
                itemRow(Icons.date_range, 'Erstellt', 'dann und dann bla'),
                SizedBox(height: 22.0),
                itemRow(Icons.date_range, 'Bis', 'morgen'),
                SizedBox(height: 22.0),
                itemRow(Icons.priority_high, 'Priorität', 'High'),
                SizedBox(height: 22.0),
                itemRow(Icons.directions, 'Schuld beglichen', 'Nope'),
              ],
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
                height: 150.0,
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(32)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoTextField(
                    controller: beschreibungEditController,
                    cursorColor: Colors.black,
                  ),
                ),),
          ),
          SizedBox(height: 32.0),
          Spacer(),
        ],
      ),
    );
  }
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
      Text(title, style: TextStyle(color: Colors.black, fontSize: 20.0))
    ],
  );
}
