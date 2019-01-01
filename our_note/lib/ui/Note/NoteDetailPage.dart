import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class NoteDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;

  NoteDetailPage(this.title, this.subtitle);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  TextEditingController _controller;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: '${widget.title}\n\n${widget.subtitle}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.photo_library,
              ),
              onPressed: () {
                getImage();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        height: ScreenUtil.screenHeight,
        child: TextField(
          decoration: InputDecoration(border: InputBorder.none),
          maxLines: null,
          controller: _controller,
        ),
      ),
    );
  }
}
