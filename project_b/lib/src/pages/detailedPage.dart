import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_b/src/blocs/newDebtBloc.dart';
import 'package:project_b/src/database/database.dart';
import 'package:project_b/src/models/debtItem.dart';
import 'package:project_b/src/ui_elements/debtNumberColor.dart';

class DetailedPage extends StatefulWidget {
  final NewDebtBloc debtBloc;
  final DebtItem debtItem;

  DetailedPage({
    this.debtBloc,
    this.debtItem,
  });

  @override
  State<StatefulWidget> createState() {
    return DetailedPageState();
  }
}

class DetailedPageState extends State<DetailedPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController beschreibungEditController = TextEditingController();

    var appBody = ListView(
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
                width: 400.0,
                child: Text(
                  'Schuld Übersicht',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 45.0),
                ),
              ),
              SizedBox(height: 42.0),
              itemRow(Icons.account_box, 'Name', widget.debtItem.name),
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
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          )
                        ],
                      ),
                    ],
                  ),
                  debtNumber(widget.debtItem),
                ],
              ),
              SizedBox(height: 22.0),
              itemRow(
                  Icons.date_range, 'Erstellt', widget.debtItem.debtStartDate),
              SizedBox(height: 22.0),
              itemRow(
                  Icons.date_range, 'Bis', widget.debtItem.debtDeadlineDate),
              SizedBox(height: 22.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.priority_high,
                            color: Colors.black,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            "Priorität",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          )
                        ],
                      ),
                    ],
                  ),
                  priorityFarbe(widget.debtItem),
                ],
              ),
              SizedBox(height: 22.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.directions,
                            color: Colors.black,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            "Schuld beglichen",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0),
                          )
                        ],
                      ),
                    ],
                  ),
                  isDone(widget.debtItem),
                ],
              ),
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
            ),
          ),
        ),
        SizedBox(height: 32.0),
      ],
    );

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
      body: appBody,
    );
  }
}
