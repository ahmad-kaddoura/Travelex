import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/widgets/settings_/form_blueprint/card_blueprint.dart';

// ignore: must_be_immutable
class EditCityName extends StatefulWidget{
  final String collectionName;
  final String header;
  final String docId;
  EditCityName(this.collectionName, this.header, this.docId);

  @override
  State<EditCityName> createState() => _EditCityNameState();
}

class _EditCityNameState extends State<EditCityName> {

  @override
  void initState() {
    super.initState();
  }
  final _Namecontroller = TextEditingController();

  String newName;


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
                      TextFormField(
                        autofocus: false,
                        controller: _Namecontroller,
                        decoration: InputDecoration(
                          hintText: 'type new name',
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
                          newName = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () async{
                          if(newName != null){
                            FirebaseFirestore.instance.collection(widget.collectionName)
                                .doc(widget.docId).
                            update({'cityName': newName});
                            Navigator.pop(context);
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
                              'Update',
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
