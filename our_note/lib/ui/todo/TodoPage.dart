import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:our_note/common/DioFactory.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with AutomaticKeepAliveClientMixin {
  bool isComplete = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
  }

  getTodoList() async {
    Response response = await DioFactory.getDio()
        .get('http://d3collection.cn:6090/getTodoList/$page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: isComplete,
                      onChanged: (b) {
                        print('$b');
                        isComplete = b;
                        setState(() {});
                      }),
                  Text(
                    'Test',
                    style: TextStyle(fontSize: ScreenUtil().setSp(32)),
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
