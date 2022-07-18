import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelex/clippers/clipper1.dart';
import 'package:travelex/functions/controllers/settings_animation_controller.dart';
import 'package:travelex/user_interface/discover_pages/CountryOfTheMonth.dart';
import 'package:travelex/user_interface/discover_pages/cities_list.dart';
import 'package:travelex/user_interface/explore_/explore_more_page.dart';
import 'package:travelex/user_interface/settings/settings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:travelex/widgets/discover_widgets/country_of_the_month.dart';
import 'package:travelex/widgets/discover_widgets/discover_full_widget.dart';
import 'package:travelex/widgets/discover_widgets/explore_activity.dart';
import 'package:travelex/widgets/discover_widgets/header.dart';
import 'package:travelex/widgets/discover_widgets/not_to_be_missed.dart';
import 'package:travelex/widgets/discover_widgets/our_picks.dart';
import 'package:travelex/widgets/discover_widgets/top_destinations.dart';
import 'package:shimmer/shimmer.dart';

class Plan extends StatefulWidget {
  const Plan({Key key}) : super(key: key);

  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  //Country of the month
  String url;
  String cityName;
  int rating;
  String quote =
      "Travel as much as you can. You''ll never find it enough. If you have the opportunity to travel, seize it.";
  String quote2 = "Travel is the only thing you buy that makes you richer";
  String quote3 = "";
  String quote4 = "";

