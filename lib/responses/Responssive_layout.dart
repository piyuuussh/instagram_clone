import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instagram_clone/dimensions/global_variables.dart';

class RespossiveLayout extends StatelessWidget {
  final Widget webscreenlayout;
  final Widget mobilescreenlayout;
  const RespossiveLayout({
    Key? key,
    required this.webscreenlayout,
    required this.mobilescreenlayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth > webscreensize) {
        //webscreen layout
        return webscreenlayout;
      }
      //mobile screen layout
      return mobilescreenlayout;
    });
  }
}
