import 'package:brewcrew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.brown[100],
      appBar:AppBar(
        backgroundColor:Colors.brown[400],
        elevation:0.0,
        title: Text('Sign in to Brew Crew'),
      ),
      body:Container(
        padding:EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
        child: ElevatedButton(
          child: Text('Sign in Anom'),
          onPressed: ()async{
            dynamic result = await _auth.signInAnom();
            if(result==null){
              print("error");
            }else{
              print(result.uid);
            }
          }
        ),
      ),
    );
  }
}