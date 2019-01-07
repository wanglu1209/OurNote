class Todo {
  List<TodoData> data;
  int errorCode;

  Todo({this.data, this.errorCode});

  Todo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TodoData>();
      json['data'].forEach((v) {
        data.add(new TodoData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    return data;
  }
}

class TodoData {
  String content;
  int id;
  int status;

  TodoData({this.content, this.id, this.status});

  TodoData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}
