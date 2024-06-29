import 'dart:convert';
import 'dart:developer';

import 'package:bloc_with_api/data/post_model.dart';
import 'package:http/http.dart' as http;

class PostApi {
  static Future<List<PostModel>> getPostApi() async {
    try {
      final res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      if (res.statusCode == 200) {
        final List<dynamic> parsed = jsonDecode(res.body);
        final postData = parsed
            .map(
              (post) => PostModel.fromJson(post as Map<String, dynamic>),
            )
            .toList();
        return postData;
      } else {
        log('Status Code is not 200');
      }
    } catch (e) {
      log('Catch Error: $e');
      throw Exception(e.toString());
    }
    return [];
  }
}
