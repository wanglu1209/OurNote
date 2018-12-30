import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;

  NoteDetailPage(this.title, this.subtitle);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
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
                print('点击了more');
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
