import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/admins_console/messages/messages_wall.dart';
import 'package:travelex/functions/controllers/bottom_nav.dart';
import 'package:travelex/widgets/discover_widgets/discover_full_widget.dart';
import 'package:travelex/widgets/settings_/contact_us.dart';
import 'package:travelex/widgets/settings_/req_feature.dart';

class AdminsConsoleHome extends StatefulWidget {
  @override
  _AdminsConsoleHomeState createState() => _AdminsConsoleHomeState();
}

class _AdminsConsoleHomeState extends State<AdminsConsoleHome> {
  int SupportMessagesLength;
  int ReqftLength;
  Future<void> SupportSize() async{
    var collection = FirebaseFirestore.instance.collection('support');
    var snapshots = await collection.get();
    SupportMessagesLength= snapshots.size;
  }

  Future<void> ReqFt() async{
    var collection = FirebaseFirestore.instance.collection('ReqFeatures');
    var snapshots = await collection.get();
    ReqftLength = snapshots.size;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Nav()));
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Admins Console',
          textScaleFactor: 1.0,
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'Poppins',
            color: Colors.grey[800],
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(height: 4.h,),
          DiscoverFull(true),
          SizedBox(height: 4.h,),
          //Support Messages
          Container(
            height: 25.h,
            child: Stack(
                children:[
                  Center(
                    child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Messages('support','Support Messages')));
                        },
                        child: ContactUs('Support Messages','Submit a request and our support team will contact you shortly','assets/images/us.png')),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 25,
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: FutureBuilder(
                        future: ReqFt(),
                        builder: (context, snapshot){
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Center(
                              child: Text(
                                SupportMessagesLength.toString(),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                ),
                              ),
                            );
                          }
                          else{
                            return SpinKitRipple(
                              color: Theme.of(context).primaryColor,
                              size: 15.w,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ]
            ),
          ),
          SizedBox(height: 4.h,),
          //Request a feature
          Container(
            height: 25.h,
            child: Stack(
              children:[
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Messages('ReqFeatures','ReqFeatures Messages')));
                    },
                    child: ReqFeature('Requesting features','Share your ideas to improve the Travelex app','assets/images/abs2.png'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 25,
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: FutureBuilder(
                      future: SupportSize(),
                      builder: (context, snapshot){
                       if (snapshot.connectionState == ConnectionState.done) {
                         return Center(
                           child: Text(
                             ReqftLength.toString(),
                             style: TextStyle(
                               fontSize: 13.sp,
                             ),
                           ),
                         );
                       }
                       else{
                         return SpinKitRipple(
                           color: Theme.of(context).primaryColor,
                           size: 15.w,
                         );
                       }
                      },
                    ),
                  ),
                ),
              ]
            ),
          ),
          SizedBox(height: 4.h,),
        ],
      ),
    );
  }
}
