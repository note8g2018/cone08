import 'package:cone08/action/validate_action.dart';
import 'package:cone08/controller/reg_controller.dart';
import 'package:cone08/model/person_model.dart';
import 'package:cone08/widget/textForm_m1_widget.dart';
import 'package:cone08/widget/text_m1_widget.dart';
import 'package:cone08/widget/text_m2_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegScreen extends StatefulWidget {
  static String route = 'Reg';

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  String _userName;
  String _passWord1;
  String _passWord2;
  String _email;
  bool showWidget1 = false;
  bool showWidget2 = false;
  bool showWidget3 = false;
  bool showWidget4 = false;
  bool test1 = false;
  bool test2 = false;
  bool test3 = false;
  bool test4 = false;

  void sendReg() async {
    Person person = Person(
      userName: _userName,
      passWord: _passWord2,
      email: _email,
      method: "reg",
    );
    final String method = await Reg.regToServer(person: person);
    String msg;
    switch (method) {
      case 'valid':
        msg = 'The data is not valid';
        break;
      case 'taken':
        msg = 'This user name is taken';
        break;
      case 'error':
        msg = 'There is an error';
        break;
      case 'login':
        msg = 'There are some error';
        break;
      default:
        msg = 'There are some error';
        break;
    }
    makeToast(msg);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
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
                  print(value);
                  test1 = ValidateDate.userName(_userName);
                  setState(() {
                    showWidget1 = !test1;
                  });
                },
              ),
              (showWidget1 == true)
                  ? TextM2(data: 'Enter a valiad username, please')
                  : SizedBox(),
              TextM1(
                data: '- At least 8 letters',
              ),
              TextM1(
                data: '- The first 3 letters must be from [a-z]',
              ),
              TextM1(
                data: '- the rest must be from [a-z]+[0-9]',
              ),
              TextFormM1(
                keyboardType: TextInputType.emailAddress,
                letterSpacing: 2.0,
                color: Colors.purple,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                labelText: 'E-Mail',
                onChanged: (value) {
                  _email = value;
                  test2 = ValidateDate.email(_email);
                  setState(() {
                    showWidget2 = !test2;
                  });
                },
              ),
              (showWidget2 == true)
                  ? TextM2(data: 'Enter a valiad E-Mail, please')
                  : SizedBox(),
              TextFormM1(
                obscureText: true,
                keyboardType: TextInputType.text,
                letterSpacing: 1.0,
                color: Colors.purple,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                labelText: 'new PassWord',
                onChanged: (value) {
                  _passWord1 = value;
                  test3 = ValidateDate.passWord1(_passWord1);
                  setState(() {
                    showWidget3 = !test3;
                  });
                },
              ),
              (showWidget3 == true)
                  ? TextM2(data: 'Enter a valiad passWord, please')
                  : SizedBox(),
              TextM1(
                data: '- At least 8 letters',
              ),
              TextM1(
                data: '- can be any of [a-z]+[0-9]+[!@#\$%^&*()_+-=]',
              ),
              TextFormM1(
                obscureText: true,
                keyboardType: TextInputType.text,
                letterSpacing: 1.0,
                color: Colors.purple,
                fontSize: 25.0,
                fontWeight: FontWeight.w500,
                labelText: 'Repeat the PassWord',
                onChanged: (value) {
                  _passWord2 = value;
                  test4 = (_passWord2 == _passWord1);
                  setState(() {
                    showWidget4 = !test4;
                  });
                },
              ),
              (showWidget4 == true)
                  ? TextM2(data: 'Passwords does not match')
                  : SizedBox(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RaisedButton(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  padding: EdgeInsets.all(10.0),
                  onPressed: () {
                    if (test1 && test2 && test3 && test4) {
                      sendReg();
                    }
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
