import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/widgets/settings_/form_blueprint/card_blueprint.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditCityImage extends StatefulWidget{
  final String collectionName;
  final String header;
  final String docId;
  final String cityName;
  EditCityImage(this.collectionName, this.header, this.docId, this.cityName);

  @override
  State<EditCityImage> createState() => _EditCityImageState();
}

class _EditCityImageState extends State<EditCityImage> {

  @override
  void initState() {
    super.initState();
  }
  final _Imgcontroller = TextEditingController();

  String newImgUrl;


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
                        widget.header +' Image',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 20,),
                      CachedNetworkImage(
                        imageUrl: newImgUrl,
                        placeholder: (context, url) => SpinKitPulse(color: Theme.of(context).primaryColor, size: 20.w,),
                        //CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                        imageBuilder: (context, imageProvider) => Container(
                          height: 27.h,
                          width: 88.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              //colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten)
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        autofocus: false,
                        controller: _Imgcontroller,
                        decoration: InputDecoration(
                          hintText: 'Enter new imgUrl',
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
                          newImgUrl = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async{
                              if(newImgUrl != null){
                                FirebaseFirestore.instance.collection(widget.collectionName)
                                    .doc(widget.docId).
                                update({'imgUrl': newImgUrl});
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
                          IconButton(
                              onPressed:() async{
                                final _firebaseStorage = FirebaseStorage.instance;
                                final _imagePicker = ImagePicker();
                                PickedFile image;
                                //Check Permissions
                                /*await Permission.photos.request();
                                var permissionStatus = await Permission.photos.status;*/

                                  //Select Image
                                  image = await _imagePicker.getImage(source: ImageSource.gallery);
                                  var file = File(image.path);

                                  if (image != null){
                                    Fluttertoast.showToast(
                                      msg: "Uploading please wait ... ",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.SNACKBAR,
                                      backgroundColor: Theme.of(context).colorScheme.secondary,
                                      textColor: Colors.white,
                                      fontSize: 12.sp,
                                    );
                                    String c = widget.collectionName;
                                    String city = widget.cityName;
                                    String path = '$c/$city';
                                    //Upload to Firebase
                                    var snapshot = await _firebaseStorage.ref()
                                        .child(path)
                                        .putFile(file);
                                    var downloadUrl = await snapshot.ref.getDownloadURL();
                                    setState(() {
                                      newImgUrl = downloadUrl;
                                      Fluttertoast.showToast(
                                        msg: "Image Uploaded",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.SNACKBAR,
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                        textColor: Colors.white,
                                        fontSize: 12.sp,
                                      );
                                });
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'No Image Path Received',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      backgroundColor: Theme.of(context).colorScheme.secondary,
                                      textColor: Colors.white,
                                      fontSize: 12.sp,
                                    );
                                  }
                              },
                              icon: Icon(
                                  CupertinoIcons.photo_fill,
                                size: 25.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                          ),
                        ],
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
