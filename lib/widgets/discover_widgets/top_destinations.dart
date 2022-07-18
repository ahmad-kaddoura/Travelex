import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class TopDestinations extends StatefulWidget {
  String _imgUrl1;
  String _header;

  TopDestinations(this._imgUrl1, this._header);

  @override
  State<TopDestinations> createState() => _TopDestinationsState();
}

class _TopDestinationsState extends State<TopDestinations> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: widget._imgUrl1,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[400],
            highlightColor: Colors.grey[350],
            child: Container(
              width: 43.w,
              height: 32.h,
              color: Colors.grey[400],
            ),
          ),
          imageBuilder: (context, imageProvider) => Container(
            height: 32.h,
            width: 43.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                //colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten)
              ),
            ),
          ),
          errorWidget: (context, url, error) => CircularProgressIndicator(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              color: Colors.black.withOpacity(0.3),
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Text(
                widget._header,
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.3.sp,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
