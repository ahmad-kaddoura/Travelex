import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/user_interface/settings/admin_login_form.dart';
import 'package:travelex/user_interface/settings/crypto_support.dart';
import '../../widgets/settings_/form_blueprint/contact_form.dart';
import 'package:travelex/functions/database/database.dart';
import 'package:travelex/widgets/settings_/contact_us.dart';
import 'package:travelex/widgets/settings_/biometrics.dart';
import 'package:travelex/widgets/settings_/dark_mode.dart';
import '../../widgets/settings_/form_blueprint/hero_dialog_route.dart';
import 'package:travelex/widgets/settings_/req_feature.dart';
import 'package:lottie/lottie.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
          title: Text(
            'App Settings',
            textScaleFactor: 1.0,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Poppins',
              color: Colors.grey[800],
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.admin_panel_settings_outlined,
                color: Colors.black,
                size: 30,
              ),
              tooltip: 'Admins Console',
              onPressed: () async {
                Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                  return AdminLogIn();
                }));
              },
            ),
          ],
        ),
        body: ListView(
          //physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Biometric(),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: DarkMode(),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Text(
                            'Are you sure you want to delete your BucketList ?',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                "Cancel",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Sans',
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                "yes",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontFamily: 'Sans',
                                  letterSpacing: 0.5,
                                ),
                              ),
                              onPressed: () async {
                                await DatabaseHelper.instance
                                    .EmptyBucketListDb();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Color.fromRGBO(211, 211, 211, 1),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Empty BucketList',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 14.sp,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onLongPress: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Text(
                            'Are you sure you want to delete your database ? all data will be lost and a restart of the app is required.',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                "Cancel",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Sans',
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                "yes",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontFamily: 'Sans',
                                  letterSpacing: 0.5,
                                ),
                              ),
                              onPressed: () async {
                                await DatabaseHelper.instance.deleteDb();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: Text(
                            'Are you sure you want to delete all your visits ?',
                            textScaleFactor: 1.0,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                "Cancel",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: 'Sans',
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                "yes",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                  fontFamily: 'Sans',
                                  letterSpacing: 0.5,
                                ),
                              ),
                              onPressed: () async {
                                await DatabaseHelper.instance.EmptyMainDb();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //color: Color.fromRGBO(211, 211, 211, 1),
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Delete all visits',
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 14.sp,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return CryptoSupport();
                    }));
                  },
                  child: Lottie.asset(
                    'assets/animations/crypto.json',
                    width: 55.w,
                    height: 45.w,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Click To Support Us \n With Crypto',
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15.sp,
                    //letterSpacing: 1.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(HeroDialogRoute(builder: (context) {
                      return ContactForm('support', 'Contact Support');
                    }));
                  },
                  child: ContactUs(
                      'Contact support',
                      'Submit a request and our support team will contact you shortly',
                      'assets/images/us.png')),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(HeroDialogRoute(builder: (context) {
                        return ContactForm('ReqFeatures', 'Req Features');
                      }));
                    },
                    child: ReqFeature(
                        'Request a feature',
                        'Share your ideas to improve the Travelex app',
                        'assets/images/abs2.png')),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Travelex v1.0 2022',
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
