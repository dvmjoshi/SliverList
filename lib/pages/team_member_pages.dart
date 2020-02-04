

import 'package:flutter/material.dart';
import 'package:listview/myflexiableappbar.dart';
import 'package:listview/myappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());
var number;
var mypost;
class MyApp extends StatelessWidget {
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
}

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);



  final String title;


  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future _data;
  Future getsData()async{
    var firestore =Firestore.instance;
    QuerySnapshot qn=await firestore.collection("posts").getDocuments();
    return qn.documents;
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      _data=getsData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
          SliverList(
            delegate: SliverChildBuilderDelegate ((context,int index){ // we need argument snapshot in sliver child
              return FutureBuilder (
                future:_data,
                childCount:3
                builder: (_, snapshot) {
                 // DocumentSnapshot mypost = snapshot.data.documents[index];
                  if(snapshot.hasData){
                    return Container(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: '${snapshot.data[index].data["images"]}',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }
                },
              );
            },

                
             /* childCount: 3*/
            ),

          )
        ],
      ),

    );
  }
}
