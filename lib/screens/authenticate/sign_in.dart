import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

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
        title: Text('Sign in to Brew Crew'),
        actions:<Widget>[
          TextButton.icon(
              style: TextButton.styleFrom(
                primary:Colors.black,
              ),
              onPressed: () async{
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register')
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
                  child:Text('Sign In',
                  style:TextStyle(color:Colors.white)
                  ),
                  onPressed:()async{
                    if(_formKey.currentState.validate()){
                      setState(()=>loading=true);
                      dynamic result = await _auth.SignInEandP(email,password);
                      if(result == null){
                        setState((){
                          error = 'Could Not Sign In, Check Credentials';
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
//ElevatedButton(
//child: Text('Sign in Anom'),
//onPressed: ()async{
//dynamic result = await _auth.signInAnom();
//if(result==null){
//print("error");
//}else{
//print(result.uid);
//}
//}
//),