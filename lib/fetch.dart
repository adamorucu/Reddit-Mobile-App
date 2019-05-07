import 'package:http/http.dart' as http;
import 'dart:convert';

int post_size = 10;

Future<List<Post>> fetchPost() async {
  final response = await http.get('https://www.reddit.com/r/memes/top.json');

  if(response.statusCode == 200) {
    List<Post> posts = new List(20);
    for (var i = 0; i < post_size; i++) {
      posts[i] = Post.fromJson(json.decode(response.body)['data']['children'][i]['data']);
    }
    return posts;
  } else {
    throw Exception('Failed to load the post');
  }
}

class Post {
  final String subreddit;
  final String user;
  final String title;
  final String url;
  final int score;
  final int comments;

  Post({this.subreddit, this.user, this.title, this. url, this.score, this.comments});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      subreddit: json['subreddit'],
      user: json['name'],
      title: json['title'],
      url: json['url'],
      score:  json['score'],
      comments:  json['num_comments'],
    );
  }
}