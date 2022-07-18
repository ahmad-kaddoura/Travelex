import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class Explore extends StatelessWidget{
  final String _iconPath;
  final Color _bgColor;
  final Color _iconColor;
  final String _text;
  Explore(this._iconPath, this._bgColor, this._iconColor, this._text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Container(
            width: 19.w,
            height: 19.w,
            decoration: BoxDecoration(
              color: _bgColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: SvgPicture.asset(
                _iconPath,
                color: _iconColor,
                width: 13.w,
                height: 13.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              _text,
              textScaleFactor: 1.0,
              style: TextStyle(
                fontSize: 10.6.sp,
                fontFamily: 'Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}