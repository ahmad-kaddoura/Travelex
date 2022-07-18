import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Header extends StatelessWidget{
  final IconData _icon;
  final String _headerText;

  const Header( this._icon, this._headerText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15,),
          child: Icon(
            _icon,
            color: Theme.of(context).primaryColor,
            size: 15.sp,
          ),
        ),
        Text(
          _headerText,
          textScaleFactor: 1.0,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15.sp,
            //letterSpacing: 1.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}