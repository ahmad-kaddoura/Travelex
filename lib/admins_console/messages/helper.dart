import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sizer/sizer.dart';
import 'package:travelex/admins_console/messages/message_structure.dart';

class MessageWall extends StatelessWidget {
  final List<QueryDocumentSnapshot>messages;
  final ValueChanged<String> onDelete;

  const MessageWall({Key key, this.messages, this.onDelete}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (context, index){
        return GestureDetector(
          onLongPress: () async{
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(
                    'Are you sure you want to delete this message ?',
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Sans',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "Cancel",
                        textScaleFactor: 1.0,
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {Navigator.of(context).pop();},
                    ),
                    TextButton(
                      child: Text(
                        "Delete",
                        textScaleFactor: 1.0,
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: (){
                        onDelete(messages[index].id);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: MessageStructure(
            index: index,
            data: messages[index].data(),
          ),
        );
      },
    );
  }
}
