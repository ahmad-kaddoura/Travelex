import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/widgets/discover_widgets/city.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class CitiesFireBaseList extends StatelessWidget {
  final String _collection;
  final bool isAdmin;
  CitiesFireBaseList(this._collection, this.isAdmin);

  void _deleteDoc(String collection, String docID) async {
    await FirebaseFirestore.instance.collection(collection).doc(docID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            _collection == null ? 'loading' : _collection,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              letterSpacing: 1,
              fontSize: 17.sp,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection(_collection)
                    .snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasError)
                    return CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    );

                  if (snapshot.hasData) {
                    final docs = snapshot.data.docs;
                    return AnimationLimiter(
                      child: ListView.builder(
                        itemCount: docs.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          final data = docs[i].data();
                          final docId = docs[i].id;
                          return AnimationConfiguration.staggeredList(
                            position: i,
                            duration: const Duration(milliseconds: 1200),
                            child: SlideAnimation(
                              verticalOffset: 75.0,
                              child: FadeInAnimation(
                                child: Center(
                                    child: City(
                                  data['cityName'],
                                  data['imgUrl'],
                                  this.isAdmin,
                                  docId,
                                  this._collection,
                                  data['streetView'],
                                  data['location'],
                                  data['img1'],
                                  data['img2'],
                                  data['img3'],
                                  data['img4'],
                                  data['img5'],
                                  data['img6'],
                                  data['img7'],
                                  data['img8'],
                                  data['img9'],
                                  data['img10'],
                                )),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                        child: SpinKitRipple(
                      color: Theme.of(context).primaryColor,
                      size: 25.w,
                    ));
                  }
                },
              ),
            ),
            //Add a city to the relevant list in firebase
            isAdmin == true
                ? Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () {},
                      tooltip: 'Add a City',
                      child: Icon(
                        Icons.add,
                        size: 25.sp,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
