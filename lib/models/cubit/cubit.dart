import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotest/models/cach_helper.dart';
import 'package:todotest/models/cubit/statues.dart';
import 'package:todotest/repositories/todo_data.dart';

import '../../repositories/api.dart';

class MyCubit extends Cubit<classState> {
  MyCubit() : super(InitState());

  static MyCubit get(context) => BlocProvider.of(context);
  bool obSec = true;

  passHideShow() {
    obSec = !obSec;
    emit(ChangObSecState());
  }

  //-------------------
  var items = [
    DropdownMenuItem(child: Text('10'), value: 10),
  ];
  int indexScreen = 0;

  void ChgIndexScreenHome(int index) {
    indexScreen = index;
    TodoData.fetch_Temp(index == 0 ? true : false);
    emit(ChgIndexScreenHomeState());
  }

  //-------------------
  void getTotalTodos() {
    API.dio
        .get('/todos/user/${ChachHelper.getDataList(
      key: 'userdata',
    )[0]}')
        .then((getTotal) {
      items = [
        DropdownMenuItem(child: Text('10'), value: 10),
      ];
      for (int i = 20; i < (getTotal.data['total'] + 10); i += 10) {
        items.add(DropdownMenuItem(
          child: Text('${i - 10} -${i} '),
          value: i,
        ));
      }
      TodoData.fetchData(getTotal.data['todos']);
      List<Map<String, dynamic>> datatoMap =
          TodoData.data.map((todo) => todo.toJson()).toList();
      String todoJsonString = json.encode(datatoMap);
      ChachHelper.setDataString(key: 'todos', value: todoJsonString);
      ChgIndexScreenHome(0);
      chLoadHome(true);
    }).catchError((e) {
      print(e);
    });
  }

  //-------------------

  bool load = false;

  void chLoadHome(isLoad) {
    load = isLoad;
    emit(ChgLoadHomeState());
  }
//-------------------
}
