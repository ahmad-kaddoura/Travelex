import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Discover extends StatelessWidget{
  final String _imgPath;
  final String _destination;
  Discover(this._imgPath, this._destination);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0), //add border radius
            child: Image.asset(
              _imgPath,
              height: 28.h,
              width: 42.w,
              fit:BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _destination,
              textScaleFactor: 1.0,
              style: TextStyle(
                //color: const Color.fromRGBO(17, 45, 78, 1),
                fontFamily: 'Sans',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

