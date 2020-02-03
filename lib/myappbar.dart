import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyAppBar extends StatelessWidget {

  final double barHeight = 66.0;

  const MyAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.donut_large,color: Colors.black,),
          Container(width: 20.0),
          Text('HelloWorld',
          style: TextStyle(
              fontFamily: 'Opensans',
              color: Colors.grey,
              fontSize: 25.0)),
        ],
      ),
    );
  }
}