

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:listview/model/member.dart';
import 'package:listview/resources/colors.dart';
import 'package:listview/resources/sizes.dart';
import 'package:listview/resources/text_styles.dart';
import 'package:listview/widgets/clipped_image.dart';
import 'package:listview/widgets/member_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:listview/myappbar.dart';
import 'package:listview/myflexiableappbar.dart';
import 'package:transparent_image/transparent_image.dart';

class TeamMembersPage extends StatelessWidget {
  var number;
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
            delegate: SliverChildBuilderDelegate((context,int index){
              return StreamBuilder (
                stream:Firestore.instance.collection('posts').snapshots(),
                builder: (context,snapshot) {
                  DocumentSnapshot mypost=snapshot.data.documents[index];
                  number = snapshot.data.documents.length;
                  if(!snapshot.hasData){
                    return Text('loading');
                  }
                  else{
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
                childCount:number
            ),

          )
          ////////////////////////////////////////
          ////////////////////////////////////////
          ////////////////////////////////////////
          ///////////////////////////////////////
          /* StreamBuilder (
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (context,snapshot){*/
          /* if(!snapshot.hasData){

        }
        else return SliverList(
          delegate: SliverChildBuilderDelegate((con,int index){
            DocumentSnapshot mypost=snapshot.data.documents[index];
            return Container(
              child: FadeInImage.memoryNetwork(
                  placeholder:kTransparentImage,
                  image: '${mypost['image']}',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,),
            );
          },childCount: snapshot.data.documents.length),
        );*/

          /*  if(snapshot.hasData){
           return SliverList(
            delegate: SliverChildBuilderDelegate((con,int index){
              DocumentSnapshot mypost=snapshot.data.documents[index];
              return Container(
                child: FadeInImage.memoryNetwork(
                  placeholder:kTransparentImage,
                  image: '${mypost['image']}',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,),
              );
            },childCount: snapshot.data.documents.length),
          );
        }
      },
    )*/
          /////////////////////////////////////////
          /////////////////////////////////////
          ///////////////////////////////////
        ],
      ),
            );
        }
  }
