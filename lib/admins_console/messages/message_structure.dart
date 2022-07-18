import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageStructure extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  const MessageStructure({Key key, this.index, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(211, 211, 211, 1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text(
              data["name"],
              textScaleFactor: 1.0,
              style: TextStyle(
                color:Colors.black,
                letterSpacing: 1,
                fontFamily: 'Poppins',
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              data["email"],
              textScaleFactor: 1.0,
              style: TextStyle(
                color:Colors.black,
                letterSpacing: 1,
                fontFamily: 'Poppins',
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: AutoDirection(
                text: data['message'],
                child: Text(
                  data['message'],
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Tajawal',
                    //letterSpacing: 0.8,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
