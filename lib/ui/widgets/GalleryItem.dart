import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tested4u/utilities/size_service.dart';

class GalleryItem extends StatefulWidget {

  final String imageUrl;
  final String title;
  GalleryItem({
    @required this.imageUrl,
    @required this.title, DocumentSnapshot documentSnapshot,

  });

  @override
  _GalleryItemState createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  @override
  Widget build(BuildContext context) {
    initSizeConfigGlobal(context);
    return Padding(
      padding:  EdgeInsets.all(getSizeVerticallyScaled(10.0)),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: getSizeVerticallyScaled(150),
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: getSizeVerticallyScaled(10),),
            Text(widget.title.toString(),style: TextStyle(color: Colors.white,fontSize: getSizeVerticallyScaled(18),fontWeight: FontWeight.bold),)
          ],
        ),

      ),
    );
  }
}