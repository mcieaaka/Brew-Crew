import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor:Colors.brown[100],
      appBar:AppBar(
        backgroundColor:Colors.brown[400],
        elevation:0.0,
        title: Text('Sign Up to Brew Crew'),
          actions:<Widget>[
            TextButton.icon(
                style: TextButton.styleFrom(
                  primary:Colors.black,
                ),
                onPressed: () async{
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Sign In')
            )
          ]
      ),
      body:Container(
        padding:EdgeInsets.symmetric(vertical:20.0,horizontal:50.0),
        child: Form(
          key: _formKey,
          child: Column(
              children:<Widget>[
                SizedBox(height:20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText:'Email'),
                  validator: (val)=> val.isEmpty ?'Enter an Email':null,
                    onChanged:(val){
                      setState(()=>email=val);
                    }
                ),
                SizedBox(height:20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText:'Password'),
                  validator: (val)=> val.length<6 ? 'Enter a password of 6+ Characters':null,
                    obscureText:true,
                    onChanged:(val){
                      setState(()=>password=val);
                    }
                ),
                SizedBox(height:20.0),
                ElevatedButton(
                    style:ElevatedButton.styleFrom(
                        primary:Colors.pink[400]
                    ),
                    child:Text('Register',
                        style:TextStyle(color:Colors.white)
                    ),
                    onPressed:()async{
                      if(_formKey.currentState.validate()){
                        setState(()=>loading=true);
                        dynamic result = await _auth.RegisterEandP(email,password);
                        if(result == null){
                          setState((){
                            error = 'Some error';
                            loading = false;
                          });
                        }
                      }
                    }
                ),
                SizedBox(height:20.0),
                Text(
                  error,
                  style:TextStyle(color:Colors.red,fontSize:14.0),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
