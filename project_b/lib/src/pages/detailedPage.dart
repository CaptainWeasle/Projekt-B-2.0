import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailedPageState();
  }
}

class DetailedPageState extends State<DetailedPage> {
  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8,),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(32)
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
                  itemRow(Icons.monetization_on, 'Schulden', '23'),
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
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(32)),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20.0),
                  Icon(Icons.add, color: Colors.black, size: 24.0),
                  SizedBox(width: 40.0),
                  Text(
                    'Beschreibung',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 32.0),
          Spacer(),
        ],
      ),
    );
  }
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
