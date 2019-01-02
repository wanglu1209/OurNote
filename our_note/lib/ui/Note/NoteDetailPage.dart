import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:our_note/common/DioFactory.dart';
import 'package:our_note/models/Note.dart';

class NoteDetailPage extends StatefulWidget {
  final Data note;

  NoteDetailPage(this.note);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  TextEditingController _controller;

  /// 获取备忘录列表
  updateNoteContent(String title, String content) {
    FormData formData = FormData.from(
        {"id": widget.note.id, "title": title, 'content': content});

    DioFactory.getDio()
        .post('http://d3collection.cn:6090/updateNoteContent', data: formData);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: '${widget.note.title}\n${widget.note.content}');
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
          onChanged: (s) {
            String title = s.substring(0, s.indexOf('\n'));
            String content = s.substring(s.indexOf('\n') + 1);
            updateNoteContent(title, content);
          },
        ),
      ),
    );
  }
}
