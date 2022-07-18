import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flag/flag.dart';
import '../../functions/classes/visit_object.dart';

class VisitedCity extends StatelessWidget{
  final String _cityCode;
  final String _cityName;
  final Visit visit;

  const VisitedCity (this._cityCode, this._cityName, this.visit);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 20),
          child: Flag.fromString(
            _cityCode,
            height: 26.sp,
            width: 26.sp,
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.only(left: 20),
          child: Text(
            _cityName,
            textScaleFactor: 1.0,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

}