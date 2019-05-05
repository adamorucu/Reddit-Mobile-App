import 'package:flutter/material.dart';
import 'package:reddit/redbody.dart';

class HomePage extends StatelessWidget {
  final topBar = new AppBar(
    backgroundColor: new Color(0xffe64a19),
    centerTitle: true,
    elevation: 1.0,
    title: Text("Reddit"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar,
      body: new RedBody()
    );
  }
}