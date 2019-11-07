import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailedPageState();
  }
}
class DetailedPageState extends State<DetailedPage>{
  @override
  Widget build(BuildContext context) {
    var appBody = Container();
    return Scaffold(appBar: AppBar(title: Text("Details 2.0"),),body: appBody,);  
  }
  
}