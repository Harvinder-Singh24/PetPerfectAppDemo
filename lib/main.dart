import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petdemo/bloc/post_bloc.dart';
import 'package:petdemo/screens/dog_screen.dart';
import 'package:petdemo/services/post_service.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet Perfect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DogScreen());
  }
}
