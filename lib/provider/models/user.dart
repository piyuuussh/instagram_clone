import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String photoUrl;
  final String uid;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "photourl": photoUrl,
        "email": email,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
  static User fromjson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photourl'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      email: snapshot['email'],
    );
  }
}
