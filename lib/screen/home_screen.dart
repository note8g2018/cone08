import 'dart:io';

import 'package:cone08/action/file_action.dart';
import 'package:cone08/controller/logout_controller.dart';
import 'package:cone08/model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';

import 'login_screen.dart';

class Home extends StatefulWidget {
  static String route = 'Home';
  final Person personClient;

  Home({this.personClient});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _image;
  IOWebSocketChannel channel;

  void websocketInit() {
    const String url = 'ws://192.168.1.100:8888/picw';
    channel = IOWebSocketChannel.connect(url);
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.personClient.toJson());
    super.initState();
  }

  void logOut() async {
    await FileAction.deleteFile(fileName: 'login.json');
    await LogoutController.logout(person: widget.personClient);
    Navigator.pushNamed(context, LogIn.route);
  }

  Future getImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    channel.sink.add(image);
    Image kk = Image.file(_image);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: IconButton(icon: Icon(Icons.person), onPressed: () => logOut()),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
