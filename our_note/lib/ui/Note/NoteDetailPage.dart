import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:our_note/common/DioFactory.dart';
import 'package:our_note/models/Note.dart';
import 'package:our_note/utils/Utils.dart';

class NoteDetailPage extends StatefulWidget {
  final Data note;

  NoteDetailPage(this.note);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  TextEditingController _controller;
  bool isAddingNewNote = false;

  /// 更新内容
  updateNoteContent(String title, String content) {
    FormData formData = FormData.from(
        {"id": widget.note.id, "title": title, 'content': content});

    DioFactory.getDio()
        .post('http://d3collection.cn:6090/updateNoteContent', data: formData);
  }

  addNewNote(String title, String content) async {
    isAddingNewNote = true;
    FormData formData = FormData.from({"title": title, 'content': content});

    Response response = await DioFactory.getDio()
        .post('http://d3collection.cn:6090/addNote', data: formData)
        .whenComplete(() => isAddingNewNote = false);
    print('id = ${response.data['data']['id']}');

    widget.note.id = response.data['data']['id'];
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    var text = "";
    if (widget.note.title != null) text += widget.note.title;
    if (widget.note.content != null) text += '\n${widget.note.content}';
    _controller = TextEditingController(text: text);
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
            String title;
            String content;
            if (s.contains('\n')) {
              title = s.substring(0, s.indexOf('\n'));
              content = s.substring(s.indexOf('\n') + 1);
            } else {
              title = s;
            }
            widget.note.title = title;
            widget.note.content = content;
            if (widget.note.id == -1) {
              if (!isAddingNewNote) addNewNote(title, content);
            } else
              updateNoteContent(title, content);
            // 通过EventBus把更改过的数据发送出去
            Utils.getEventBus().fire(widget.note);
          },
        ),
      ),
    );
  }
}
