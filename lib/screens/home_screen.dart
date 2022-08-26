import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SucessState) {
          return ListView.builder(itemBuilder: (context, index) {
            return Card(
                child: ListTile(
              title: Text(state.data[index].title ?? ""),
              subtitle: Text(state.data[index].body ?? ""),
            ));
          });
        } else if (state is ErrorState) {
          return Center(
            child: Text(state.errormessage),
          );
        }
        return Container();
      },
    ));
  }
}
