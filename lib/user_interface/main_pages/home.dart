import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:sizer/sizer.dart';
import 'package:country_picker/country_picker.dart';
import 'package:travelex/user_interface/settings/settings.dart';
import '../../functions/functions.dart';
import '../../functions/database/database.dart';
import '../../functions/classes/visit_object.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:sqflite/sqflite.dart';
import '../../widgets/home_widgets/visited_city.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  MapShapeSource _shapeSource;
  MapZoomPanBehavior _zoomPanBehavior;
  bool _showLabels = false;
  List<Visit> _mapData;
  int _totalVisits;
  bool masculine;
  List<String> _continentsList = [
    'All',
    'Europe',
    'Asia',
    'Africa',
    'N. America',
    'S. America'
  ];
  List<String> _continentsCode = [
    'EU',
    'AS',
    'AF',
    'NA',
    'SA',
  ];
  List<int> _continentCityCount = [
    195,
    44,
    48,
    54,
    23,
    12,
  ];
  int index = 0;
  String _continent;

  // Use temp variable to only update color when press dialog 'submit' button
  ColorSwatch _tempMainColor;
  Color _tempShadeColor;

  //_mainColor is the color used on the map
  Color _mainColor = Colors.green[400];
  Color _shadeColor = Colors.green[800];

  // This key is used for the RepaintBoundary widget
  //final GlobalKey _key = GlobalKey();

  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _continent = _continentsList[0];
    //DatabaseHelper.instance.printDatabase();
    getMapColor();
    getColorScheme();
    _zoomPanBehavior = MapZoomPanBehavior(
      enableDoubleTapZooming: true,
      maxZoomLevel: 10,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getColorScheme() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    masculine = prefs.getBool('themeData');
    if (masculine == null) {
      prefs.setBool('themeData', true);
      masculine = true;
    } else {}
  }

