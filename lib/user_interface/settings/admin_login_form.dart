import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/admins_console/admins_home.dart';
import 'package:travelex/functions/database/firebase.dart';
import 'package:travelex/widgets/settings_/form_blueprint/card_blueprint.dart';


// ignore: must_be_immutable
class AdminLogIn extends StatefulWidget{
  @override
  State<AdminLogIn> createState() => _AdminLogInState();
}

class _AdminLogInState extends State<AdminLogIn> {
  final _Passwordcontroller = TextEditingController();
  final _Emailcontroller = TextEditingController();

  String password;
  String email;

  String _heroAddTodo = 'add-todo-hero';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: _heroAddTodo,
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin, end: end);
            },
            child: Material(
              color: Color.fromRGBO(211, 211, 211, 1),
              elevation: 2,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Text(
                        'Admins Console',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          color: Theme.of(context).primaryColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 30,),
                      TextFormField(
                        autofocus: false,
                        controller: _Emailcontroller,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        minLines: 1,
                        maxLines: 1,
                        onChanged: (value){
                          email = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 40,),
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom/2),
                        child: TextFormField(
                          autofocus: false,
                          obscureText: true,
                          controller: _Passwordcontroller,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(10),
                          ),
                          minLines: 1,
                          maxLines: 1,
                          onChanged: (value){
                            password = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () async {
                          bool authorize = await LogInAdminsConsole(
                              _Emailcontroller.text.trim(),
                              _Passwordcontroller.text.trim());
                          if (authorize == true) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AdminsConsoleHome()));
                          } else {
                            Fluttertoast.showToast(
                              msg: "UnAuthorized",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              textColor: Colors.white,
                              fontSize: 12.sp,
                            );
                          }
                        },
                        child: Container(
                          width: 30.w,
                          decoration: BoxDecoration(
                            // color: Color.fromRGBO(189, 189, 189, 1),
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Authorize',
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
