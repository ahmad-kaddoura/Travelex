import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class CountryOfTheMonth extends StatelessWidget {
  String _imgUrl;
  String _cityName;
  int _rating;
  CountryOfTheMonth(this._imgUrl, this._cityName, this._rating);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: _imgUrl,
          placeholder: (context, url) => Shimmer.fromColors(
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
          ),
          imageBuilder: (context, imageProvider) => Container(
            height: 35.h,
            width: 85.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                //colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten)
              ),
            ),
          ),
          errorWidget: (context, url, error) => CircularProgressIndicator(),
        ),
        Positioned(
          bottom: 13,
          right: 20,
          child: Row(
            children: [
              for (int i = 0; i < _rating; i++)
                Icon(
                  Icons.star_rate,
                  color: Colors.white,
                  size: 15.sp,
                ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 30,
          child: Text(
            _cityName,
            textScaleFactor: 1.0,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontFamily: 'Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        /*Positioned.fill(
          top: 10,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Country of the month',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontFamily: 'poppins',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),*/
      ],
    );
  }
}
