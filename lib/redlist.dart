import 'package:flutter/material.dart';

class RedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
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
                      "u/username",
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
                "This is the title",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),

            Flexible(
              fit:FlexFit.loose,
              child: new Image.network(
                "https://i.redd.it/h0qt908mc8u21.jpg",
                fit:BoxFit.cover,
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
                      new Text("1.2k", style: TextStyle(color: new Color(0xffe64a19), fontWeight: FontWeight.bold),),
                      new Icon(Icons.favorite, color: new Color(0xffe64a19),),
                    ],
                  ),
                  new Container(),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("302", style: TextStyle(color: new Color(0xffe64a19), fontWeight: FontWeight.bold),),
                      new Icon(Icons.mode_comment, color: new Color(0xffe64a19),),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      } 
    );
  }
}

// new SizedBox(width: 16.0,),
// new Icon(Icons.mode_comment, color: Colors.orangeAccent)