import 'package:flutter/material.dart';
import 'home.dart';
import 'post.dart';
import 'search.dart';
import 'profile.dart';
import 'bookmark.dart';

//HOME PAGE
class RecipeBook extends StatefulWidget {
  @override
  State<RecipeBook> createState() => _RecipeBookState();
}

class _RecipeBookState extends State<RecipeBook> {
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
        child: Text("recipe book page"),
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
