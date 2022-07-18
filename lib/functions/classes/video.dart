import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String caption;
  String url;

  Video({
    this.caption,
    this.url,
  });

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "url": url,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      caption: snapshot['caption'],
      url: snapshot['url'],
    );
  }
}
