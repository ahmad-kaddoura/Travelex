import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReqFeature extends StatelessWidget {
  final String _header;
  final String _description;
  final String _imgPath;
  ReqFeature( this._header, this._description, this._imgPath);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 80.w,
          height: 22.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(25.0),
            image: DecorationImage(
              image: AssetImage(_imgPath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  _header,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  _description,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                    //fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontFamily: 'Sans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
