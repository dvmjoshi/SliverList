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
          if(!snapshot.hasData){
            const Text('Loading..');
          }
          else
            return Row (
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 10,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context,index) {
                        DocumentSnapshot mypost=snapshot.data.documents[index];
                        Row (
                          children: <Widget>[
                            Material(
                              elevation: size_8,
                              borderRadius: BorderRadius.all(Radius.circular(size_12)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(size_12)),
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
                                  text: TextSpan(text: '${mypost['title']}'.toUpperCase(),
                                      style: TextStyle (
                                        color: Colors.black,
                                        fontSize: size_20,
                                        fontWeight: FontWeight.w900,
                                      ) ),
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
                      },
                      separatorBuilder: (context,index) {
                        SizedBox(
                          height: size_20,
                        );
                      }, itemCount: snapshot.data.documents.length,)
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            );
        },
      )
    );
  }
}
