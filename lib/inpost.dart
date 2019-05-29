import 'package:flutter/material.dart';
import 'package:reddit/fetch.dart';
import 'package:reddit/main.dart';

class PostPage extends StatelessWidget {
  final String permalink;
  final String photo_url;
  PostPage ({Key key, this.photo_url, this.permalink}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    print(permalink);
    print(photo_url);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 70.0,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Reddit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  ),
            ),
          ];
        },
        // body: SingleChildScrollView(
        //   child: new Column(

        //   ),
        // )
        body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Flexible(
          //   child: new Image.network(
          //     image,
          //     fit:BoxFit.cover,
          //   ),
          // ),
          // SingleChildScrollView(child: Image.network(photo_url),),
          Image.network(photo_url),
          Flexible(child: CommentList(comments:fetchComments(permalink)),)
        ],
      ),
      ),
    );

    // return Scaffold(
    //   appBar: topBar,
    //   body: new Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: <Widget>[
    //       Flexible(child: CommentList(comments:fetchComments(permalink)),)
    //     ],
    //   ),
    // );
  }
}

class CommentList extends StatelessWidget {
  final Future<List<Comment>> comments;
  CommentList ({Key key, this.comments}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: comment_size,
    //   itemBuilder: (context, index) {
    //     return Column(
    //       children: <Widget>[
    //         FutureBuilder<List<Comment>>(
    //         future: comments,
    //         builder: (context, snapshot){
    //           if(snapshot.hasData)
    //             return Card(
    //               child: new Text(snapshot.data[index].text),
    //             );
    //           return CircularProgressIndicator();
    //         },
    //       ),
    //     ], 
    //   );
    //   },
    // );
    return FutureBuilder<List<Comment>>(
          future: comments,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: comment_size,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: new EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: new Text(snapshot.data[index].points.toString() + ' points', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic), textAlign: TextAlign.center,),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: new Text(snapshot.data[index].text, style: TextStyle(fontSize: 17), textAlign: TextAlign.left),
                            )

                          ],
                        ),
                      )
                      
                    )
                    
                  );
                                    
                },
              );
            }
            return LinearProgressIndicator();
          },
        );
  }
}