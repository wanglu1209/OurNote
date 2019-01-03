import 'package:flutter/material.dart';
import 'package:our_note/models/Note.dart';
import 'package:our_note/ui/Note/NoteDetailPage.dart';

class NoteItemWidget extends StatelessWidget {
  final Data data;
  NoteItemWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title),
      subtitle: Text(
        data.content,
        maxLines: 3,
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NoteDetailPage(data);
        }));
      },
    );
  }
}