  Future<void> getCountryOFMInitData() async {
    print('InitData fetching function started');
    WidgetsFlutterBinding.ensureInitialized();
    /*final ref = FirebaseStorage.instance.ref().child('cotm.jpg');
    url = await ref.getDownloadURL();*/

    var collection = FirebaseFirestore.instance.collection('CityOfTheMonth');
    var docSnapshot = await collection.doc('pwyulRcaT5y2k2uqYduT').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      url = data['imgUrl']; // <-- The value you want to retrieve.
      cityName = data['cityName'];
      rating = data['rating'];
      // Call setState if needed.
    }
  }

  Future<String> getQuote() async {
    var collection = FirebaseFirestore.instance.collection('App Data');
    var docSnapshot = await collection.doc('dNfzZE7AkZdD6v0vzTKa').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      quote = data['quote'];
      quote2 = data['quote2'];
      quote3 = data['quote3'];
      quote4 = data['quote4'];
    }
  }

  //Places not to be missed
  String Pnm_url;
  String Pnm_header;
  Future<void> getPnmInitData() async {
    WidgetsFlutterBinding.ensureInitialized();

    var collection = FirebaseFirestore.instance.collection('Discover more');
    var docSnapshot = await collection.doc('PwRSnnT5GTzR2HX9wl4M').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      Pnm_url = data['imgUrl'];
      Pnm_header = data['header'];
    }
  }

  //Our Picks
  String Op_url1;
  String Op_header;
  Future<void> getOpInitData() async {
    WidgetsFlutterBinding.ensureInitialized();

    var collection = FirebaseFirestore.instance.collection('Discover more');
    var docSnapshot = await collection.doc('4x1vcm0Ch3yJXSSWds8B').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      Op_url1 = data['imgUrl'];
      Op_header = data['header'];
    }
  }

  //Top destinations
  String Td_url1;
  String Td_header;
  Future<void> getTdInitData() async {
    WidgetsFlutterBinding.ensureInitialized();

    var collection = FirebaseFirestore.instance.collection('Discover more');
    var docSnapshot = await collection.doc('RWvLiBcjuxU1RVPEmXSl').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      Td_url1 = data['imgUrl'];
      Td_header = data['header'];
    }
  }

  @override
  void initState() {
    super.initState();
    getCountryOFMInitData();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                _searchController.clear();
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              }, //OnTap
              child: ListView(
                children: [
                  Container(
                    height: 60.h,
                    width: 100.w,
                    child: Stack(
                      children: [
                        ClipPath(
                          //clipper: OvalBottomBorderClipper(),
                          child: Container(
                            height: 35.h,
                            width: 100.w,
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                        Positioned.fill(
                            top: 61,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'Poppins',
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 0.75,
                                ),
                                child: AnimatedTextKit(
                                  pause: const Duration(milliseconds: 2300),
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      'Country Of The Month',
                                      speed: const Duration(milliseconds: 150),
                                    ),
                                  ],
                                ),
                              ),
                            )),

                        //search bar-------------------------
                        /*Positioned.fill(
                          top: 60,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 80.w,
                                height: 45,
                                decoration: BoxDecoration(
                                  //color: Colors.blueGrey[300],
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextFormField(
                                controller: _searchController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                                decoration: InputDecoration(
                                  //alignLabelWithHint: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  border: InputBorder.none,
                                  label: const Center(child: Text('Search destination'),),
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 12.5.sp,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                                  textAlign: TextAlign.center,
                              ),
                              ),
                            ),
                        ),*/
                        Positioned.fill(
                          bottom: -30,
                          child: Align(
                              alignment: Alignment.center,
                              child: FutureBuilder(
                                future: getCountryOFMInitData(),
                                builder: (BuildContext context, snapshot) {
                                  if (url != null) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => CountryOTM(
                                                      'CityOfTheMonth',
                                                      'pwyulRcaT5y2k2uqYduT')));
                                          /* Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                                            return CountryOTM('CityOfTheMonth', 'pwyulRcaT5y2k2uqYduT');
                                          }));*/
                                        },
                                        child: CountryOfTheMonth(
                                            url, cityName, rating));
                                  } else {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[400],
                                      highlightColor: Colors.grey[350],
                                      child: Container(
                                        width: 85.w,
                                        height: 35.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  DiscoverFull(false),
                  SizedBox(
                    height: 10.h,
                  ),
                  FutureBuilder(
                    future: getQuote(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                            child: SpinKitRipple(
                          color: Theme.of(context).primaryColor,
                          size: 25.w,
                        ));
                      } else {
                        return Container(
                          height: 19.h,
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                                  child: DefaultTextStyle(
                                    //textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 19.3.sp,
                                      fontFamily: 'Caveat',
                                      color: Colors.black,
                                    ),
                                    child: AnimatedTextKit(
                                      pause: Duration(seconds: 8),
                                      displayFullTextOnTap: true,
                                      repeatForever: true,
                                      isRepeatingAnimation: false,
                                      animatedTexts: [
                                        //TyperAnimatedText(quote),
                                        TyperAnimatedText(quote2),
                                        TyperAnimatedText(quote3),
                                        TyperAnimatedText(quote4),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -5,
                                  left: 15,
                                  child: Image.asset(
                                    'assets/others/ql.png',
                                  ),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: 15,
                                  child: Image.asset(
                                    'assets/others/qr.png',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipPath(
                        clipper: ClipperTop(),
                        child: Container(
                          width: 86.w,
                          height: 32.h,
                          //color: Colors.grey[200],
                          child: FutureBuilder(
                            future: getPnmInitData(),
                            builder: (BuildContext context, snapshot) {
                              if (Pnm_url != null) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CitiesFireBaseList(
                                                      'Places Not To Miss',
                                                      false)));
                                    },
                                    child: PlacesNotToBeMissed(
                                        Pnm_url, Pnm_header));
                              } else {
                                return ClipPath(
                                  clipper: ClipperTop(),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[400],
                                    highlightColor: Colors.grey[350],
                                    child: Container(
                                      width: 86.w,
                                      height: 32.h,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipPath(
                            clipper: ClipperRight(),
                            child: Container(
                              width: 43.w,
                              height: 32.h,
                              child: FutureBuilder(
                                future: getOpInitData(),
                                builder: (BuildContext context, snapshot) {
                                  if (Op_url1 != null) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CitiesFireBaseList(
                                                          'Our Picks', false)));
                                        },
                                        child: OurPicks(Op_url1, Op_header));
                                  } else {
                                    return ClipPath(
                                      clipper: ClipperRight(),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[400],
                                        highlightColor: Colors.grey[350],
                                        child: Container(
                                          width: 43.w,
                                          height: 32.h,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          ClipPath(
                            clipper: ClipperLeft(),
                            child: Container(
                              width: 42.w,
                              height: 32.h,
                              child: FutureBuilder(
                                future: getTdInitData(),
                                builder: (BuildContext context, snapshot) {
                                  if (Td_url1 != null) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CitiesFireBaseList(
                                                          'Top Destinations',
                                                          false)));
                                        },
                                        child: TopDestinations(
                                            Td_url1, Td_header));
                                  } else {
                                    return ClipPath(
                                      clipper: ClipperLeft(),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[400],
                                        highlightColor: Colors.grey[350],
                                        child: Container(
                                          width: 43.w,
                                          height: 32.h,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Header(CupertinoIcons.sun_dust, 'Explore more'),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 15,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //ToDo : view all traveling activities page
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: Text(
                                    'View all',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontSize: 10.5.sp,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                CupertinoIcons.arrow_turn_down_right,
                                size: 12.sp,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    height: 22.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExploreMore()));
                          },
                          child: Explore('assets/svg/hiking.svg',
                              Colors.blue[100], Colors.blue[600], 'Hiking'),
                        ),
                        Explore('assets/svg/kayak.svg', Colors.green[100],
                            Colors.green[600], 'Kayaking'),
                        Explore(
                            'assets/svg/air-balloon.svg',
                            Colors.purple[100],
                            Colors.purple[600],
                            'Ballooning'),
                        Explore('assets/svg/snorkel.svg', Colors.orange[100],
                            Colors.orange[600], 'Snorkeling'),
                        Explore('assets/svg/stars.svg', Colors.red[100],
                            Colors.red[600], 'Star Gazing'),
                        Explore('assets/svg/rock.svg', Colors.yellow[100],
                            Colors.yellow[600], 'Rock Climbing'),
                      ],
                    ),
                  ),
                  /* Center(
                    child: Lottie.asset(
                      'assets/animations/flying_plane.json',
                      width: 50.w,
                      height: 50.w,
                    ),
                  ), */
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      'Stay in touch',
                      textScaleFactor: 1.0,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15.sp,
                        //letterSpacing: 1.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/insta.svg',
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0, right: 0),
                        child: SvgPicture.asset(
                          'assets/svg/tiktok.svg',
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/svg/gmail.svg',
                      ),
                    ],
                  ),
                  Center(
                    child: Lottie.asset(
                      'assets/animations/social_media.json',
                      width: 60.w,
                      height: 50.w,
                    ),
                  ),
                  //SizedBox(height: 10,),
                  //End of ListView (Body Widgets)
                ],
              ),
            ),
            Functions.instance.getReverseStatus() == false
                ? Positioned(
                    top: 18,
                    child: SlideInLeft(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
                          },
                          child: SvgPicture.asset(
                            'assets/svg/options.svg',
                            color: Theme.of(context).primaryColor,
                            width: 5.w,
                            height: 5.w,
                          ),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    top: 18,
                    child: SlideInRight(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SvgPicture.asset(
                            'assets/svg/options.svg',
                            color: Theme.of(context).primaryColor,
                            width: 5.w,
                            height: 5.w,
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
