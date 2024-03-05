import 'package:flutter/material.dart';
import 'package:insta_app/provider/provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height! * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        NetworkImage(userProvider.getUser!.userImage),
                  ),
                  Column(
                    children: [
                      Text(
                        " 4 ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        " Post ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        " 11 ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        " Followers ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        " 25 ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        " Following ",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  userProvider.getUser!.userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 3,
              ),
              GridView.count(
                crossAxisCount: 3,
                children: List.generate(
                    5,
                    (index) => Image.network(
                        "https://clipartcraft.com/images/instagram-logo-transparent-background-2.png")),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 5 / 3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