/*  void toggleColorScheme() async{
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(masculine == true){
      masculine = false;
      prefs.setBool('themeData', false);
      await AdaptiveTheme.of(context).toggleThemeMode();
    }
    if(masculine == false){
      masculine = true;
      prefs.setBool('themeData', true);
      await AdaptiveTheme.of(context).toggleThemeMode();
    }
  }*/
  void getMapColor() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String s = prefs.getString('MapColor');
    if (s == null) s = _mainColor.toString();
    String valueString = s.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    //print('getting color from memory $_mainColor' );
    setState(() {
      _mainColor = Color(value);
    });
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            TextButton(
              child: Text(
                'Done',
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
              onPressed: () async {
                WidgetsFlutterBinding.ensureInitialized();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('MapColor', _tempMainColor.toString());
                //print('Color Saved is : ' + prefs.getString('MapColor'));

                setState(() {
                  _mainColor = _tempMainColor;
                  _shadeColor = _tempShadeColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Change Map Color",
      MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        onColorChange: (color) {
          _tempShadeColor = color;
        },
        onMainColorChange: (color) {
          _tempMainColor = color;
        },
        onBack: () {},
      ),
    );
  }

  Future<void> setMapData() async {
    var db = await DatabaseHelper.instance.database;
    var visits = await db.query('mainDatabase');
    _mapData =
        visits.isNotEmpty ? visits.map((c) => Visit.fromMap(c)).toList() : [];
    if (_mapData.isNotEmpty) {
      _shapeSource = MapShapeSource.asset('assets/geo_json/world.json',
          shapeDataField: 'name',
          dataCount: _mapData.length,
          primaryValueMapper: (int index) => _mapData[index].cityName,
          shapeColorValueMapper: (int index) => _mainColor);
    } else {
      _shapeSource = const MapShapeSource.asset('assets/geo_json/world.json');
    }
  }

  Future<void> getTotalVisits() async {
    var db = await DatabaseHelper.instance.database;
    var x = await db.rawQuery('SELECT COUNT (*) from mainDatabase ');
    _totalVisits = Sqflite.firstIntValue(x);
  }

  Future<void> getConditionalVisits(String ct) async {
    var db = await DatabaseHelper.instance.database;
    var x = await db.rawQuery(
        'SELECT COUNT (*) from mainDatabase WHERE continent = ? ', [ct]);
    _totalVisits = Sqflite.firstIntValue(x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: WaveClipperTwo(),
                        child: Container(
                          width: 100.w,
                          height: 15.h,
                          color: Theme.of(context).colorScheme.background,
                        ),
                      ),
                      Positioned(
                        //70 to 100
                        left: 85,
                        //10 to 5
                        top: 10,
                        child: Text(
                          'Travelex',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            shadows: [
                              Shadow(
                                blurRadius: 20.0,
                                color: Theme.of(context).colorScheme.secondary,
                                offset: Offset(5, 5),
                              ),
                            ],
                            fontFamily: 'Curvs',
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: FutureBuilder(
                      future: setMapData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Stack(
                            children: [
                              Screenshot(
                                controller: screenshotController,
                                child: Container(
                                  color: Colors.white,
                                  child: SfMaps(
                                    layers: [
                                      MapShapeLayer(
                                        //color: Colors.grey[350],
                                        source: _shapeSource,
                                        zoomPanBehavior: _zoomPanBehavior,
                                        showDataLabels: _showLabels,
                                        loadingBuilder: (BuildContext context) {
                                          return Lottie.asset(
                                            'assets/animations/globe.json',
                                            width: 60.w,
                                            height: 60.w,
                                          );
                                          //return SpinKitRipple(color: Theme.of(context).primaryColor, size: 25.w,);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -10,
                                right: 10,
                                child: IconButton(
                                  onPressed: () {
                                    //reset zooming
                                    _zoomPanBehavior.reset();
                                  },
                                  icon: Icon(
                                    CupertinoIcons.zoom_out,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SpinKitRipple(
                            color: Theme.of(context).primaryColor,
                            size: 25.w,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: StatefulBuilder(
                      builder: (_context, _setState) {
                        bool _selectedContinent;
                        return Container(
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: index > 0
                                    ? getConditionalVisits(
                                        _continentsCode[index - 1])
                                    : getTotalVisits(),
                                builder: (_context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 40),
                                              child: new FloatingActionButton(
                                                heroTag: "btn1",
                                                onPressed: () {
                                                  if (index > 0) {
                                                    _setState(() {
                                                      index--;
                                                      _continent =
                                                          _continentsList[
                                                              index];
                                                    });
                                                  } else {}
                                                },
                                                child: Icon(
                                                  Icons.arrow_back_ios_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                backgroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                elevation: 0,
                                              ),
                                            ),
                                            Stack(
                                              children: [
                                                CircularStepProgressIndicator(
                                                  totalSteps:
                                                      _continentCityCount[
                                                          index],
                                                  currentStep: _totalVisits,
                                                  stepSize: 7,
                                                  selectedColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  unselectedColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .background,
                                                  padding: 0,
                                                  width: 33.w,
                                                  height: 33.w,
                                                  selectedStepSize: 7,
                                                  roundedCap: (_, __) => true,
                                                ),
                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Text(
                                                          'Total Visits',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            fontSize: 13.5.sp,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                        Text(
                                                          _continent,
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            fontSize: 11.5.sp,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 40),
                                              child: new FloatingActionButton(
                                                heroTag: "btn2",
                                                onPressed: () {
                                                  if (index <
                                                      _continentsList.length -
                                                          1) {
                                                    _setState(() {
                                                      index++;
                                                      _continent =
                                                          _continentsList[
                                                              index];
                                                    });
                                                  } else {}
                                                },
                                                child: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                backgroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                elevation: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            '$_totalVisits / ${_continentCityCount[index]}',
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                      height: 80,
                                      width: 90.w,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 0, 0, 0),
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            for (int i = 0;
                                                i < _continentsList.length;
                                                i++)
                                              GestureDetector(
                                                  onTap: () {
                                                    _setState(() {
                                                      _continent =
                                                          _continentsList[i];
                                                      index = i;
                                                      _selectedContinent = true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 30),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 5,
                                                          height: 5,
                                                          decoration: BoxDecoration(
                                                              color: index == i
                                                                  ? _mainColor
                                                                  : Color
                                                                      .fromRGBO(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          0),
                                                              shape: BoxShape
                                                                  .circle),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          _continentsList[i],
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontFamily:
                                                                'Poppins',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            SizedBox(
                                              width: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              FutureBuilder<List<Visit>>(
                                future: index > 0
                                    ? DatabaseHelper.instance.conditionalVisits(
                                        _continentsCode[index - 1])
                                    : DatabaseHelper.instance.getVisits(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Visit>> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ));
                                  }
                                  List<Visit> tmplist = snapshot.data;
                                  //or return column without sizedbox or sized box height 40.h with list view child
                                  return Column(
                                    children: [
                                      for (int index = 0;
                                          index < tmplist.length;
                                          index++)
                                        Padding(
                                          key: Key('$index'),
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                              onLongPress: () async {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: Text(
                                                          'Are you sure you want to delete visit ?',
                                                          textScaleFactor: 1.0,
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: 0.5,
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text(
                                                              "Cancel",
                                                              textScaleFactor:
                                                                  1.0,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'Poppins'),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: Text(
                                                              "Delete",
                                                              textScaleFactor:
                                                                  1.0,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontFamily:
                                                                      'Poppins'),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await DatabaseHelper
                                                                  .instance
                                                                  .deleteRecordFromMainDb(
                                                                      tmplist[
                                                                          index]);
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg: "Deleted",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .SNACKBAR,
                                                                backgroundColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 12.sp,
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              setState(() {});
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: VisitedCity(
                                                  tmplist[index].cityCode,
                                                  tmplist[index].cityName,
                                                  tmplist[index])),
                                        ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
              Positioned(
                top: 18,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()));
                    },
                    child: SvgPicture.asset(
                      'assets/svg/options.svg',
                      color: Theme.of(context).primaryColor,
                      width: 5.w,
                      height: 5.w,
                    ),
                  ),
                ),
              ),
              /*Positioned(
                top: 5,
                right: 10,
                child: IconButton(
                  onPressed: () async{
                    toggleColorScheme();
                  },
                  icon: masculine == true ?
                  Icon(CupertinoIcons.brightness_solid, color: Theme.of(context).primaryColor, size: 30,) :
                  Icon(CupertinoIcons.brightness, color: Theme.of(context).primaryColor, size: 30,)
                ),
              ),*/
            ],
          ),
        ),
        floatingActionButton: FabCircularMenu(
            ringColor: Theme.of(context).colorScheme.background,
            fabColor: Theme.of(context).primaryColor,
            ringDiameter: 300,
            ringWidth: 75,
            fabSize: 55,
            fabElevation: 0,
            fabOpenIcon: const Icon(Icons.all_inclusive,
                color: Color.fromRGBO(249, 247, 247, 1)),
            fabCloseIcon: const Icon(Icons.close,
                color: Color.fromRGBO(249, 247, 247, 1)),
            children: <Widget>[
              //dummy icon
              IconButton(
                icon: const Icon(Icons.error_outline),
                color: const Color.fromRGBO(255, 255, 255, 0),
                iconSize: 1,
              ),
              IconButton(
                  icon: const Icon(Icons.color_lens_sharp),
                  color: Theme.of(context).primaryColor,
                  iconSize: 30,
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: "Customize Your Map",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      textColor: Colors.white,
                      fontSize: 12.sp,
                    );
                    _openColorPicker();
                  }),
              IconButton(
                icon: const Icon(CupertinoIcons.share_up),
                color: Theme.of(context).primaryColor,
                iconSize: 30,
                onPressed: () async {
                  Fluttertoast.showToast(
                    msg: "Please wait ... ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    textColor: Colors.white,
                    fontSize: 12.sp,
                  );
                  await screenshotController
                      .capture()
                      .then((Uint8List image) async {
                    if (image != null) {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final imagePath =
                          await File('${directory.path}/image.png').create();
                      await imagePath.writeAsBytes(image);
                      // Share Plugin
                      await Share.shareFiles([imagePath.path],
                          text: 'Check out my world map !');
                    } else {
                      Fluttertoast.showToast(
                        msg: "Error, Please try again later ... ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        fontSize: 12.sp,
                      );
                    }
                  });
                },
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.airplane),
                color: Theme.of(context).primaryColor,
                iconSize: 31,
                onPressed: () async {
                  Fluttertoast.showToast(
                    msg: "Add a Visit",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.SNACKBAR,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    textColor: Colors.white,
                    fontSize: 12.sp,
                  );
                  showCountryPicker(
                    context: context,
                    //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                    exclude: <String>['KN', 'MF'],
                    //Optional. Shows phone code before the country name.
                    showPhoneCode: false,
                    onSelect: (Country country) async {
                      var res = await DatabaseHelper.instance
                          .findRecordInMainDb(country.name);
                      if (res == true) {
                        await DatabaseHelper.instance.addMainDb(Visit(
                          cityName: country.name,
                          cityCode: country.countryCode,
                          continent: getContinent(country.countryCode),
                        ));
                        _mapData.add(
                          Visit(cityName: country.name),
                        );
                        setState(() {
                          _zoomPanBehavior.reset();
                        });
                      }
                    },
                    // Optional. Sets the theme for the country list picker.
                    countryListTheme: const CountryListThemeData(
                      // Optional. Sets the border radius for the bottomsheet.
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      // Optional. Styles the search field.
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ]));
  }

  @override
  bool get wantKeepAlive => true;
}
