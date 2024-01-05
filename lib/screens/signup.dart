import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/responses/Responssive_layout.dart';
import 'package:instagram_clone/responses/mobile_screen.dart';
import 'package:instagram_clone/responses/web_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_form.dart';
import 'package:instagram_clone/Resources/auth_method.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _Signupscreen();
}

class _Signupscreen extends State<Signupscreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectimg() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void SignUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authmethod().signup(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        username: _usernamecontroller.text,
        bio: _biocontroller.text,
        file: _image!);
    if (res != 'success') {
      showSnackBar(res, context);
      setState(() {
        _isLoading = false;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const RespossiveLayout(
              mobilescreenlayout: mobilescreenlayout(),
              webscreenlayout: webscreenlayout())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 64,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
              ),
              SizedBox(height: 24),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.vecteezy.com%2Ffree-vector%2Fdefault-profile-picture&psig=AOvVaw357HEw_kzP41i6Eu4psSEZ&ust=1704394206036000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPDt5K3xwYMDFQAAAAAdAAAAABAD')),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        icon: const Icon(Icons.add_a_photo_outlined),
                        onPressed: selectimg,
                      ))
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Textfieldinput(
                  textEditingController: _usernamecontroller,
                  hinttext: 'Enter Your Username',
                  textInputType: TextInputType.text),
              const SizedBox(height: 24),
              Textfieldinput(
                  textEditingController: _emailcontroller,
                  hinttext: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(height: 24),
              Textfieldinput(
                  textEditingController: _passwordcontroller,
                  hinttext: 'Enter Your Password',
                  textInputType: TextInputType.visiblePassword,
                  ispassword: true),
              const SizedBox(height: 24),
              Textfieldinput(
                  textEditingController: _biocontroller,
                  hinttext: 'Enter Your Bio',
                  textInputType: TextInputType.text),
              const SizedBox(height: 24),
              InkWell(
                onTap: SignUpUser,

                // onTap: () async {
                //   String res = await Authmethod().signup(
                //       email: _emailcontroller.text,
                //       password: _passwordcontroller.text,
                //       username: _usernamecontroller.text,
                //       bio: _biocontroller.text,
                //       file: _image!);
                // },
                child: Container(
                  child: _isLoading
                      ? Center(
                          child: const CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : Text("Sign Up"),
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
                height: 30,
              )
              // Flexible(
              //   child: Container(),
              //   flex: 2,
              //)
            ],
          ),
        ),
      )),
    );
  }
}
