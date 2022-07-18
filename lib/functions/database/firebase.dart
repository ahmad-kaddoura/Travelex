import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: missing_return
Future<bool> LogInAdminsConsole(String email , String password) async{
  email = email.toLowerCase();
  /*try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('admin', true);
    return true;
  } on FirebaseAuthException catch(error){
    print(error);
  }*/

  // local auth
  if(email == 'admin@travelex.co' && password == 'travelex1122'){
    return true;
  }
  return false;
}

