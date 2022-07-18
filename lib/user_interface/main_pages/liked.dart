import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelex/functions/classes/wishlist_object.dart';
import 'package:travelex/user_interface/settings/settings.dart';
import 'package:travelex/widgets/discover_widgets/city.dart';
import '../../functions/database/database.dart';
import '../../functions/controllers/settings_animation_controller.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: FutureBuilder<List<LikedCity>>(
                  future: DatabaseHelper.instance.getWishList(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<LikedCity>> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ));
                    }
                    if (snapshot.data.length == 0) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 13.h,
                          ),
                          Lottie.asset(
                            'assets/animations/empty.json',
                            width: 60.w,
                            height: 60.w,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Container(
                            width: 100.w,
                            height: 15.h,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Discover Places & add them to your Bucket List !',
                                  textScaleFactor: 1.0,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.sp,
                                    //letterSpacing: 1.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    List<LikedCity> tmplist = snapshot.data;
                    return ListView.builder(
                      itemCount: tmplist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1200),
                          child: SlideAnimation(
                            verticalOffset: 75.0,
                            child: FadeInAnimation(
                              child: Center(
                                child: City(
                                  tmplist[index].cityName,
                                  tmplist[index].imgUrl,
                                  false,
                                  'no need for id',
                                  'no need for collection name',
                                  tmplist[index].streetView,
                                  tmplist[index].location,
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      /*children: [
                            for (int index = 0; index < tmplist.length; index++)
                              City(
                                tmplist[index].cityName,
                                tmplist[index].imgUrl,
                                false,
                                'no need for id',
                                'no need for collection name',
                                 tmplist[index].streetView,
                              ),
                          ],*/
                    );
                  }),
            ),
            Functions.instance.getReverseStatus()
                ? Positioned(
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
                : Positioned(
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
                  ),
            Positioned(
              //11.5 to 5
              top: 10,
              left: 100,
              child: Text(
                'My Bucket List',
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  letterSpacing: 1,
                  fontSize: 18.sp,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
