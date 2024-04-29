import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:todotest/models/cach_helper.dart';
import 'package:todotest/repositories/todo_data.dart';
import 'package:todotest/view_models/home_vm.dart';
import '../models/cubit/cubit.dart';
import '../models/cubit/statues.dart';
import '../repositories/api.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);

  TextEditingController newTask = TextEditingController();

  @override
  void initState() {
    super.initState();
    InternetConnection().hasInternetAccess.then((isInternet) {

      if (isInternet == true) {
        MyCubit.get(context).getTotalTodos();

      } else {
        String? todoJsonString = ChachHelper.getData(key: 'todos');
        if (todoJsonString != null) {
          List<dynamic> todoMapList = json.decode(todoJsonString);
          List<TodoData> restoredTodoList = todoMapList.map((todoMap) =>
              TodoData.fromJson(todoMap)).toList();
          TodoData.data=restoredTodoList;
        }
        MyCubit.get(context).ChgIndexScreenHome(0);
        MyCubit.get(context).chLoadHome(true);

      }
    });

}

dynamic selecetedItem;

@override
Widget build(BuildContext context) {
  return BlocConsumer<MyCubit, classState>(
    builder: (BuildContext context, classState state) {
      MyCubit _cubit = MyCubit.get(context);
      HomeVm _homeVm = HomeVm(_cubit);

      return Scaffold(
        appBar: AppBar(title: Text('My Task '), actions: [
          DropdownButton(
              value: selecetedItem,
              items: _cubit.items,
              onChanged: (item) {
                setState(() {
                  selecetedItem = item;
                  _homeVm
                      .viewTodo(selecetedItem <= 10 ? 0 : selecetedItem - 10);
                });
              })
        ]),
        body: _cubit.load
            ? ListView.builder(
            itemBuilder: (context, index) {
              return _homeVm.todo(index);
            },
            itemCount: TodoData.temp.length)
            : Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: IconButton(
          iconSize: 35,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.deepPurpleAccent.shade200)),
          color: Colors.white,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: newTask,
                        decoration: InputDecoration(hintText: 'Add new task'),
                        maxLines: 1,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          API.post('/todos/add', {
                            'todo': newTask.text,
                            'completed': 'false',
                            'userId':
                            ChachHelper.getDataList(key: 'userdata')[0]
                                .toString(),
                          }).then((value) {
                            TodoData data = TodoData(
                              todo: value!.data['todo'],
                              userId:
                              int.parse(value.data['userId'].toString()),
                              completed: bool.parse(value.data['completed']),
                              id: int.parse(value.data['id'].toString()),
                            );
                            setState(() {
                              TodoData.data.add(data);
                              _cubit.ChgIndexScreenHome(1);
                            });
                            Navigator.pop(context);
                          }).catchError((e) {
                            print('ee $e');
                          });
                        },
                        child: Text('Add'))
                  ],
                );
              },
            );
          },
          icon: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (indexItem) {
              setState(() {
                _cubit.ChgIndexScreenHome(indexItem);
              });
            },
            currentIndex: _cubit.indexScreen,
            elevation: 20,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.check), label: "completed"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.hourglass_empty_rounded),
                  label: "waiting"),
            ]),
      );
    },
    listener: (BuildContext context, classState state) {},
  );
}}
