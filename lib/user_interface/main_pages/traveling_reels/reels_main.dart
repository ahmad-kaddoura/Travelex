/* import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/functions/controllers/settings_animation_controller.dart';
import 'package:travelex/user_interface/settings/settings.dart';
import 'package:video_player/video_player.dart';

class Reels extends StatefulWidget {
  const Reels({Key key}) : super(key: key);

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  VideoPlayerController vc;
  bool muted = false;

  @override
  void initState() {
    super.initState();
    vc = VideoPlayerController.network(
        'https://drive.google.com/file/d/1u4nNk8Ymux5psxdDcDMK23ux5lOAcRzy/view?usp=sharing')
      ..setLooping(true)
      ..initialize().then((value) {
        vc.play();
        vc.setVolume(1);
      });
    print('Init State Entered ... ... ... ... ... ...');
  }

  @override
  void dispose() {
    super.dispose();
    vc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [
                VideoPlayer(vc),
                VideoProgressIndicator(
                  vc,
                  allowScrubbing: false,
                  padding: EdgeInsets.only(top: 3, left: 10, right: 10),
                ),
                Positioned(
                  right: 10,
                  bottom: 100,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (muted == false) {
                            muted = true;
                            vc.setVolume(0);
                          } else {
                            muted = false;
                            vc.setVolume(1);
                          }
                        },
                        icon: muted == false
                            ? Icon(CupertinoIcons.volume_up)
                            : Icon(CupertinoIcons.volume_off),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            /* StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('reels').snapshots(),
                builder: (_, snapshot) {
                  bool muted = false;
                  if (snapshot.hasError)
                    return CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    );
                  if (snapshot.hasData) {
                    final docs = snapshot.data.docs;
                    return PageView.builder(
                      itemCount: docs.length,
                      controller:
                          PageController(initialPage: 0, viewportFraction: 1),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final data = docs[index].data();
                        print(data['url']);
                        vc = VideoPlayerController.network(data['url'])
                          ..setLooping(true)
                          ..initialize().then((value) {
                            vc.play();
                            vc.setVolume(1);
                          });
                        return /* vc != null && vc.value.isInitialized
                            ? */
                            GestureDetector(
                          onTap: () {
                            if (muted == false) {
                              muted = true;
                              vc.setVolume(0);
                              Fluttertoast.showToast(
                                msg: "Muted",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor:
                                    Color.fromRGBO(218, 228, 231, 0.5),
                                textColor: Colors.black,
                                fontSize: 12.sp,
                              );
                            } else {
                              muted = false;
                              vc.setVolume(1);
                              Fluttertoast.showToast(
                                msg: "UnMuted",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor:
                                    Color.fromRGBO(218, 228, 231, 0.5),
                                textColor: Colors.black,
                                fontSize: 13.3.sp,
                              );
                            }
                          },
                          onLongPress: () {},
                          child: Stack(
                            children: [
                              VideoPlayer(vc),
                              VideoProgressIndicator(
                                vc,
                                allowScrubbing: false,
                                padding: EdgeInsets.only(
                                    top: 3, left: 10, right: 10),
                              ),
                              Positioned(
                                right: 10,
                                bottom: 100,
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (muted == false) {
                                          muted = true;
                                          vc.setVolume(0);
                                        } else {
                                          muted = false;
                                          vc.setVolume(1);
                                        }
                                      },
                                      icon: muted == false
                                          ? Icon(CupertinoIcons.volume_up)
                                          : Icon(CupertinoIcons.volume_off),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                        /* : Center(
                                child: CircularProgressIndicator(
                                    color: Colors.amber),
                              ); */
                      },
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.red,
                    ));
                  }
                }), */
          ),
          Functions.instance.getReverseStatus() == false
              ? Positioned(
                  top: 18,
                  child: SlideInLeft(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()));
                        },
                        child: GestureDetector(
                          onTap: () {
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
                  ),
                )
              : Positioned(
                  top: 18,
                  child: SlideInRight(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SvgPicture.asset(
                        'assets/svg/options.svg',
                        color: Theme.of(context).primaryColor,
                        width: 5.w,
                        height: 5.w,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
 */