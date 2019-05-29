import 'package:http/http.dart' as http;
import 'dart:convert';

int post_size = 20;
int comment_size = 30;

Future<List<Post>> fetchPost() async {

  final response = await http.get('https://www.reddit.com/r/memes/top.json?limit=' + post_size.toString());
  if(response.statusCode == 200) {
    List<Post> posts = new List(post_size);
    for (var i = 0; i < post_size; i++) {
      posts[i] = Post.fromJson(json.decode(response.body)['data']['children'][i]['data']);
    }
    return posts;
  } else {
    throw Exception('Failed to load the post');
  }
}

Future<List<Comment>> fetchComments(String permalink) async{
  print(permalink);
  final String url = 'https://www.reddit.com/r/memes/comments/' + permalink + '.json';
  print(url);
  final response2 = await http.get(url);
  print(response2.statusCode);
  if(response2.statusCode == 200) {
    List<Comment> comments = new List(comment_size);
    for (var i=0; i < comment_size; i++){
      comments[i] = Comment.fromJson(json.decode(response2.body)[1]['data']['children'][i]['data']);
    }
    
    return comments;
   } else {
     throw Exception('Failed to load the comments');
   }
  
}

class Post {
  final String subreddit;
  final String user;
  final String title;
  final String photo_url;
  final String permalink;
  final int score;
  final int comments;

  Post({this.subreddit, this.user, this.title, this. photo_url, this.permalink, this.score, this.comments});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      subreddit: json['subreddit'],
      user: json['name'],
      title: json['title'],
      photo_url: json['url'],
      permalink: json['id'],
      score:  json['score'],
      comments:  json['num_comments'],
    );
  }
}

class Comment {
  final String user;
  final String text;
  final int points;
  // final Comment subcomment;
  
  Comment({this.user, this.text, this.points});

  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
      user: json['name'],
      text: json['body'],
      points: json['ups'],
    );
  }
}