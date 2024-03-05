import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController postContentController = TextEditingController();
  File? pickImage;
  void selectImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      var selected = File(image.path);
      setState(() {
        pickImage = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    void uploadPost() async {
      try {
        final uuid = Uuid().v4();
        final ref = FirebaseStorage.instance
            .ref()
            .child('postsimage')
            .child('$uuid.jpg');
        await ref.putFile(pickImage!);
        final imageUrl = await ref.getDownloadURL();

        /* lesson  21.add like minute 3 we add 
        the likes key and add a uniqe id for the posts by uuid
*/
        FirebaseFirestore.instance.collection('posts').doc(uuid).set({
          'userName': userProvider.getUser!.userName,
          'uid': userProvider.getUser!.uId,
          'userImage': userProvider.getUser!.userImage,
          'imagePost': imageUrl,
          'postid': uuid,
          'description': postContentController.text,
          'likes':[]
        });

        setState(() {
          pickImage = null;
          postContentController.text = '';
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'done',
          style: TextStyle(color: Colors.black),
        )));
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.toString()!,
          style: TextStyle(color: Colors.black),
        )));
      }
      ;
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            pickImage = null;
                            postContentController.text = '';
                          });
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 26,
                        )),
                    Text(
                      "New post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          uploadPost();
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(fontSize: 22),
                        ))
                  ],
                ),
                pickImage == null
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      )
                    : Image.file(
                        pickImage!,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                Center(
                    child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: Icon(
                          Icons.upload,
                          color: Colors.white,
                        ))),
                TextFormField(
                    controller: postContentController,
                    maxLines: 15,
                    decoration: InputDecoration(
                        hintText: "Add Comment",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                            )))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
