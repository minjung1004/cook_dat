//import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cook_dat/screens/book.dart';

class ProfileItems extends StatefulWidget {
  final snap;
  const ProfileItems({
    Key? key,
    required this.snap,
  });

  @override
  State<ProfileItems> createState() => _ProfileItemsState();
}

class _ProfileItemsState extends State<ProfileItems> {
  int numRecipe = 0;
  int followers = 0;
  int following = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   getData().then((value) {
  //     numRecipe = int.parse(value);
  //   });
  // }

  // getData() async {
  //   var recipeSnap = await FirebaseFirestore.instance
  //       .collection('posts')
  //       .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   numRecipe = recipeSnap.docs.length;

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/profile.webp'),
              radius: 40,
            ),
            const Spacer(),
            buildStatColumn(numRecipe, "Recipes"),
            const Spacer(),
            buildStatColumn(followers, "Followers"),
            const Spacer(),
            buildStatColumn(following, "Following"),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 5, top: 10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.snap['username']
                  .toString(), //this will get an error if you dont have a post, but once you have at least one post everything is fine
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5, top: 10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.snap['fullname'].toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        Row(
          children: [
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.grid_on_sharp)),
            Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecipeBook()),
                  );
                },
                icon: Icon(Icons.menu_book)),
            Spacer(),
          ],
        ),
        const Divider(),
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('uid',
                    isEqualTo: FirebaseAuth
                        .instance.currentUser!.uid) // change to postID
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 1.5,
                    childAspectRatio: 1),
                itemBuilder: (context, index) {
                  DocumentSnapshot snap =
                      (snapshot.data! as dynamic).docs[index];
                  return Container(
                    child: Image(
                      image: NetworkImage(snap['photoUrl']),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }),
      ]),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            )),
      ],
    );
  }
}
