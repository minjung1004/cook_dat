import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_dat/widgets/profile_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'post.dart';
import 'bookmark.dart';
import 'search.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> _postStream =
      FirebaseFirestore.instance
          .collection('posts')
          .doc(FirebaseAuth.instance.currentUser!.uid) // change to postID
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'COOK\'DAT',
          style: TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: _postStream,
          builder: ((BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ProfileItems(snap: snapshot.data!);
          })),
      //ProfileItems(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Spacer(),
            // home
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                icon: Icon(Icons.home)),
            Spacer(),
            // search
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                icon: Icon(Icons.search)),
            Spacer(),
            // recipe post
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostPage()),
                  );
                },
                icon: Icon(Icons.restaurant_menu)),
            Spacer(),
            // saved
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookMarkPage()),
                  );
                },
                icon: Icon(Icons.bookmark)),
            Spacer(),
            // profile
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                icon: Icon(Icons.person_sharp)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
