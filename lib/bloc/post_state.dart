part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class SucessState extends PostState {
  final List<PostModel> data;

  SucessState({required this.data});
}

class ErrorState extends PostState {
  final String errormessage;

  ErrorState({required this.errormessage});
}
