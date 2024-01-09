import 'package:flutter/material.dart';
import 'package:instagram_clone/Resources/auth_method.dart';
import 'package:instagram_clone/models/user.dart';

class Userprovider with ChangeNotifier {
  final Authmethod _authmethods = Authmethod();
  User? _user;
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authmethods.GetUserDetails();
    _user = user;
    notifyListeners();
  }
}
