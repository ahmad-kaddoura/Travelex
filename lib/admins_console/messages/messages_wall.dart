import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/admins_console/admins_home.dart';
import 'package:travelex/admins_console/messages/helper.dart';

class Messages extends StatefulWidget {
  final String collection;
  final String header;

  const Messages(this.collection,this.header);
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  void initState() {
    super.initState();
    loading = false;
  }
  void _deleteMessage(String docID) async{
      await FirebaseFirestore.instance.collection(widget.collection).doc(docID).delete();
  }
  bool loading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AdminsConsoleHome()));
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                CupertinoIcons.delete,
                color: Colors.black,
                size: 28,
              ),
              tooltip: 'Delete all messages',
              onPressed:() async{
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        'Are you sure you want to delete All messages ?',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          onPressed: () {Navigator.of(context).pop();},
                        ),
                        TextButton(
                          child: Text(
                            "Delete All",
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          onPressed: () async{
                            Navigator.of(context).pop();
                            setState(() {loading = true;});
                            var collection = FirebaseFirestore.instance.collection(widget.collection);
                            var snapshots = await collection.get();
                            for (var doc in snapshots.docs) {
                              await doc.reference.delete();
                            }
                            setState(() {loading = false;});
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
          title: Text(
            widget.header,
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
        body: loading == true ? SpinKitSpinningLines(
          color: Theme.of(context).primaryColor,
          size: 40.w,
        ) :
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(widget.collection)
              .orderBy('timestamp',descending: true)
              .snapshots(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData){
              return MessageWall(messages: snapshot.data.docs,onDelete: _deleteMessage,);
            }
            return Center(child: Text('No data yet'));
          },
        ),
      ),
    );
  }
}
