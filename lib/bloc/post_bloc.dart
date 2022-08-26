import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/post_model.dart';
import '../repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetPostEvent) {
        emit(PostLoadingState());
        try {
          List<PostModel> lstPosts = await postRepository.getAllPost();
          emit(SucessState(data: lstPosts));
        } catch (e) {
          print(e);
          emit(ErrorState(errormessage: e.toString()));
        }
      }
    });
  }
}
