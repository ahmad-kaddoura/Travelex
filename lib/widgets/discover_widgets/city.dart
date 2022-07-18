import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/admins_console/functions/edit_image.dart';
import 'package:travelex/admins_console/functions/edit_name.dart';
import 'package:travelex/functions/classes/wishlist_object.dart';
import 'package:travelex/functions/database/database.dart';
import 'package:travelex/user_interface/discover_pages/location_images.dart';
import 'package:travelex/widgets/settings_/form_blueprint/hero_dialog_route.dart';

// ignore: must_be_immutable
class City extends StatelessWidget {
  final String _cityName;
  final String _imgUrl;
  final bool isAdmin;
  final String docId;
  final String collection;
  final String streetView;
  final String location;
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String img5;
  final String img6;
  final String img7;
  final String img8;
  final String img9;
  final String img10;
  City(
      this._cityName,
      this._imgUrl,
      this.isAdmin,
      this.docId,
      this.collection,
      this.streetView,
      this.location,
      this.img1,
      this.img2,
      this.img3,
      this.img4,
      this.img5,
      this.img6,
      this.img7,
      this.img8,
      this.img9,
      this.img10);

  bool _love;
  bool _likeAnimationController = false;
  bool _unlikeAnimationController = false;

  Future<void> getInitData() async {
    _love = await DatabaseHelper.instance.findRecordInWishList(_cityName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInitData(),
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: GestureDetector(
            onLongPress: () {
              if (isAdmin == true) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      content: Text(
                        'Are you sure you want to delete $_cityName from the list ',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            "Cancel",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'Sans',
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            "delete",
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontFamily: 'Sans',
                              letterSpacing: 0.5,
                            ),
                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection(this.collection)
                                .doc(this.docId)
                                .delete();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            onTap: () async {
              //await launch(streetView);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationImages(img1, img2, img3,
                          img4, img5, img6, img7, img8, img9, img10)));
            },
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: _imgUrl,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.grey[350],
                    child: Container(
                      width: 88.w,
                      height: 27.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
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
                  errorWidget: (context, url, error) =>
                      CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 30,
                  child: Column(
                    children: [
                      Text(
                        _cityName == null ? 'loading' : _cityName,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                          //backgroundColor: Theme.of(context).backgroundColor,
                          fontSize: 18.3.sp,
                          fontFamily: 'Poppins',
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              //color: Theme.of(context).backgroundColor,
                              color: Colors.black,
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        location == null ? 'loading' : location,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          color: Colors.white,
                          //backgroundColor: Theme.of(context).backgroundColor,
                          fontSize: 15.3.sp,
                          fontFamily: 'Poppins',
                          //letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              //color: Theme.of(context).backgroundColor,
                              color: Colors.black,
                              offset: Offset(1.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //delete a city from list and firebase collection
                isAdmin == true
                    ? Positioned(
                        top: 10,
                        right: 30,
                        child: IconButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .push(HeroDialogRoute(builder: (context) {
                              return EditCityImage(
                                  this.collection,
                                  'Edit $_cityName',
                                  this.docId,
                                  this._cityName);
                            }));
                          },
                          icon: Icon(
                            CupertinoIcons.photo_on_rectangle,
                            color: Colors.white,
                            size: 23.sp,
                          ),
                        ),
                      )
                    : SizedBox(),
                Positioned(
                  bottom: 25,
                  right: 30,
                  child: isAdmin == false
                      ? StatefulBuilder(
                          builder: (context, _setState) {
                            return GestureDetector(
                              onTap: () async {
                                _likeAnimationController = true;
                                if (_love == false) {
                                  await DatabaseHelper.instance.addToLiked(
                                      LikedCity(
                                          cityName: _cityName,
                                          imgUrl: _imgUrl,
                                          location: location));
                                  Fluttertoast.showToast(
                                    msg: "Added to Bucket List",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.SNACKBAR,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    textColor: Colors.white,
                                    fontSize: 12.sp,
                                  );
                                  _setState(() {
                                    _love = true;
                                  });
                                } else {
                                  _unlikeAnimationController = true;
                                  DatabaseHelper.instance
                                      .deleteRecordFromWishList(LikedCity(
                                    cityName: _cityName,
                                    imgUrl: _imgUrl,
                                  ));
                                  Fluttertoast.showToast(
                                    msg: "Removed from Bucket List",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.SNACKBAR,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    textColor: Colors.white,
                                    fontSize: 12.sp,
                                  );
                                  _setState(() {
                                    _love = false;
                                  });
                                }
                              },
                              child: _love == false
                                  ?
                                  //size was 30 before 25.sp
                                  Flash(
                                      animate: _unlikeAnimationController,
                                      child: Icon(
                                        CupertinoIcons.heart,
                                        color: Colors.white,
                                        size: 25.sp,
                                      ))
                                  : Swing(
                                      animate: _likeAnimationController,
                                      //duration: Duration(milliseconds: 500),
                                      child: Icon(
                                        CupertinoIcons.heart_solid,
                                        color: Colors.redAccent[700],
                                        size: 25.sp,
                                      )),
                            );
                          },
                        )
                      :
                      //edit an existing city in the list
                      IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(HeroDialogRoute(builder: (context) {
                              return EditCityName(this.collection,
                                  'Edit $_cityName', this.docId);
                            }));
                          },
                          icon: Icon(
                            CupertinoIcons.pencil_ellipsis_rectangle,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
