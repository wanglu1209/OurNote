import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:our_note/common/DioFactory.dart';
import 'package:our_note/models/Note.dart';
import 'package:our_note/ui/Note/NoteItemWidget.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  List<Data> data;
  int page = 1;

  @override
  void initState() {
    super.initState();
    requestNoteList();
  }

  /// 获取备忘录列表
  requestNoteList() async {
    Response response = await DioFactory.getDio()
        .get('http://d3collection.cn:6090/getNoteList/$page');
    Note data = Note.fromJson(response.data);
    this.data = data.data;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (data == null) {
      body = Center(
        child: SpinKitPumpingHeart(
          color: Theme.of(context).primaryColor,
        ),
      );
    } else {
      body = Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: data != null ? data.length : 0,
            itemBuilder: (context, index) {
              return Dismissible(
                  onDismissed: (direction) {
                    data.removeAt(index);
                    print(data.toString());
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('删除了第$index个item'),
                      action: SnackBarAction(label: '撤回', onPressed: () {}),
                    ));
                    setState(() {});
                  },
                  background: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: ListTile(
                        leading: Icon(Icons.delete,
                            color: Colors.white, size: 36.0)),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: ListTile(
                        trailing: Icon(Icons.delete,
                            color: Colors.white, size: 36.0)),
                  ),
                  key: Key(data[index].id.toString()),
                  child: NoteItemWidget(data[index]));
            }),
      );
    }
    return Scaffold(body: body);
  }
}
