import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_app/models/user_model.dart';
import 'package:insta_app/screens/bottm_bar.dart';
import 'package:insta_app/screens/log_in_screen.dart';
import 'package:uuid/uuid.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  File? pickImage;
  String? imageUrl;
  void selectImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      var selected = File(image.path);
      setState(() {
        pickImage = selected;
      });
    }
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpMethod() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      final uuid = Uuid().v4();
      final ref =
          FirebaseStorage.instance.ref().child('usersimage').child('$uuid.jpg');
      await ref.putFile(pickImage!);
      final imageUrl = await ref.getDownloadURL();

      UserModel userModel = UserModel(
          email: _emailController.text,
          password: _passwordController.text,
          userName: _nameController.text,
          userImage: imageUrl,
          uId: FirebaseAuth.instance.currentUser!.uid,
          followers: [],
          following: []);

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(userModel.toJson());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return BottomBar();
      }));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.toString()!,
        style: TextStyle(color: Colors.black),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Instagram-Logo-PNG-Free-Download.png',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Text(
                    "INSTGRAM",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  pickImage != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(pickImage!),
                          radius: 30,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://clipartcraft.com/images/instagram-logo-transparent-background-2.png"),
                          radius: 30,
                        ),
                  Positioned(
                      right: 25,
                      left: 25,
                      child: IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: Icon(Icons.add_a_photo_outlined))),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return " please enter your name";
                        },
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: "name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || !value!.contains('@'))
                            return "enter a valid email";
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: "email",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value!.length < 7)
                            return "please enter a valid password";
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {}, icon: Icon(Icons.visibility)),
                            hintText: "pass",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            )),
                      ),
                    ],
                  )),
              SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () {
                  _key.currentState!.save();
                  if (_key.currentState!.validate()) {
                    signUpMethod();
                  }
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 161, 215, 222)),
                  minimumSize: MaterialStateProperty.all(Size(300, 50)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return LogInScreen();
                    }));
                  },
                  child: Text("Already have an account? login")),
            ],
          ),
        ),
      ),
    ));
  }
}
