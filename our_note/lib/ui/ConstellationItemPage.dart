import 'package:flutter/material.dart';
import 'package:our_note/custom_view/GradientInstrumentPanel.dart';

class ConstellationItemPage extends StatefulWidget {
  final String title;
  final double progress;

  ConstellationItemPage({@required this.title, @required this.progress});

  @override
  _ConstellationItemPageState createState() => _ConstellationItemPageState();
}

class _ConstellationItemPageState extends State<ConstellationItemPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 40.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 28.0),
          ),
        ),
        GradientInstrumentPanel(
          progress: widget.progress,
        ),
      ],
    );
  }
}
