
import 'dart:async';
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
              ListView.separated(
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snapshot.data.documents[index];
                  print('${mypost['title']}');
                 return Row(
                    children: <Widget>[
                      Material(
                        elevation: size_8,
                        borderRadius: BorderRadius.all(
                            Radius.circular(size_12)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(size_12)),
                          child: Image.network(
                            '${mypost['image']}',
                            height: 100,
                            width: 80,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      SizedBox(width: size_20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(text: '${mypost['title']}'
                                .toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size_20,
                                  fontWeight: FontWeight.w900,
                                )),
                          ),
                          SizedBox(height: size_8),
                          Text('${mypost['subtitle']}',
                            style: TextStyle
                              (
                              color: blueColor,
                              fontSize: size_12,
                              fontWeight: FontWeight.w800,
                            ),)
                        ],
                      )
                    ],
                  );
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Material(
                color: Colors.white,
                elevation: 14.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196f3),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      width: 350,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(24.0),
                        child: Image(
                          fit: BoxFit.contain,
                          alignment: Alignment.topCenter,
                          image: NetworkImage('${mypost['image']}'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
                },
                separatorBuilder: (context, index) {
                 return SizedBox(
                    height: size_40,
                  );
                }, itemCount: snapshot.data.documents.length,);
                 }),

            );
        }
  }
