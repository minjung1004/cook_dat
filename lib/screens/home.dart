import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'search.dart';
import 'post.dart';
import 'bookmark.dart';
import 'profile.dart';
import 'package:cook_dat/widgets/postcard.dart';

//HOME PAGE
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => PostCard(
                    snap: snapshot.data!.docs[index].data(),
                    // snap2: snapshot.data!.docs[index].data(),
                  ));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Spacer(),
            // home
            IconButton(
                onPressed: () {
                  setState(() {});
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
