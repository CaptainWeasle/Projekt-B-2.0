import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_b/src/blocs/newDebtBloc.dart';
import 'package:project_b/src/models/debtItem.dart';
import 'package:project_b/src/pages/addDebtDialog.dart';
import 'package:project_b/src/pages/detailedPage.dart';
import 'package:project_b/src/pages/summaryDialog.dart';
import 'package:project_b/src/ui_elements/dataSearch.dart';
import 'package:project_b/src/ui_elements/debtNumberColor.dart';
import 'package:project_b/src/ui_elements/headerClipper.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  NewDebtBloc _newDebtBloc = NewDebtBloc();

  List<DebtItem> localList = [];

  Timer timer;
  @override
  void initState() {
    print("init state aufgerufen");

    DateTime test = DateTime.now();
    print(test);

    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) => () {});

    print("deleted");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DismissDirection _dismissDirection = DismissDirection.endToStart;

    updateLocalList(List<DebtItem> list) {
      localList = list;
    }

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

    var _menuButton = FloatingActionButton(
      heroTag: "menu",
      onPressed: () {
        _scaffoldKey.currentState.openDrawer();
      },
      child: Icon(Icons.menu),
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
      localList = [];
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
                padding: EdgeInsets.only(
                  top: 4,
                ),
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
                            "Löschen",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      color: Colors.redAccent,
                    ),
                    onDismissed: (direction) {
                      _newDebtBloc.deleteDebtById(debt.id);
                      updateLocalList(snapshot.data);
                    },
                    direction: _dismissDirection,
                    key: new ObjectKey(debt),
                    child: Container(
                      color: Colors.blue[200],
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey[200], width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.blue[100],
                        child: ListTile(
                          leading: InkWell(
                            onTap: () {
                              debt.isDone = !debt.isDone;
                              _newDebtBloc.updateDebt(debt);
                              updateLocalList(snapshot.data);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: debt.isDone
                                  ? Icon(
                                      Icons.check_box,
                                      size: 26.0,
                                      color: Colors.blue[300],
                                    )
                                  : Icon(
                                      Icons.check_box_outline_blank,
                                      size: 26.0,
                                      color: Colors.blue[300],
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
                          trailing: debtNumberCard(debt),
                          onTap: () {
                            updateLocalList(snapshot.data);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedPage(
                                  debtBloc: _newDebtBloc,
                                  debtItem: snapshot.data[itemPosition],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                  updateLocalList(snapshot.data);
                  return dismissibleCard;
                },
              )
            : Container(
                child: Center(
                  child: noDebtMessageWidget(),
                ),
              );
      } else {
        updateLocalList(snapshot.data);
        return Center(
          child: loadingData(),
        );
      }
    }

    var _searchIcon = IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: DataSearch(
            list: localList,
          ),
        );
      },
    );

    var _drawer = Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Suche [BETA]'),
            onTap: () {
              setState(() {
                Navigator.pop(context);
                showSearch(
                  context: context,
                  delegate: DataSearch(
                    list: localList,
                  ),
                );
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.assessment),
            title: Text('Zusammenfassung'),
            onTap: () {
              setState(() {
                Navigator.pop(context);
                showGeneralDialog(
                    barrierColor: Colors.black.withOpacity(0.01),
                    transitionBuilder: (context, a1, a2, widget) {
                      final curvedValue =
                          Curves.linearToEaseOut.transform(a1.value) - 1.0;
                      return Transform(
                        transform: Matrix4.translationValues(
                            0.0, curvedValue * 600, 0.0),
                        child: Opacity(
                          opacity: a1.value,
                          child: SummaryDialog(
                            localList: localList,
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
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text("beglichene Schulden löschen"),
            onTap: () {
              setState(
                () {
                  for (int i = 0; i < localList.length; i++) {
                    if (localList[i].isDone) {
                      _newDebtBloc.deleteDebtById(localList[i].id);
                    }
                  }
                  Navigator.pop(context);
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_forever),
            title: Text("ALLE Schulden löschen"),
            onTap: () {
              setState(
                () {
                  for (int i = 0; i < localList.length; i++) {
                    _newDebtBloc.deleteDebtById(localList[i].id);
                  }
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
    );

    var _appBody = Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
            color: Colors.blue[200],
          ),
          width: double.infinity,
          child: SafeArea(
            child: ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  color: Colors.blue[100],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 400.0,
                      child: Text(
                        ' Debt ',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 45.0),
                      ),
                    ),
                    Container(
                      width: 400.0,
                      child: Text(
                        ' Collector',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 45.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: StreamBuilder(
            stream: _newDebtBloc.debts,
            builder:
                (BuildContext context, AsyncSnapshot<List<DebtItem>> snapshot) {
              return getDebtCardWidget(snapshot);
            },
          ),
        )
      ],
    );

    dispose() {
      _newDebtBloc.dispose();
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: _drawer,
      backgroundColor: Colors.blue[300],
      floatingActionButton: Stack(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.symmetric(
              horizontal: 32.0,
            ),
            child: Align(
              child: _menuButton,
              alignment: Alignment.bottomLeft,
            ),
          ),
          Align(
            child: _floatingActionButton,
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
      body: _appBody,
      /*appBar: AppBar(
        title: Text("Debt Collector"),
        actions: <Widget>[
          _searchIcon,
          _summaryIcon,
        ],
      ),*/
    );
  }
}
