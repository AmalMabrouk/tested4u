import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:tested4u/bloc/FirstScreenBloc.dart';
import 'package:tested4u/ui/MapScreen.dart';
import 'package:tested4u/utilities/size_service.dart';
import 'widgets/GalleryItem.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initSizeConfigGlobal(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore File Upload'),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg3.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: StreamBuilder<bool>(
              stream: firstscreenbloc.isLoadingresult,
              builder: (context, snapshot2) {
                return StreamBuilder<File>(
                    stream: firstscreenbloc.image,
                    builder: (context, snapshot) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  StreamBuilder<File>(
                                      stream: firstscreenbloc.image,
                                      builder: (context, snapshot) {
                                        return Column(
                                          children: <Widget>[
                                            Text(
                                              'Selected Image',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      getSizeVerticallyScaled(
                                                          14)),
                                            ),
                                            snapshot.data != null
                                                ? Image.file(
                                                    snapshot.data,
                                                    // height: 150,
                                                    height:
                                                        getSizeVerticallyScaled(
                                                            150),
                                                    width:
                                                        getSizeVerticallyScaled(
                                                            150),
                                                  )
                                                : Container(
                                                    child: Center(
                                                      child:  Image.asset(
                                        'assets/gallery.png',

                                        height: getSizeVerticallyScaled(150),
                                        width: getSizeVerticallyScaled(150),
                                                        color: Colors.white,
                                        )),

                                                    height:
                                                        getSizeVerticallyScaled(
                                                            150),
                                                  ),
                                          ],
                                        );
                                      }),
                                  StreamBuilder<String>(
                                      stream: firstscreenbloc.imageUrl,
                                      builder: (context, snapshot1) {
                                        return Column(
                                          children: <Widget>[
                                            Text(
                                              'Uploaded Image',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      getSizeVerticallyScaled(
                                                          14)),
                                            ),
                                            snapshot1.data != null
                                                ? Image.network(
                                                    snapshot1.data,
                                                    height:
                                                        getSizeVerticallyScaled(
                                                            150),
                                                    width:
                                                        getSizeVerticallyScaled(
                                                            150),
                                                  )
                                                : Container(
                                                    child: Center(
                                                      child: Image.asset(
                                                        'assets/gallery.png',

                                                        height: getSizeVerticallyScaled(150),
                                                        width: getSizeVerticallyScaled(150),
                                                        color: Colors.white,
                                                      )
                                                    ),
                                                    height:
                                                        getSizeVerticallyScaled(
                                                            150),
                                                  ),
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                          snapshot.data != null
                              ? firstscreenbloc.isLoading
                                  ? CircularProgressIndicator()
                                  : Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: getSizeVerticallyScaled(10),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            // borderRadius: BorderRadius.circular(30.0),
                                            border: Border.all(
                                              color: Colors.pinkAccent,
                                              width: 1,
                                            ),
                                          ),
                                          height: getSizeVerticallyScaled(50.0),
                                          width: getSizeVerticallyScaled(150),
                                          child: StreamBuilder(
                                              builder: (context, snapshot) {
                                            return TextField(
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'OpenSans',
                                              ),
                                              controller: title,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            getSizeVerticallyScaled(
                                                                10)),
                                                hintText: "Titre",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize:
                                                        getSizeVerticallyScaled(
                                                            16)),
                                              ),
                                            );
                                          }),
                                        ),
                                        RaisedButton(
                                          child: Text(
                                            'Upload Image',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            firstscreenbloc
                                                .uploadFile(title.text);
                                            //uploadingData();
                                          },
                                          color: Colors.pink,
                                        )
                                      ],
                                    )
                              : Container(),
                          SizedBox(
                            height: getSizeVerticallyScaled(10),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[


                              RaisedButton(
                                child: Text(
                                  'Gallery',
                                  style:
                                  TextStyle(color: Colors.white),
                                ),

                                color: Colors.pink,
                              ),
                              SizedBox(width:getSizeVerticallyScaled(20) ,),
                              RaisedButton(
                                child: Text(
                                  'Map',
                                  style:
                                  TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MapScreen();
                                      },
                                    ),
                                  );
                                  //uploadingData();
                                },
                                color: Colors.pink,
                              )
                            ],
                          ),
                          SizedBox(
                            height: getSizeVerticallyScaled(10),
                          ),
                          StreamBuilder(
                            stream: Firestore.instance
                                .collection("tested")
                                .snapshots(),
                            builder: (context, snapshot) {
                              return !snapshot.hasData
                                  ? Text('PLease Wait')
                                  : new Expanded(
                                      child: GridView.builder(
                                      itemCount: snapshot.data.documents.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot products =
                                            snapshot.data.documents[index];
                                        return GalleryItem(
                                          documentSnapshot: products,
                                          imageUrl: products.data()["url"],
                                          title: products.data()["title"],
                                        );
                                      },
                                    ));
                            },
                          ),
                        ],
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firstscreenbloc.chooseFile();
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
