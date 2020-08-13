import 'package:flutter/material.dart';
import 'widgets.dart';
import 'value.dart';
// import 'state.dart';
// import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomePageState();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // colorTextAppBar
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(43.0),
            child: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.help, color: colorMain), onPressed: () {}),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(
                    color: Color.fromRGBO(182, 182, 182, 0.35),
                    height: 0.5,
                  ),
                ),
                title: Text('Тестовая версия',
                    style: TextStyle(
                        color: colorRed,
                        fontSize: 16,
                        fontWeight: FontWeight.normal)),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.more_vert, color: colorGrey),
                      onPressed: () {}),
                ],
                centerTitle: true,
                elevation: 0.0,
                brightness: Brightness.dark,
                backgroundColor: Colors.white)),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[]),
        ),
        bottomNavigationBar: ButtonFree());
  }
}
