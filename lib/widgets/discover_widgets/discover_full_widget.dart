import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/user_interface/discover_pages/cities_list.dart';
import 'package:travelex/widgets/discover_widgets/discover.dart';

// Dicover header + listview of cities
class DiscoverFull extends StatelessWidget {
  final bool isAdmin;

  const DiscoverFull(this.isAdmin);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  Icons.add_location,
                  color: Theme.of(context).primaryColor,
                  size: 18.sp,
                ),
              ),
              Text(
                'Discover',
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.sp,
                  //letterSpacing: 1.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: 40.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CitiesFireBaseList(
                              'Towns&Cities', this.isAdmin)));
                },
                child: Discover('assets/images/dubai.jpg', 'Towns & Cities'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CitiesFireBaseList(
                              'Natural Areas', this.isAdmin)));
                },
                child: Discover(
                    'assets/images/natural_areas.jpg', 'Natural Areas'),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CitiesFireBaseList(
                                'Beach Areas', this.isAdmin)));
                  },
                  child: Discover("assets/images/bahamas.jpg", 'Beach Areas')),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CitiesFireBaseList(
                                'Culture&Heritage', this.isAdmin)));
                  },
                  child: Discover(
                      "assets/images/culture.jpg", 'Culture & heritage')),
            ],
          ),
        ),
      ],
    );
  }
}
