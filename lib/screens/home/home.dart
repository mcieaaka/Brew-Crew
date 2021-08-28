import 'package:flutter/material.dart';
import 'package:brewcrew/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar:AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation:0.0,
        actions:<Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(
                primary:Colors.black,
              ),
              onPressed: () async{
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Log Out')
          )
        ]
      )
    );
  }
}
