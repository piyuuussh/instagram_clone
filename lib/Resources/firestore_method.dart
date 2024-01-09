import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/Resources/storage_methods.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:uuid/uuid.dart';

class firestoremethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload a post
  Future<String> uploadImg(String uid, Uint8List file, String description,
      String username, String profImage) async {
    String res = "Some error occured";
    try {
      String photoUrl =
          await storagemethods().UploadImgToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          postId: postId,
          username: username,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'Success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
