import 'package:flutter/material.dart';
import 'package:listview/myflexiableappbar.dart';
import 'package:listview/myappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());
var number;
var mypost;
class MyApp extends StatefulWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Search(),
      theme: ThemeData(
        accentColor: Colors.cyan[600],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class Search extends StatefulWidget {
  
  
  Search({Key key, this.title}) : super(key: key);

  final String title;


  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override void initState() {
    super.initState();
    print('init');
    StreamBuilder(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (context,snapshot){
        DocumentSnapshot mypost = snapshot.data;
        if(snapshot.hasData){
           print('no data');
        }
        else print('dataFound!');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              title: MyAppBar(),
              backgroundColor: Colors.white,
              pinned: true,
              expandedHeight: 280.0,
              flexibleSpace: FlexibleSpaceBar(
                background: MyFlexiableAppBar(),
              )
          ),

      /*    SliverList(
            delegate: SliverChildBuilderDelegate ((context,int index){
              return StreamBuilder (
                stream:Firestore.instance.collection('posts').snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  DocumentSnapshot mypost = snapshot.data.documents[index];
                  if(!snapshot.hasData){
                    return Container(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: '${mypost['image']}',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }
                },
              );
            },
                childCount:3
            ),

          )*/
        ],
      ),


    );
  }
}