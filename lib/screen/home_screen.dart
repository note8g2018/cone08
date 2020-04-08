import 'dart:convert';
import 'dart:io';

import 'package:cone08/action/file_action.dart';
import 'package:cone08/controller/logout_controller.dart';
import 'package:cone08/model/person_model.dart';
import 'package:flutter/cupertino.dart';
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
  File imageFile;
  Image image;
  List<Image> imageList =[];
  List<Text> ttt = [Text('a'), Text('b'),];
  IOWebSocketChannel channel;

  void websocketInit() {
    //const String url = 'ws://192.168.1.100:8888/picw';
    const String url = 'ws://coolme.me:8888/picw';
    channel = IOWebSocketChannel.connect(url);
    channel.stream.listen(
            (data){
          setState(() {
            imageList = List.from(imageList)..add(Image.memory(base64Decode(data)));

            //ttt =List.from(ttt)..add(Text('c'));
            print('fff');
          });

        }
    );
  }

  @override
  void initState() {
    websocketInit();
    // TODO: implement initState
    super.initState();
  }

  void logOut() async {
    await FileAction.deleteFile(fileName: 'login.json');
    await LogoutController.logout(person: widget.personClient);
    Navigator.pushNamed(context, LogIn.route);
  }

  Future getImage() async {
    final imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final List<int> bytes = imageFile.readAsBytesSync();
    final String imageS = base64Encode(bytes);
    final List<int> bytes2 = base64Decode(imageS);
    final Map<String, dynamic> dataJson =
    {
      "userName": widget.personClient.userName,
      "pic": imageS,
      "method": "add",
    };

    channel.sink.add(jsonEncode(dataJson));


    setState(() {
      image = Image.memory(bytes2);
    });
  }

//  Widget getImageList()
//  {
//    setState(() {
//      for(var ii in imageList)
//      {
//        return ii;
//      }
//    });
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: IconButton(icon: Icon(Icons.person), onPressed: () => logOut()),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: ListView(
              children: imageList.isEmpty? <Widget>[Text('ggg')] : imageList,
            ),
          ),
          Flexible(
            flex: 1,
            child: image == null ? Text('No image selected.') : image,
          ),
        ],
      ),

//          Center(
//            child:
//                image == null ? Text('No image selected.') : image,
//          ),
 //     ],),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
