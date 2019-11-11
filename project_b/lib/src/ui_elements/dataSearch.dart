import 'package:flutter/material.dart';
import 'package:project_b/src/models/debtItem.dart';
import 'package:project_b/src/pages/detailedPage.dart';

class DataSearch extends SearchDelegate<String> {
  final List<DebtItem> list;

  DataSearch({
    this.list,
  });

  final recentTest = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    final debtList = [];

    for (int i = 0; i < list.length; i++) {
      debtList.add(list[i].name);
    }

    final suggestionList = query.isEmpty
        ? recentTest
        : debtList.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          for (int i = 0; i < list.length; i++) {
              if (list[i].name ==
                  debtList[index]) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailedPage()));
              }
            }

        },
        leading: Icon(Icons.account_box),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
