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
  TextEditingController _editingController;
  FocusNode _focusNode;
  bool isShowEdit = false;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _focusNode = FocusNode();
    getTodoList();
  }

  getTodoList() async {
    Response response = await DioFactory.getDio()
        .get('http://d3collection.cn:6090/getTodoList/$page');
    todoData = Todo.fromJson(response.data).data;
    setState(() {});
  }

  changeTodoStatus(int id, int status) {
    FormData formData = FormData.from({"id": id, 'status': status});
    DioFactory.getDio()
        .post('http://d3collection.cn:6090/changeTodoStatus', data: formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              isShowEdit = !isShowEdit;
              FocusScope.of(context).requestFocus(_focusNode);
            }),
        backgroundColor: Colors.white,
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: todoData == null ? 0 : todoData.length,
                    itemBuilder: (context, index) {
                      bool isComplete =
                          todoData[index].status == 1 ? true : false;
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                value: isComplete,
                                onChanged: (b) {
                                  todoData[index].status = b ? 1 : 0;
                                  setState(() {});
                                  changeTodoStatus(todoData[index].id,
                                      todoData[index].status);
                                }),
                            Text(
                              todoData[index].content,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(36),
                                  decoration: isComplete
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                          ],
                        ),
                      );
                    })),
            Offstage(
                offstage: !isShowEdit,
                child: SingleChildScrollView(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _editingController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ))
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
