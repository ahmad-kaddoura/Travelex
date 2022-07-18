import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/widgets/settings_/form_blueprint/card_blueprint.dart';

class CryptoSupport extends StatelessWidget {
  const CryptoSupport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: 'tag',
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Color.fromRGBO(211, 211, 211, 1),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Only Send USDT on Tron (TRC20) network to the following address.',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'TS97A3duPmuv2jixYQnY9GFs2EK5oH6LML',
                        textScaleFactor: 1.0,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                                text: 'TS97A3duPmuv2jixYQnY9GFs2EK5oH6LML'))
                            .then((value) => Fluttertoast.showToast(
                                  msg: "Copied To Clipboard",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  textColor: Colors.white,
                                  fontSize: 13.sp,
                                ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/usdt.png'),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Copy Address',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
