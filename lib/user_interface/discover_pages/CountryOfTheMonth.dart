import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/functions/classes/wishlist_object.dart';
import 'package:travelex/functions/database/database.dart';

// ignore: must_be_immutable
class CountryOTM extends StatelessWidget {
  final String _collection;
  final String _docId;
  CountryOTM(this._collection, this._docId);

  String _imgUrl;
  String _description;
  String _name;
  String _location;
  String _videoId;

  String _img1Url;
  String _img2Url;
  String _img3Url;

  bool _love;
  bool _overView = true;
  bool _gallery = false;
  int opened = 0;

  //YoutubePlayerController _controller;

  void setTrue(String selected) {
    if (selected == 'overView') {
      _overView = true;
      _gallery = false;
      opened++;
    } else if (selected == 'gallery') {
      _overView = false;
      _gallery = true;
      opened++;
    }
  }

  Future<void> getInitData() async {
    WidgetsFlutterBinding.ensureInitialized();
    var collection = FirebaseFirestore.instance.collection(_collection);
    var docSnapshot = await collection.doc(_docId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      _imgUrl = data['imgUrl']; // <-- The value you want to retrieve.
      _description = data['description'];
      _name = data['cityName'];
      _location = data['location'];
      _videoId = data['videoId'];
      _img1Url = data['img1'];
      _img2Url = data['img2'];
      _img3Url = data['img3'];
    }
    _love = await DatabaseHelper.instance.findRecordInWishList(_name);

    /* _controller = YoutubePlayerController(
      initialVideoId: _videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    ); */
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: getInitData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 100.w,
                          height: 60.h,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            //image: DecorationImage(image: NetworkImage(_imgUrl,), fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(55),
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: _imgUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SpinKitRipple(
                              color: Theme.of(context).primaryColor,
                              size: 25.w,
                            ),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          top: 18,
                          left: 5,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.white,
                            ),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 50,
                          left: 25,
                          child: Text(
                            _name,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontFamily: 'Poppins',
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 25,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  _location,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontFamily: 'Sans',
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 35,
                          right: 40,
                          child: StatefulBuilder(
                            builder: (context, _setState) {
                              return GestureDetector(
                                onTap: () async {
                                  if (_love == false) {
                                    await DatabaseHelper.instance
                                        .addToLiked(LikedCity(
                                      cityName: _name,
                                      imgUrl: _imgUrl,
                                    ));
                                    _setState(() {
                                      _love = true;
                                    });
                                  } else {
                                    DatabaseHelper.instance
                                        .deleteRecordFromWishList(LikedCity(
                                      cityName: _name,
                                      imgUrl: _imgUrl,
                                    ));
                                    _setState(() {
                                      _love = false;
                                    });
                                  }
                                },
                                child: _love == false
                                    ? Icon(
                                        CupertinoIcons.heart,
                                        color: Colors.white,
                                        size: 30,
                                      )
                                    : Icon(
                                        CupertinoIcons.heart_solid,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (_context, _setState) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 25,
                                left: 36,
                                right: 36,
                                bottom: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _setState(() {
                                            setTrue('overView');
                                          });
                                        },
                                        child: Text(
                                          'Overview',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: _overView == true && opened > 0
                                            ? SlideInRight(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                child: Container(
                                                  height: 5,
                                                  width: 42,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              )
                                            : Container(
                                                height: 5,
                                                width: 42,
                                                color: opened == 0
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.white,
                                              ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _setState(() {
                                            setTrue('gallery');
                                          });
                                        },
                                        child: Text(
                                          'Gallery',
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: _gallery == true
                                            ? SlideInLeft(
                                                duration:
                                                    Duration(milliseconds: 300),
                                                child: Container(
                                                  height: 5,
                                                  width: 42,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              )
                                            : Container(
                                                height: 5,
                                                width: 42,
                                                color: Colors.white,
                                              ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '       ',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: _overView == true
                                  ? Column(
                                      children: [
                                        /* YoutubePlayerBuilder(
                                      player: YoutubePlayer(
                                        controller: _controller,
                                      ),
                                        builder: (context, player){
                                        return player;
                                        }
                                    ),
                                    SizedBox(height: 32,), */
                                        Text(
                                          _description,
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: 'Mukta',
                                            //fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(85, 85, 85, 1),
                                          ),
                                        )
                                      ],
                                    )
                                  :
                                  // ------- Gallery screen
                                  Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: _img1Url,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[400],
                                            highlightColor: Colors.grey[350],
                                            child: Container(
                                              width: 85.w,
                                              height: 27.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                          ),
                                          //CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 27.h,
                                            width: 88.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                //colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten)
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              CircularProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: _img2Url,
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor: Colors.grey[400],
                                                  highlightColor:
                                                      Colors.grey[350],
                                                  child: Container(
                                                    width: 44.w,
                                                    height: 35.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Colors.grey[400],
                                                    ),
                                                  ),
                                                ),
                                                //CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  height: 35.h,
                                                  width: 44.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      //colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten)
                                                    ),
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                              CachedNetworkImage(
                                                imageUrl: _img3Url,
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor: Colors.grey[400],
                                                  highlightColor:
                                                      Colors.grey[350],
                                                  child: Container(
                                                    width: 44.w,
                                                    height: 35.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      color: Colors.grey[400],
                                                    ),
                                                  ),
                                                ),
                                                //CircularProgressIndicator(color: Theme.of(context).primaryColor,),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  height: 35.h,
                                                  width: 44.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      //colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten)
                                                    ),
                                                  ),
                                                ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              } else {
                return SpinKitRipple(
                  color: Theme.of(context).primaryColor,
                  size: 25.w,
                );
              }
            }),
      ),
    );
  }
}
