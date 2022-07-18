import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Biometric extends StatefulWidget {
  @override
  State<Biometric> createState() => _BiometricState();
}

class _BiometricState extends State<Biometric> {
  bool isSelected;
  String _header;
  double opacity;

  Future<void> getState() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _header = prefs.getString('bio_header');
    isSelected = prefs.getBool('bioStat');
    if (_header == null) {
      prefs.setString('bio_header', 'Disabled');
      prefs.setBool('bioStat', false);
      _header = 'Disabled';
      isSelected = false;
      opacity = 0.5;
    }
    if (isSelected == true) {
      opacity = 1;
    }
    if (isSelected == false) {
      opacity = 0.5;
    }
  }

  Future<void> toggleState() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isSelected == false) {
      prefs.setString('bio_header', 'Enabled ');
      prefs.setBool('bioStat', true);
      _header = 'Enabled ';
      isSelected = true;
      opacity = 1;
    } else {
      prefs.setString('bio_header', 'Disabled');
      prefs.setBool('bioStat', false);
      _header = 'Disabled';
      isSelected = false;
      opacity = 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            onTap: () async {
              Fluttertoast.showToast(
                msg: "Coming Soon ...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                textColor: Colors.white,
                fontSize: 12.sp,
              );
            },
            child: Container(
              width: 95.w,
              height: 15.h,
              decoration: BoxDecoration(
                // color: Color.fromRGBO(189, 189, 189, 1),
                borderRadius: BorderRadius.circular(25.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                    //Color.fromRGBO(211, 211, 211, 1),
                    //Color.fromRGBO(127, 140, 141, 1),
                  ],
                ),
              ),
              child: StatefulBuilder(
                builder: (_context, _setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _header,
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              'BIOMETRICS',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontFamily: 'Sans',
                                color: Colors.black,
                                //letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      /* CustomSwitch(
                        activeColor: Colors.green[600],
                        value: isSelected,
                        onChanged: (value) async {
                          await toggleState();
                          if (value == true) {
                            Fluttertoast.showToast(
                              msg: "Coming Soon ...",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              textColor: Colors.white,
                              fontSize: 12.sp,
                            );
                          }
                          _setState(() {});
                        },
                      ), */
                      Expanded(
                        child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(200 / 360),
                          child: SvgPicture.asset(
                            'assets/svg/fingerprint.svg',
                            color: Colors.black.withOpacity(opacity),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
