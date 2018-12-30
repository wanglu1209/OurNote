import 'package:flutter/material.dart';
import 'package:our_note/ui/Note/NoteDetailPage.dart';

class NoteItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;

  NoteItemWidget(this.title, this.subtitle, this.index);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Test Title'),
      subtitle: Text('Test Subtitle\nSubtitle'),
      isThreeLine: true,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return NoteDetailPage('Test Title', 'Test Subtitle\nSubtitle');
        }));
      },
    );
  }
}
