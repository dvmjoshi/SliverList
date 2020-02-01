


import 'package:flutter/material.dart';
import 'package:listview/model/member.dart';
import 'package:listview/resources/colors.dart';
import 'package:listview/resources/sizes.dart';
import 'package:listview/resources/text_styles.dart';
import 'package:listview/widgets/clipped_image.dart';
import 'package:listview/widgets/member_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamMembersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.keyboard_backspace, color: Colors.black),
        title: Text(
          "Our Team",
          style: appBarTextStyle,
        ),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder (
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (context,snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading..');
          }
          else
            return
              
                ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context,index){
                      DocumentSnapshot mypost=snapshot.data.documents[index];
                      return Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Material(
                                    elevation: 8,
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                    child: Column (children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 195.0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                        child: Image.network('${mypost['image']}',
                                          fit: BoxFit.fill,
                                        ),
                                      )
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.only(top: 0.0,right: 5.0,left: 5.0,bottom: 5.0),
                                        child: Column
                                          ( crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                          SizedBox(height: 10),
                                          Chip(
                                            label: Text('${mypost['title']}'),backgroundColor: Colors.blue.shade900,
                                            labelStyle: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold,color: Colors.white),
                                          ),
                                         Text('${mypost['subtitle']}'),
                                          SizedBox(height: 10.0),
                                          Text ('${mypost['title']}',
                                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                          )
                                        ],),
                                      ),
                               /*       Container(
                                        alignment: Alignment.topRight,
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height*.27,
                                          left: MediaQuery.of(context).size.height*.22,
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: CircleAvatar (
                                            backgroundColor: Colors.blue,
                                            child: Icon(Icons.share,color: Colors.white,size: 20.0,),
                                          ),
                                        ),
                                      )
*/
                                    ],),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            top: 50,
                            right: 25,
                            bottom: -25,
                            child: CircleAvatar (
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.share,color: Colors.white,size: 20.0,),
                            ),
                          )
                        ],
                      );
                    });


                 }),

            );
        }
  }
