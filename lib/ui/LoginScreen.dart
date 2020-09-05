import 'package:flutter/material.dart';
import 'package:tested4u/utilities/size_service.dart';
import 'file:///E:/tested4u/lib/utilities/sign_in.dart';

import 'FirstScreen.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    initSizeConfigGlobal(context);
    return Scaffold(
      body: Container( decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/bg3.jpg"),
    fit: BoxFit.cover,
    ),
    ),

     child: Container(
        //color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: new EdgeInsets.symmetric(vertical: getSizeVerticallyScaled(100.0)),
                  child: Image.asset(
                'assets/google.png',
                height: getSizeVerticallyScaled(150),
                width: getSizeVerticallyScaled(150),
              )),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return MyHomePage();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      color: Colors.white,
      borderSide: BorderSide(color: Colors.grey),
      child: Container(child: Padding(

        padding:  EdgeInsets.fromLTRB(getSizeVerticallyScaled(0), getSizeVerticallyScaled(10), getSizeVerticallyScaled(0), getSizeVerticallyScaled(10)),
        child: Row(

          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

           // Image(image: AssetImage("assets/google.png"), height: 35.0),
            Padding(
              padding:  EdgeInsets.only(left: getSizeVerticallyScaled(10)),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),),
    );
  }
}


