import '../model/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getAllPost();
}
