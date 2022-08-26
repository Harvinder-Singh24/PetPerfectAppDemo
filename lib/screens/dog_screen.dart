import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:petdemo/screens/home_screen.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';

import '../bloc/post_bloc.dart';
import '../services/post_service.dart';

class DogScreen extends StatefulWidget {
  DogScreen({Key? key}) : super(key: key);

  @override
  State<DogScreen> createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  bool ismp4 = false;
  late Future<void> _initalizeVideoPlayerFuture;
  late VideoPlayerController _controller;

  Future fetchimage() async {
    var url = Uri.parse('https://random.dog/woof.json');
    http.Response response = await http.get(url);
    var jsonResponse = json.decode(response.body);
    print('url fetched ${jsonResponse['url']}');
    String fetchformat = jsonResponse['url']
        .substring(jsonResponse['url'].length - 3, jsonResponse['url'].length);
    print("Format of image ${fetchformat}");
    fetchformat == 'mp4' ? ismp4 = true : ismp4 = false;
    return jsonResponse['url'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: fetchimage(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.data}'));
            }
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ismp4
                      ? const Center(child: Text('Problem in Loading Video'))
                      : SizedBox(
                          child: Image.network(
                            '${snapshot.data}',
                            width: 300,
                            height: 300,
                          ),
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                    create: (context) =>
                                        PostBloc(postRepository: PostService())
                                          ..add(GetPostEvent()),
                                    child: HomeScreen())));
                      },
                      child: const Icon(Icons.arrow_right))
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
