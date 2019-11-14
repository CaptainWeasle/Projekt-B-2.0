import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_b/src/blocs/newDebtBloc.dart';
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
  TextEditingController beschreibungEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var appBody = Column(
      children: <Widget>[
        SizedBox(height: 50, child: Container(color: Colors.blue[100],),),
        Container(
          width: 500,
          height: 117,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            
          ),
          
          child: Column(
            children: <Widget>[
              Container(
                width: 400.0,
                child: Text(
                  ' Schuld ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 45.0),
                ),
              ),
              Container(
                width: 400.0,
                child: Text(
                  ' Übersicht',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 45.0),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                  padding: EdgeInsets.fromLTRB(32, 0, 32, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      SizedBox(height: 32.0),
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
                                  )
                                ],
                              ),
                            ],
                          ),
                          debtNumber(widget.debtItem),
                        ],
                      ),
                      SizedBox(height: 22.0),
                      itemRow(Icons.date_range, 'Erstellt',
                          widget.debtItem.debtStartDate),
                      SizedBox(height: 22.0),
                      itemRow(Icons.date_range, 'Bis',
                          widget.debtItem.debtDeadlineDate),
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
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
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Beschreibung:",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        child: EditableText(
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                          backgroundCursorColor: Colors.red,
                          focusNode: FocusNode(),
                          controller: beschreibungEditController,
                          cursorColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  splashColor: Colors.blue[300],
                  highlightColor: Colors.blue[100],
                  onTap: () {
                    setState(() {
                      begleichenButtonTap(widget.debtItem);
                    });
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          begleichenButtonText(widget.debtItem),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  splashColor: Colors.red[600],
                  highlightColor: Colors.red[400],
                  onTap: () {
                    widget.debtBloc.deleteDebtById(widget.debtItem.id);
                    Navigator.pop(context);
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          "Schuld Löschen",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
          ),
          new FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Icon(Icons.arrow_back),
          ),
        ],
      ),
      backgroundColor: Colors.blue[200],
      body: appBody,
    );
  }
}
