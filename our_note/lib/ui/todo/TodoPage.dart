import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:our_note/common/DioFactory.dart';
import 'package:our_note/models/Todo.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  bool isComplete = false;
  int page = 1;
  List<TodoData> todoData;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    getTodoList();
  }

  getTodoList() async {
    Response response = await DioFactory.getDio()
        .get('http://d3collection.cn:6090/getTodoList/$page/0');
    todoData = Todo.fromJson(response.data).data;
    setState(() {});
  }

  changeTodoStatus(int id, int status) {
    FormData formData = FormData.from({"id": id, 'status': status});
    DioFactory.getDio()
        .post('http://d3collection.cn:6090/changeTodoStatus', data: formData);
  }

  addNewTodo(String content) {
    FormData formData = FormData.from({'content': content});
    DioFactory.getDio()
        .post('http://d3collection.cn:6090/addNewTodo', data: formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              TodoData data = TodoData(id: -1);
              todoData.add(data);
              setState(() {
                FocusScope.of(context).requestFocus(_focusNode);
              });
            }),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            AnimatedList(
                initialItemCount: 3,
                itemBuilder: (context, index, animation) {
                  bool isComplete = todoData[index].status == 1 ? true : false;
                  Widget widget;
                  // 如果id == -1 那么则是新增一条
                  if (todoData[index].id == -1) {
                    widget = Expanded(
                        child: TextField(
                      focusNode: _focusNode,
                      decoration: InputDecoration(border: InputBorder.none),
                      onSubmitted: (s) {
                        _focusNode.dispose();
                        addNewTodo(s);
                        getTodoList();
                      },
                      textInputAction: TextInputAction.done,
                    ));
                  } else {
                    widget = Text(
                      todoData[index].content ?? "",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(36),
                          color: isComplete ? Colors.grey : Colors.black,
                          decoration:
                              isComplete ? TextDecoration.lineThrough : null),
                    );
                  }
                  return ListTile(
                    key: Key(todoData[index].id.toString()),
                    leading: Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: isComplete,
                        onChanged: (b) {
                          todoData[index].status = b ? 1 : 0;

                          if (b) todoData.removeAt(index);

                          setState(() {});
                          changeTodoStatus(
                              todoData[index].id, todoData[index].status);
                        }),
                    title: widget,
                  );
                }),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 30),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                colorBrightness: Brightness.dark,
                onPressed: () {},
                child: Text(
                  '回收站',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
            )
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
