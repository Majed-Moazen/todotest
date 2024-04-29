

class TodoData {
  int? id;
  int? userId;
  String? todo;
  bool? completed;
  static List<TodoData> data = [];
  static List<TodoData> temp= [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'todo': todo,
      'completed': completed,
    };
  }
  factory TodoData.fromJson(Map<String, dynamic> json) {
    return TodoData(
      id: json['id'],
      userId: json['userId'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }
    static void fetch_Temp(bool isCompleted) {
    temp = [];
    data.forEach((element) {
      if(element.completed==isCompleted) {
        temp.add(element);
      }
    });
  }
  static void fetchData(todoData) {
    data = [];
    todoData = todoData as List;
    TodoData _data = TodoData();
    todoData.forEach((element) {
        _data = TodoData(
          id: element["id"],
          userId: element["userId"],
          todo: element["todo"],
          completed: element["completed"],
        );
        data.add(_data);
    });
  }
  TodoData({
    this.id,
    this.userId,
    this.todo,
    this.completed,
  });
}
