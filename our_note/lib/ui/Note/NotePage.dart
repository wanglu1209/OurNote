import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:our_note/common/DioFactory.dart';
import 'package:our_note/models/Note.dart';
import 'package:our_note/ui/Note/NoteDetailPage.dart';
import 'package:our_note/ui/Note/NoteItemWidget.dart';
import 'package:our_note/utils/Utils.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage>
    with AutomaticKeepAliveClientMixin {
  List<Data> data;
  int page = 1;

  @override
  void initState() {
    super.initState();
    requestNoteList();

    Utils.getEventBus().on<Data>().listen((d) {
      if (data.map((it) => it.id).toList().contains(d.id)) {
        data.forEach((da) {
          if (da.id == d.id) {
            da.content = d.content;
            da.title = d.title;
            setState(() {});
          }
        });
      } else {
        requestNoteList();
      }
    });
  }

  /// 获取备忘录列表
  requestNoteList() async {
    Response response = await DioFactory.getDio()
        .get('http://d3collection.cn:6090/getNoteList/$page');
    Note data = Note.fromJson(response.data);
    this.data = data.data;

    if (mounted) setState(() {});
  }

  deleteNote(int id) async {
    DioFactory.getDio().get('http://d3collection.cn:6090/deleteNote/$id');
  }

  undoDeleteNote(int id) async {
    DioFactory.getDio().get('http://d3collection.cn:6090/undoDeleteNote/$id');
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
                    deleteNote(data[index].id);
                    var d = data.removeAt(index);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('删除成功'),
                      action: SnackBarAction(
                          label: '撤回',
                          onPressed: () {
                            undoDeleteNote(data[index].id);
                            data.insert(index, d);
                            setState(() {});
                          }),
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
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return NoteDetailPage(Data(id: -1));
              }));
            }),
        body: body);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
