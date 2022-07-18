import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'functions/controllers/bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  /*  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return AdaptiveTheme(
          //light mode
          light: ThemeData(
            primaryColor: const Color.fromRGBO(17, 45, 78, 1),
            scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color.fromRGBO(63, 114, 175, 1),
              background: const Color.fromRGBO(219, 226, 239, 1),
            ),
          ),
          //dark mode
          dark: ThemeData(
            primaryColor: const Color.fromRGBO(175, 142, 181, 1),
            scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color.fromRGBO(225, 190, 231, 1),
              background: const Color.fromRGBO(255, 241, 255, 1),
            ),
          ),
          initial: AdaptiveThemeMode.light,
          builder: (theme, darkTheme) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darkTheme,
            home: Nav(),
          ),
        );
      }),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return AdaptiveTheme(
        //light mode
        light: ThemeData(
          primaryColor: const Color.fromRGBO(17, 45, 78, 1),
          scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color.fromRGBO(63, 114, 175, 1),
            background: const Color.fromRGBO(219, 226, 239, 1),
          ),
        ),
        //dark mode
        dark: ThemeData(
          primaryColor: const Color.fromRGBO(175, 142, 181, 1),
          scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color.fromRGBO(225, 190, 231, 1),
            background: const Color.fromRGBO(255, 241, 255, 1),
          ),
        ),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          home: Nav(),
        ),
      );
    });
  }
}
