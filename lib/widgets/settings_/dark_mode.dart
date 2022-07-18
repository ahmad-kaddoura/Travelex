import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class DarkMode extends StatefulWidget {
  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  bool isSelected;
  String _header;
  double opacity;

  Future<void> getState() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _header = prefs.getString('DmHeader');
    isSelected = prefs.getBool('DmStat');
    if (_header == null) {
      prefs.setString('DmHeader', 'Disabled');
      prefs.setBool('DmStat', false);
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
      AdaptiveTheme.of(context).setDark();
      prefs.setString('DmHeader', 'Enabled ');
      prefs.setBool('DmStat', true);
      _header = 'Enabled ';
      isSelected = true;
      opacity = 1;
    } else {
      AdaptiveTheme.of(context).setLight();
      prefs.setString('DmHeader', 'Disabled');
      prefs.setBool('DmStat', false);
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
              await toggleState();
              setState(() {});
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
                    //Color.fromRGBO(211, 211, 211, 1),
                    //Color.fromRGBO(127, 140, 141, 1),
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.secondary.withOpacity(0.7),
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
                              'Click To Change Theme',
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
                        width: 0,
                      ),
                      /* CustomSwitch(
                        activeColor: Theme.of(context).primaryColor,
                        value: isSelected,
                        onChanged: (value) async{
                          await toggleState();
                          _setState((){});
                        },
                      ), */
                      Expanded(
                        child: RotationTransition(
                          turns: new AlwaysStoppedAnimation(0 / 360),
                          child: SvgPicture.asset(
                            'assets/svg/drop.svg',
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(opacity),
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
