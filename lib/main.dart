import 'package:flutter/material.dart';
import 'package:reddit/fetch.dart';
import 'package:reddit/inpost.dart';

// final topBar = new AppBar(
//     backgroundColor: new Color(0xffe64a19),
//     centerTitle: true,
//     elevation: 1.0,
//     title: Text('Reddit'),
// );

final topBar = new SliverAppBar(
  expandedHeight: 150.0,
  flexibleSpace: const FlexibleSpaceBar(
    title: Text('Reddit'),
  ),
  actions: <Widget>[
    IconButton(
      icon: const Icon(Icons.add_circle),
      tooltip: 'Add new entry',
      onPressed: () { /* ... */ },
    ),
  ]
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // final topBar = new AppBar(
  //   backgroundColor: new Color(0xffe64a19),
  //   centerTitle: true,
  //   elevation: 1.0,
  //   title: Text('Reddit'),
  // );

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: topBar,
  //     body: new Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         Flexible(child: PostsList(posts: fetchPost(),),),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(child: PostsList(posts: fetchPost(),),),
          ],
        ),
        ),
      ),
    );
  }
}


class PostsList extends StatelessWidget {
  final Future<List<Post>> posts;
  PostsList({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: post_size,
      itemBuilder: (context, index) {
        return new Card(
          child: FutureBuilder<List<Post>>(
            future: posts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(children: <Widget>[
                            new Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage("http://t1.gstatic.com/images?q=tbn:ANd9GcThsotATP9ktYH_-oqNK6lYSI2USCxC-9nhbqScnKqvWFyxmL64")
                                )
                              ),
                            ),
                            new SizedBox(width: 10.0,),
                            new Text(
                              "u/" + snapshot.data[index].user,
                              style:TextStyle(fontWeight:FontWeight.bold)
                            ),
                            new Align(
                              alignment: Alignment.centerRight,
                              child: new IconButton(
                                icon: Icon(Icons.more_horiz),
                                onPressed: null,
                              ),
                            ),
                          ],)
                        ],
                      ),
                    ),

                    new Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                      child: new Text(
                        snapshot.data[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    ),
                    
                    Flexible(
                      fit:FlexFit.loose,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PostPage(permalink: snapshot.data[index].permalink, photo_url: snapshot.data[index].photo_url)),
                          );
                        },
                        child: new Image.network(
                        snapshot.data[index].photo_url,
                        fit:BoxFit.cover,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text(snapshot.data[index].score.toString(), style: TextStyle(color: new Color(0xffe64a19), fontWeight: FontWeight.bold),),
                              new Icon(Icons.favorite, color: new Color(0xffe64a19),),
                            ],
                          ),
                          new Container(),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text(snapshot.data[index].comments.toString(), style: TextStyle(color: new Color(0xffe64a19), fontWeight: FontWeight.bold),),
                              new IconButton(
                                icon: new Icon(Icons.mode_comment, color: new Color(0xffe64a19),),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PostPage(permalink: snapshot.data[index].permalink)),
                                  );
                                },
                              ),
                              // new GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(builder: (context) => PostPage()),
                              //     );
                              //   },
                              //   child: new Icon(Icons.mode_comment, color: new Color(0xffe64a19),),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        );
      },
    );
  }
}

// snapshot.data[index].title