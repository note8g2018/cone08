import 'dart:convert';

import 'package:cone08/action/file_action.dart';
import 'package:cone08/controller/login_controller.dart';
import 'package:cone08/model/person_model.dart';
import 'package:cone08/screen/reg_screen.dart';
import 'package:cone08/widget/textForm_m1_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_screen.dart';

class LogIn extends StatefulWidget {
  static String route = 'LogIn';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String _userName;
  String _passWord;

  void sendLoginButton() async {
    Person person = Person(userName: _userName, passWord: _passWord);
    sendLogin(person);
  }

  void sendLogin(Person person) async {
    Person personS = await Login.loginToServer(person: person);
    switch (personS.method) {
      case 'PS':
        makeToast(personS.desc);
        break;
      case 'login':
        saveLogin(personS);
        break;
      default:
        makeToast('There are some erorr');
        break;
    }
  }

  void makeToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 17.0);
  }

  void saveLogin(Person person) async {
    await FileAction.writeToFile2(
        dataJson: jsonEncode(person), fileName: 'login.json');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(personClient: person)),
    );
  }

  void readLogin() async {
    final String personString =
        await FileAction.readFromFile2(fileName: 'login.json');
    if (personString != null) {
      Person person = Person.fromJson(jsonDecode(personString));
      sendLogin(person);
    }
  }

  @override
  void initState() {
    readLogin();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text(
            'CoolME.me',
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormM1(
                keyboardType: TextInputType.text,
                letterSpacing: 2.0,
                color: Colors.purple,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                labelText: 'User Name',
                onChanged: (value) {
                  _userName = value;
                },
              ),
              TextFormM1(
                obscureText: true,
                keyboardType: TextInputType.text,
                letterSpacing: 1.0,
                color: Colors.purple,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                labelText: 'PassWord',
                onChanged: (value) {
                  _passWord = value;
                },
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: RaisedButton(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.pink,
                    ),
                  ),
                  onPressed: () {
                    sendLoginButton();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: RaisedButton(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(20.0),
                  onPressed: () {
                    Navigator.pushNamed(context, RegScreen.route);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
