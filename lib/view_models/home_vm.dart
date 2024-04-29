import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todotest/models/cubit/cubit.dart';

import '../main.dart';
import '../models/cach_helper.dart';
import '../repositories/api.dart';
import '../repositories/todo_data.dart';

class HomeVm {
  MyCubit _cubit = MyCubit();

  HomeVm(myCubit) {
    _cubit = myCubit;
  }

  viewTodo(int skip) {
    _cubit.chLoadHome(false);
    API.dio.get('/todos/user/${ChachHelper.getDataList(
      key: 'userdata',
    )[0]}?limit=10&skip=$skip').then((todos) {
      TodoData.fetchData(todos.data['todos']);
      _cubit.ChgIndexScreenHome(_cubit.indexScreen);
      _cubit.chLoadHome(true);
    }).catchError((e) {
      print(e);
    });
  }

  void deleteTask(int indexDataList) {
    API.dio.delete('/todos/${TodoData.temp[indexDataList].id}').then(
      (value) {
        TodoData.data.remove(TodoData.temp[indexDataList]);
        print('deleted');
        _cubit.ChgIndexScreenHome(_cubit.indexScreen);
      },
    ).catchError((e) {
      TodoData.data.remove(TodoData.temp[indexDataList]);
      _cubit.ChgIndexScreenHome(_cubit.indexScreen);
    });
  }

  void completeTask(int index) {
    API.dio.put('/todos/${TodoData.temp[index].id}', data: {
      "completed": "true",
    }).then(
      (value) {
        TodoData.data[TodoData.data.indexOf(TodoData.temp[index])].completed =true;
        _cubit.ChgIndexScreenHome(_cubit.indexScreen);
      },
    ).catchError((e){
      TodoData.data[TodoData.data.indexOf(TodoData.temp[index])].completed =true;
      _cubit.ChgIndexScreenHome(_cubit.indexScreen);
    });
  }

  Widget todo(int index) {
    return Slidable(
      closeOnScroll: false,
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {
          deleteTask(index);
        }),
        children: [
          SlidableAction(
            onPressed: (e) {
              deleteTask(index);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: TodoData.temp[index].completed == false
          ? ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(onDismissed: () {
                completeTask(index);
              }),
              children: [
                SlidableAction(
                  onPressed: (e) {
                    completeTask(index);
                  },
                  backgroundColor: const Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.check_circle,
                  label: 'Completed',
                ),
              ],
            )
          : null,
      child: Container(
        margin: EdgeInsetsDirectional.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 1, offset: Offset(1, 1))
          ],
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        height: MyApp.height(10),
        child: Center(
          child: Text(
            TodoData.temp[index].todo.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
