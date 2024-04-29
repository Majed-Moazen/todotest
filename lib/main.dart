import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotest/repositories/api.dart';
import 'package:todotest/views/home.dart';
import 'package:todotest/views/login.dart';
import 'models/cach_helper.dart';
import 'models/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await API.init();
  await ChachHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static MediaQueryData _mediaQueryData = const MediaQueryData();

  static double height(int percent) =>
      ((_mediaQueryData.size.height * percent) / 100);

  static double width(int percent) =>
      ((_mediaQueryData.size.height * percent) / 100);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    return BlocProvider(
      create: (BuildContext context) => MyCubit(),
      child: MaterialApp(
        title: 'Task Manager App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ChachHelper.sharedpreferences?.containsKey('userdata') == true
            ? const Home()
            : const Login(),
      ),
    );
  }
}
