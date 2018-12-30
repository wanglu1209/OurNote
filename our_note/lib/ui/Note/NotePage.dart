import 'package:flutter/material.dart';
import 'package:our_note/ui/Note/NoteItemWidget.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Dismissible(
                onDismissed: (direction) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('删除了第$index个item'),
                    action: SnackBarAction(label: '撤回', onPressed: () {}),
                  ));
                },
                background: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: ListTile(
                      leading:
                          Icon(Icons.delete, color: Colors.white, size: 36.0)),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: ListTile(
                      trailing:
                          Icon(Icons.delete, color: Colors.white, size: 36.0)),
                ),
                key: Key(index.toString()),
                child: NoteItemWidget(
                    'Test Title', 'Test Subtitle\nSubtitle', index));
          }),
    ));
  }
}
