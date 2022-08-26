import 'package:petdemo/model/post_model.dart';
import 'package:http/http.dart' as http;
import '../repository/post_repository.dart';
import 'dart:convert';

class PostService implements PostRepository {
  @override
  Future<List<PostModel>> getAllPost() async {
    var url = Uri.parse('http://jsonplaceholder.typicode.com/posts');
    http.Response response = await http.get(url);
    List lstPost = json.decode(response.body);
    List<PostModel> posts =
        lstPost.map((post) => PostModel.fromJson(post)).toList();
    return posts;
  }
}
