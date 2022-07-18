import 'package:auto_direction/auto_direction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'card_blueprint.dart';



// ignore: must_be_immutable
class ContactForm extends StatefulWidget{
  final String collectionName;
  final String header;
  ContactForm(this.collectionName, this.header);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  void initState() {
    super.initState();
    loading = false;
  }
  final _Namecontroller = TextEditingController();
  final _Emailcontroller = TextEditingController();
  final _Messagecontroller = TextEditingController();

  String name;
  String email;
  String message;

  int nameValidator;
  int emailValidator;
  int messageValidator;

  bool loading;

  //final store = FirebaseFirestore.instance.collection('support');
  String _generalTest(int validator, TextEditingController cnt) {
    final text = cnt.value.text;
    if (text.isEmpty) {
      validator = 0;
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      validator = 0;
      return 'Too short';
    }
    validator = 1;
    // return null if the text is valid
    return null;
  }
  // String _heroAddTodo = 'add-todo-hero';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: loading == false ? GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: 'support',
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
                        widget.header,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 20,),
                      AutoDirection(
                        text: _Namecontroller.text,
                        child: TextFormField(
                          autofocus: false,
                          controller: _Namecontroller,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            filled: true,
                            errorText: _generalTest(nameValidator,_Namecontroller),
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
                            name = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        autofocus: false,
                        controller: _Emailcontroller,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          errorText: _generalTest(emailValidator,_Emailcontroller),
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
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom/2),
                        child: AutoDirection(
                          text: _Messagecontroller.text,
                          child: TextFormField(
                            autofocus: false,
                            controller: _Messagecontroller,
                            decoration: InputDecoration(
                              hintText: 'Type your Message',
                              filled: true,
                              errorText: _generalTest(messageValidator,_Messagecontroller),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                            minLines: 1,
                            maxLines: 20,
                            onChanged: (value){
                              message = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 60,),
                      GestureDetector(
                        onTap: () async{
                          setState(() {loading = true;});
                          await FirebaseFirestore.instance.collection(widget.collectionName).add({
                            'email': email == null ? 'Empty' : email,
                            'message': message == null ? 'Empty' : message,
                            'name': name == null ? 'Empty' : name,
                            'timestamp': Timestamp.now().microsecondsSinceEpoch,
                          });
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            msg: "Message Sent",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.SNACKBAR,
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            textColor: Colors.white,
                            fontSize: 12.sp,
                          );
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
                              'Send',
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
      ) :
      SpinKitSpinningLines(
        color: Theme.of(context).primaryColor,
        size: 40.w,
      ),
    );
  }
}
