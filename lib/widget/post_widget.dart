import 'package:flutter/material.dart';
import 'package:insta_app/screens/comment_screen.dart';

class PostWidget extends StatelessWidget {
  final Map<String, dynamic> postMap;
  const PostWidget({super.key, required this.postMap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(postMap['userImage']),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    postMap['userName'],
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ],
              ),
            ),
            Image.network(
              postMap['imagePost'],
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.comment,
                      color: Colors.white,
                    ))
              ],
            ),
            Text(
              "280 Likes",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              postMap['description'],
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CommentScreen();
                  }));
                },
                child: Text(
                  "Add comment",
                  style: TextStyle(color: Colors.grey),
                )),
            Text(
              " 1 hr ago",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
