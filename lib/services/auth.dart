import 'package:brewcrew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase user
  UserModel _userFromFirebaseUser(User user){
    return user != null ? UserModel(uid: user.uid):null;
  }

  //Stream
  Stream<UserModel> get user {
    return _auth.authStateChanges()
        //.map((User user)=>_userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //Anom
  Future signInAnom() async{
    try{
     UserCredential result = await _auth.signInAnonymously();
     User user = result.user;
     return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //Email PW

  Future SignInEandP(String Email, String Password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: Email, password: Password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register
  Future RegisterEandP(String Email, String Password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: Email, password: Password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //Sign Out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}
}