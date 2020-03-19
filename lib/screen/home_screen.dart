import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                padding: EdgeInsets.all(5.0),
                onPressed: () {},
                child: Text(
                  'Wirte Something',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
