import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Resources/auth_method.dart';
import 'package:instagram_clone/responses/Responssive_layout.dart';
import 'package:instagram_clone/responses/mobile_screen.dart';
import 'package:instagram_clone/responses/web_screen.dart';
import 'package:instagram_clone/screens/signup.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_form.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void NavigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Signupscreen()));
  }

  void loginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text);

    if (res == "seccess") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const RespossiveLayout(
              mobilescreenlayout: mobilescreenlayout(),
              webscreenlayout: webscreenlayout())));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
            ),
            const SizedBox(
              height: 64,
            ),
            Textfieldinput(
                textEditingController: _emailcontroller,
                hinttext: 'Enter Your Email',
                textInputType: TextInputType.emailAddress),
            const SizedBox(height: 24),
            Textfieldinput(
              textEditingController: _passwordcontroller,
              hinttext: 'Enter Your Password',
              textInputType: TextInputType.visiblePassword,
              ispassword: true,
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: loginUser,
              child: Container(
                child: _isloading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor))
                    : Text("Log in"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  color: blueColor,
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Flexible(child: Container(), flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Don't have any account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                InkWell(
                  onTap: NavigateToSignup,
                  child: Container(
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
