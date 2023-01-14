import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'post.dart';
import 'bookmark.dart';
import 'profile.dart';

//HOME PAGE
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
      body: Center(
        child: Text('search page'),
      ),
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
