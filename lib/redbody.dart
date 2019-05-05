import 'package:flutter/material.dart';
import 'package:reddit/redlist.dart';
import 'package:reddit/fetch.dart';

class RedBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(child: RedList(),)
      ],
    );
  }
}